Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTI0MRx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 08:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTI0MRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 08:17:52 -0400
Received: from [195.249.110.5] ([195.249.110.5]:13823 "EHLO apollo")
	by vger.kernel.org with ESMTP id S262432AbTI0MRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 08:17:48 -0400
Subject: kernel BUG at inode.c:564
From: Jules Colding <JuBColding@yorkref.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: York Refrigeration
Message-Id: <1064665061.9635.89.camel@apollo>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Sep 2003 14:17:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if this is/was a known issue, but I got a kernel panic when
I tried to install, rh9 on my new machine (I have send this mail to the
rh list too). This happened while doing a harddisk install from
/dev/hda5 (fat - partitioned and formatted by W2K). 

My hardware is:
Asus A7V600 Via KT600 DDR400 AGP x8
1 AMD Athlon Thoroughbred  XP 2000+ (1667 MHz)
2 Seagate Barracuda 80GB (ST380011A), 7200RPM, 2MB 
1 Kingston 512 MB DDR-RAM PC32000 400 MHz KVR400X64C3
1 Nvidia GeForce4 MX 440-8X, 128MB DDR

Both Seagates are at IDE1. I have installed W2K on hda and was trying to
install rh9 on hdb as a dual boot. I have a fat partition (hda5) on my
W2K disk. I also have a cdrom on hdc.

I have replicated the entire error screen below:

---------------- CUT ----------------
        /mnt/runtime umount failed (16)
        disabling /dev/loop1 LOOP_CLR_FD failed: 16
------------- [ cut here ] ------------- 
kernel BUG at inode.c:564!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c014dfaa]>       Not tainted
EFLAGS: 00010202

EIP is at  (2.4.20-8BOOT)
eax: 00000001   ebx: dce37420   ecx: dce37440   edx: 00000000
esi: dfcd1f60   edi: dfcd1f60   ebp: c0271280   esp: dfcd1f44
ds: 0068        es: 0068        ss: 0068
Process linuxrc (pid: 17, stackpage=dfcd1000)
Stack:  dce37420 c014e07a dce37420 defe4c64 00000000 c014e1a5 dfcd1f60
dce37258
        d85685d8 defe4c44 defe4c00 dee64ca0 c0140759 defe4c00 c0271348
00000000
        dfcd1f98 0000000d bffec894 c01502e4 defe4c00 dee64ca0 c25a2590
c250a270
Call Trace:     [<c014e07a>] (0xdfcd1f48)
[<c014e1a5>] (0xdfcd1f58)
[<c0140759>] (0xdfcd1f74)
[<c01502e4>] (0xdfcd1f90)
[<c0108d73>] (0xdfcd1fc0)

Code: 0f 0b 34 02 39 da 23 c0 8b 83 fc 00 00 00 a9 10 00 00 00 75
 VFS: Cannot open root device "" or 48:05
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 48:05
---------------- CUT ----------------

This was the first time I got a kernel panic. The install have stalled
trice before (well into the install). Two times when I tried to install
from cdrom, and one time when I tried the hard disk install from the
same partition. I have checked the media and the isos. They all PASS.

So, is there some solution to this problem?

Thanks in advance,
  jules

-- 
Jules Colding <JuBColding@yorkref.com>
York Refrigeration
