Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264970AbUGAM7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbUGAM7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 08:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUGAM7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 08:59:32 -0400
Received: from mailgate.internet.lu.0.218.195.in-addr.arpa ([195.218.0.131]:50194
	"EHLO LUXEMBOU-OFCR7X.mailgate.internet.lu") by vger.kernel.org
	with ESMTP id S265022AbUGAM73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 08:59:29 -0400
From: Gilles Schintgen <gschintgen@internet.lu>
To: linux-kernel@vger.kernel.org
Date: Thu, 1 Jul 2004 14:58:40 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Cc: Sascha Wilde <wilde@sha-bang.de>
Subject: Kernel 2.6.x reboot hangs on AMD Athlon System
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011458.40831.gschintgen@internet.lu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My computer always hangs on reboot when I'm using a 2.6.x kernel. There 
was already such a thread on the LKML but no solution was found.
http://lkml.org/lkml/2004/4/4/75
http://lkml.org/lkml/2004/3/12/248 (longer description)

Problem:
--------
When using 2.6.x my machine always locks up at reboot. This is the case 
for both a regular shutdown -r now and also by SysRq. I tested this 
with kernels 2.6.2, 2.6.5, 2.6.6, and 2.6.7. The lockup occurs right at 
the end, just before the machine would normally reboot. Kernels 2.4.x 
don't have this problem.

What is interesting about it, is that rebooting always worked fine with 
2.6.0, 2.6.2 and 2.6.5. The problem only appeared about the same time I 
first compiled hardware sensors support. I'm not 100% sure about the 
exact time, but I noticed it soon after I changed my kernel 
configuration to include i2c support (with the w83781d and eeprom 
modules). Is it possible that such a module could change some 
persistent hardware state?

After that, I tried with my old 2.6.2 kernel (which didn't include i2c 
support at all). It could no longer reboot.
I then compiled a very basic i386-compatible 2.6.7 kernel with only 
generic drivers (no Irongate-IDE etc.). Same problem.
A 2.6.x-based SuSE 9.1 LiveCD has the same problem. Older 2.4.x-based 
Knoppix-CDs reboot without a hitch.
A FreeBSD 4.5 Installation CD can also reboot.

Hardware:
---------
CPU: AMD Athlon(tm) Processor 700MHz Stepping 1
Motherboard: BIOSTAR M7MKA (Irongate)
BIOS: Award BIOS, 12/23/1999
The author of the aforementioned thread also has an Irongate-based 
motherboard.

Software:
---------
Gentoo
gcc 3.3.3
glibc 2.3.2
binutils 2.14.90.0.8

I don't know what other information could be useful.
I would appreciate it very much if anyone could give me some hints on 
what else to try.

Please CC me in any reply, I'm not subscribed to the LKML.

Regards,
Gilles
