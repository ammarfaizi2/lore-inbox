Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbTLVRhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLVRhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:37:00 -0500
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:63105
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S264445AbTLVRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:36:58 -0500
Date: Mon, 22 Dec 2003 12:37:49 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: [OOPS][2.6.0][e100 new driver] mii-diag oops with -F option
Message-ID: <Pine.LNX.4.44.0312221236130.406-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this is with the new Intel e100 pro driver not the old eepro100
driver.

Here is the oops dump below this seems ugly:

 Unable to handle kernel paging request at virtual address c046a640
  printing eip:
 c046a640
 *pde = 00103027
 *pte = 0046a000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[<c046a640>]    Not tainted
 EFLAGS: 00010286
 EIP is at e100_phy_init+0x0/0x80
 eax: 00000000   ebx: e3593a40   ecx: 00000000   edx: e0402000
 esi: e3593a40   edi: 00000000   ebp: e35937f8   esp: e0403e8c
 ds: 007b   es: 007b   ss: 0068
 Process mii-diag (pid: 165, threadinfo=e0402000 task=e0453960)
 Stack: c0279763 e3593a40 e0403ea0 c0120d4a e35937f8 e35937f8 c027ee63 e3593a40
        40015035 e0402000 c0238910 e17d1000 00008949 00008949 ffffffed 00008949
        c033d698 e35937f8 e0403f0c 00008949 c04164a0 e0403f0c 00008949 00000001
 Call Trace:
  [<c0279763>] e100_hw_init+0x13/0x170
  [<c0120d4a>] preempt_schedule+0x2a/0x50
  [<c027ee63>] e100_mii_ioctl+0x1f3/0x320
  [<c0238910>] write_chan+0x170/0x230
  [<c033d698>] dev_ifsioc+0x3f8/0x470
  [<c033da0f>] dev_ioctl+0x2ff/0x3a0
  [<c0332540>] sock_ioctl+0x0/0x460
  [<c0389b3c>] inet_ioctl+0x11c/0x130
  [<c0332767>] sock_ioctl+0x227/0x460
  [<c01780b2>] vfs_write+0xd2/0x130
  [<c0192e19>] sys_ioctl+0x219/0x430
  [<c01781c2>] sys_write+0x42/0x70
  [<c010a41b>] syscall_call+0x7/0xb

 Code:  Bad EIP value.

The EIP matched in my System.map is e100_phy_init

Shawn.

