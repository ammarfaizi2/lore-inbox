Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUHWEFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUHWEFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 00:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUHWEFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 00:05:50 -0400
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:61092 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S267356AbUHWEFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 00:05:48 -0400
Subject: PROBLEM: Linux system clock is running 3x too fast
From: Fast Clock <fastclock@earthlink.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093233957.3094.49.camel@apc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 23:05:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My Athlon 64 laptop (HP Pavilion zv5000z) dual-boots Linux and Windows
XP. The Windows system clock is running accurately but the Linux system
clock is running 3 times too fast.

The problem occurs in all of the Linux distributions and releases that
I've tried, including Suse 9.1, Fedora Core 1 & 2, kernel versions
2.4.x, 2.6.x (up to 2.6.8-1.521), 32-bit & 64-bit releases.

The Linux system clock problem is also intermittent. Approximately 1 of
10 (cold) boots could yield an accurately running Linux system clock...
I've tried kernel boot options "clock=tsc", "clock=pit", "clock=pmtmr"
and have seen about the same 1/10 (failed/passed) ratio for each of
them. I've also tried kernel boot options "acpi=on" & "acpi=off" but
they don't seem to have any affect on the problem.

The differences in dmesg outputs between "good" and "bad" boots are as
followed.

good:	time.c: Detected 797.952 MHz processor.
bad:	time.c: Detected 265.995 MHz processor.

good:	Calibrating delay loop... 1576.96 BogoMIPS
bad:	Calibrating delay loop... 516.09 BogoMIPS

good:	Detected 12.468 MHz APIC timer.
bad:	Detected 4.156 MHz APIC timer.

good:	intel8x0_measure_ac97_clock: measured 49383 usecs
	intel8x0: clocking to 47408
bad:	intel8x0_measure_ac97_clock: measured 48347 usecs
	intel8x0: measured clock 16547 rejected
	intel8x0: clocking to 48000

Full dmesg logs (goods and bads) are available upon request.

