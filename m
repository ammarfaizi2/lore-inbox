Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267271AbUHDGAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267271AbUHDGAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 02:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUHDGAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 02:00:09 -0400
Received: from web14923.mail.yahoo.com ([216.136.225.7]:61529 "HELO
	web14923.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267271AbUHDGAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 02:00:03 -0400
Message-ID: <20040804060001.52370.qmail@web14923.mail.yahoo.com>
Date: Tue, 3 Aug 2004 23:00:01 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: lspci and ROM on bridge, was: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040803213921.GA4585@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lspci shows my AGP bridge

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev
02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe900000-feafffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        Expansion ROM at 0000d000 [disabled] [size=4K]
 
It shows an expansion ROM at d000. d000 is a normal address for a ROM.
But d000 also shows as I/O behind bridge.

If I list sysfs resources, the ROM is in slot 7, not 6 which is normal
for a ROM. Is this really a ROM or a bug in lspci?

[jonsmirl@smirl 0000:00:01.0]$ cat resource
0  0x0000000000000000 0x0000000000000000 0x0000000000000000
1  0x0000000000000000 0x0000000000000000 0x0000000000000000
2  0x0000000000000000 0x0000000000000000 0x0000000000000000
3  0x0000000000000000 0x0000000000000000 0x0000000000000000
4  0x0000000000000000 0x0000000000000000 0x0000000000000000
5  0x0000000000000000 0x0000000000000000 0x0000000000000000
6  0x0000000000000000 0x0000000000000000 0x0000000000000000
7  0x000000000000d000 0x000000000000dfff 0x0000000000000100
8  0x00000000fe900000 0x00000000feafffff 0x0000000000000200
9  0x00000000f0000000 0x00000000f7ffffff 0x0000000000001200
10 0x0000000000000000 0x0000000000000000 0x0000000000000000
11 0x0000000000000000 0x0000000000000000 0x0000000000000000
[jonsmirl@smirl 0000:00:01.0]$



=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
http://promotions.yahoo.com/new_mail 
