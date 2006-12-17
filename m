Return-Path: <linux-kernel-owner+w=401wt.eu-S1751728AbWLQUh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWLQUh6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 15:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWLQUh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 15:37:58 -0500
Received: from squeaker.ratbox.org ([66.212.148.233]:47019 "EHLO
	squeaker.ratbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbWLQUh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 15:37:57 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Dec 2006 15:37:57 EST
Date: Sun, 17 Dec 2006 15:15:28 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] bcm43xx oops on 2.6.20-rc1 on x86_64
Message-ID: <Pine.LNX.4.64.0612171510030.17532@squeaker.ratbox.org>
X-Cursor-Pos: : 1
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just was loading the bcm43xx module and got the following oops. Note that 
this card is one of the newer PCI-E cards.  If any other info is needed 
let me know.

-Aaron

ACPI: PCI Interrupt 0000:0c:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:0c:00.0 to 64
bcm43xx: Chip ID 0x4311, rev 0x1
bcm43xx: Number of cores: 4
bcm43xx: Core 0: ID 0x800, rev 0x11, vendor 0x4243
bcm43xx: Core 1: ID 0x812, rev 0xa, vendor 0x4243
bcm43xx: Core 2: ID 0x817, rev 0x3, vendor 0x4243
bcm43xx: Core 3: ID 0x820, rev 0x1, vendor 0x4243
bcm43xx: PHY connected
bcm43xx: Detected PHY: Version: 4, Type 2, Revision 8
bcm43xx: Detected Radio: ID: 2205017f (Manuf: 17f Ver: 2050 Rev: 2)
bcm43xx: Radio turned off
bcm43xx: Radio turned off
Unable to handle kernel NULL pointer dereference at 0000000000000011 RIP:
  [<ffffffff88007793>] :ieee80211:ieee80211_wx_set_encode+0x14a/0x4a7
PGD 33a22067 PUD 3469b067 PMD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in: bcm43xx rng_core ieee80211softmac ieee80211 
ieee80211_crypt
Pid: 4088, comm: iwconfig Not tainted 2.6.20-rc1 #2
RIP: 0010:[<ffffffff88007793>]  [<ffffffff88007793>] 
:ieee80211:ieee80211_wx_set_encode+0x14a/0x4a7
RSP: 0018:ffff810032d3fc28  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff81003332ebf8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810032d3fcd5
RBP: ffff81003332ebf8 R08: 0000000000000005 R09: ffff810032d3fc48
R10: 0000000000000000 R11: 0000000000000202 R12: ffff81003332e4c0
R13: 0000000000000000 R14: 0000000000000000 R15: ffff810032d3fe58
FS:  00002b7863a2d6d0(0000) GS:ffffffff80697000(0000) 
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000011 CR3: 0000000034270000 CR4: 00000000000026e0
Process iwconfig (pid: 4088, threadinfo ffff810032d3e000, task 
ffff810037c4f690)
Stack:  ffff81003d87ecc0 0000000000000000 0000000100000000 
ffffffff80290ede
  0000000000000404 0000000000000000 0000000000000000 0000000000000000
  0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:
  [<ffffffff80290ede>] touch_atime+0xde/0x130
  [<ffffffff804f338b>] ioctl_standard_call+0x26b/0x3b0
  [<ffffffff8802baa0>] :bcm43xx:bcm43xx_wx_set_encoding+0x0/0x10
  [<ffffffff8025a029>] find_get_page+0x29/0x60
  [<ffffffff8025c684>] filemap_nopage+0x194/0x350
  [<ffffffff8802baa0>] :bcm43xx:bcm43xx_wx_set_encoding+0x0/0x10
  [<ffffffff804f3775>] wireless_process_ioctl+0x105/0x3d0
  [<ffffffff80267675>] __handle_mm_fault+0x465/0xad0
  [<ffffffff804e81d6>] dev_ioctl+0x346/0x3c0
  [<ffffffff803988f1>] __up_read+0x21/0xb0
  [<ffffffff804db750>] sock_ioctl+0x220/0x240
  [<ffffffff802885bf>] do_ioctl+0x2f/0xa0
  [<ffffffff802888d3>] vfs_ioctl+0x2a3/0x2e0
  [<ffffffff80288959>] sys_ioctl+0x49/0x80
  [<ffffffff8055184d>] error_exit+0x0/0x84
  [<ffffffff8020a03e>] system_call+0x7e/0x83


Code: 48 8b 40 10 48 85 c0 0f 84 01 01 00 00 48 8b 30 b9 04 00 00
RIP  [<ffffffff88007793>] :ieee80211:ieee80211_wx_set_encode+0x14a/0x4a7
  RSP <ffff810032d3fc28>
CR2: 0000000000000011


