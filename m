Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUAKDRr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUAKDRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:17:47 -0500
Received: from [130.57.169.10] ([130.57.169.10]:39575 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S265736AbUAKDRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:17:45 -0500
Subject: Re: Laptops & CPU frequency
From: Robert Love <rml@ximian.com>
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040111025623.GA19890@ncsu.edu>
References: <20040111025623.GA19890@ncsu.edu>
Content-Type: text/plain
Message-Id: <1073791061.1663.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 10 Jan 2004 22:17:41 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-01-10 at 21:56, jlnance@unity.ncsu.edu wrote:

>     The frequency displayed in /proc/cpuinfo does not change if the AC
> adapter is toggled on or off after the machine has booted.  It stays
> in the same mode as it was booted into.  I am curious if this is because
> the CPU frequency really is not changing, or if it is because the
> number in /proc/cpuinfo is only calculated at boot.

The MHz value in /proc/cpuinfo should be updated as the CPU speed
changes - that is, it is not calculated just at boot, but it is updated
as the speed actually changes.

You probably have some issue in your power management scripts - Fedora
should scale the CPU speed back as soon as you remove AC power, not just
at boot if not on AC.

	Robert Love


