Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTJUWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 18:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbTJUWD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 18:03:56 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37893 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263365AbTJUWDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 18:03:06 -0400
Subject: 2.6.0-test8-mm1: ACPI S3 suspend works unrealiably
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1066773771.866.67.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Wed, 22 Oct 2003 00:02:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having problems with ACPI S3 on my laptop. Sometimes, I can resume
from standby, but other times, it simply hangs or reboots while
resuming.

When trying to suspend by using "echo 3 > /proc/acpi/sleep", something
strange occurs most of the time. Sometimes, when the system enters S3, I
can hear my hard drive make a "click". This "click" is exactly the same
I can hear when the system shuts down and parks the hard disk heads. If,
while suspending to S3, I hear this typical "click" sound then,
systematically, the system is then unable to resume from suspend,
usually getting frozen with a black screen showing "Stopping tasks:"
message, or simply by rebooting.

However, other times, forcing the system into S3 does not produce the
click sound, but instead, I can hear how the hard drive stops spinning
gradually (but no "click"). Whenever this happens, the system is able to
resume from suspend with no problems at all.

At first, I though the system was unable to resume due to conflicting
modules (like UHCI-HCD, YMFPCI or the CardBus drivers). I have tried
nearly every combination, and even tried unloading every loaded module
with no result. So, this leads me to think that, sometimes, when
entering S3, the hard drive is shut down and, when resuming, the kernel
is unable to spin the hard drive up and so hangs. Thus, it seems that
sometimes the hard drive is incorrectly spun down when entering S3.

Any ideas? How can I be sure this is the culprit of my problems?

Thanks!

