Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266130AbUGEQHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266130AbUGEQHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 12:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUGEQHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 12:07:07 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:35589 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266130AbUGEQHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 12:07:04 -0400
Subject: 2.6.7-mm6 USB locking problems
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Mon, 05 Jul 2004 18:06:57 +0200
Message-Id: <1089043617.1933.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have had to revert usb-locking-fix.patch and bk-usb.patch from 2.6.7-
mm6 as they are preventing my laptop for either suspending to RAM or
hibernating to disk (via swsusp).

Doing "echo -n mem > /sys/power/state" fails with:

PM: Preparing system for suspend
Stopping tasks: ==============
 stopping tasks failed (1 tasks remaining)
Restarting tasks...<6> Strange, khubd not stopped
 done

The same happens when trying "echo 4 > /proc/acpi/sleep".
Reverting both patches fixes the problem.
Thanks!

