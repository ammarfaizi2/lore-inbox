Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265519AbUFIDfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265519AbUFIDfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 23:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUFIDfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 23:35:25 -0400
Received: from web51807.mail.yahoo.com ([206.190.38.238]:27281 "HELO
	web51807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265519AbUFIDfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 23:35:13 -0400
Message-ID: <20040609033513.76754.qmail@web51807.mail.yahoo.com>
Date: Tue, 8 Jun 2004 20:35:13 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: slow down in 2.6 vs 2.4
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Over the last two days I have been struggling with
understanding why 2.6.x kernel is slower than
2.4.21/23 kernels.  I think I have a test case which
demostrates this issue.

I have downloaded gcc-3.4.0 and run with this config:
--enable-languages=c,c++ --prefix=/usr/tmp/foo

using gcc-3.2.3 and binutils-2.13.2.1, on IBM x335
w/2x 2.8G Xeon w/8G RAM, no ht[bios killed], using
local file system (XFS):

make times:

2.4.21:
323.68user 56.07system 6:35.77elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (3138783major+3818347minor)pagefaults
0swaps

2.6.7-rc3-s63 (SPA scheduler):
334.01user 69.86system 7:01.47elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (13301major+6931745minor)pagefaults
0swaps

2.6.7-rc3:
336.17user 68.41system 7:02.47elapsed 95%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (13301major+6931745minor)pagefaults
0swaps

Machine:
00:00.0 Host bridge: ServerWorks: Unknown device 0012
(rev 13)
00:00.1 Host bridge: ServerWorks: Unknown device 0012
00:00.2 Host bridge: ServerWorks: Unknown device 0000
00:01.0 VGA compatible controller: ATI Technologies
Inc Rage XL (rev 27)
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge
(rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller
(rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB
Controller (rev 05)
00:0f.3 ISA bridge: ServerWorks: Unknown device 0225
00:11.0 Host bridge: ServerWorks: Unknown device 0101
(rev 03)
00:11.2 Host bridge: ServerWorks: Unknown device 0101
(rev 03)
01:01.0 SCSI storage controller: Symbios Logic Inc.
(formerly NCR): Unknown device 0030 (rev 07)
01:02.0 Ethernet controller: Intel Corporation:
Unknown device 100e (rev 02)
02:01.0 Ethernet controller: BROADCOM Corporation:
Unknown device 16a7 (rev 02)
02:02.0 Ethernet controller: BROADCOM Corporation:
Unknown device 16a7 (rev 02)


Anything else needed? Is there something I can do to
try and understand this issue?

Thank you for your time.
Phy


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
