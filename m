Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTL1CgJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbTL1CgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:36:08 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:28877 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264933AbTL1CeI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:34:08 -0500
Message-ID: <173c01c3cceb$07352490$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0 swsusp
Date: Sun, 28 Dec 2003 11:33:12 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with working ACPI, I compiled 2.6.0 with Software Suspend
(Experimental).

1.  Help information says that the next boot can be done with
"resume=/dev/swappartition" or with "noresume".  It does not say how the
swsusp command decides which swap partition to save to.  The man page (which
still isn't sure if the command is named swsusp or suspend) also doesn't
say.  How can I guess which swap partition to designate at resume time?  For
the moment this is a hypothetical question because I haven't needed to make
a second swap partition on this machine yet.

2.  When I forgot to say either "resume" or "noresume", the kernel detected
that it could not use the swap partition, but it did not offer the
possibility to resume.  Surely it could detect early enough that the swap
partition is not usable for swap but is usable for resume, and could ask the
user whether to do a "resume" or "noresume".

3.  When swsusp completed its writing, it decided that my ACPI BIOS could
not power off automatically.  I wonder why.  No other OS has trouble
powering off this machine.  Also on machines with older APM BIOSes, no OS
had trouble powering off the machines, not even Linux with APM drivers.  So
I could hold the power switch for 4 seconds and the BIOS beeped a warning
before powering off, but I wonder why it was necessary.

By the way on this machine, the keyboard's hotkey Fn+F7 correctly causes
hibernation performed by the BIOS, and Fn+F10 correctly causes suspend to
RAM.  In both cases the power key correctly causes a resume, with resume
from hibernation being done by the BIOS.  Even though this is an ACPI
machine, the BIOS still has hibernation (using a dedicated partition)
because it was originally sold with Windows 98.  On my previous crash box
with APM, hotkeys Fn+F7 and Fn+F10 (and others) got broken by 2.6.0-test
kernels and could only be fixed by booting 2.4.nn kernels.  Since I sold my
previous crash box, I can't check if 2.6.0 solved that breakage or if APM
still necessitates using 2.4.20.

