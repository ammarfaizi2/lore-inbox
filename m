Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTKLCqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTKLCqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:46:53 -0500
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:57092 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S261376AbTKLCqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:46:51 -0500
Message-ID: <1201.192.168.0.5.1068605203.squirrel@stingray.homelinux.org>
Date: Wed, 12 Nov 2003 02:46:43 -0000 (UTC)
Subject: 2.6.0-test9-bk16 ALi M5229 kernel boot error
From: "Daniel Craig" <dancraig@internode.on.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,
I have a Benq laptop (Celeron 2.4GHz) which is using an ALi chipset. I
have it working with kernel 2.4, but would like to migrate it to 2.6.
However, when I use 2.6.0-test9 (I have tried mm2, 'vanilla' and bk17), I
end up with a boot time crash. This is primarily to do with the
initialisation of the IDE controller, as far as I can see. I have included
the kernel message below. As I mentioned before, this works fine on
2.4.22... Does anyone have any idea what might be going wrong...?

Cheers,
Dan Craig.

The boot error is as follows:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0e.0
ALI15X3: chipset revision 197
ALI15X3: not 100% native mode: will probe irqs later
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c0378a69
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0378a69>]    Not tainted
EFLAGS: 00010046
EIP is at init_chipset_ali15x3+0x13e/0x1c1
eax: 00000000   ebx: c133fc00   ecx: 80007048   edx: cfea1ef3
esi: 00000246   edi: c12e4800   ebp: cfea1f00   esp: cfea1ee0
ds: 007b   es: 007b   ss:0068
Process swapper (pid: 1, threadinfo=cfea0000 task=128f900)
Stack: c1346980 00000070 00000079 cfea1ef3 c1051f04 00000000 00000001
cfea1f4c
       cfea1f34 c0254a6d c133fc00 c0300d1c 00000001 cfea1f24 c020e343
00000001
       0000ffff 00000000 c03aaa00 c133fc00 00000000 cfea1f54 c0254ab6
cfea1f4c
Call Trace:
 [<c0254a6d>] do_ide_setup_pci_device+0x159/0x178
 [<c020e343>] pci_find_subsys+0x81/0xef
 [<c0254ab6>] ide_setup_pci_device+0x2a/0x81
 [<c0378efa>] alim15x3_init_one+0x45/0x5c
 [<c0379a93>] ide_scan_pcidev+0x5c/0x6e
 [<c0379ae5>] ide_scan_pcibus+0x40/0xbb
 [<c03799c8>] probe_for_hwifs+0x13/0x17
 [<c03799d4>] ide_init_builtin_drivers+0x8/0x13
 [<c0379a27>] ide_init+0x48/0x58
 [<c03686c2>] do_initcalls+0x2b/0x98
 [<c012b52c>] init_workqueues+0x12/0x2a
 [<c01050ca>] init+0x33/0x139
 [<c0105097>] init+0x0/0x139
 [<c0108f25>] kernel_thread_helper+0x5/0xb

Code: 8b 50 20 89 54 24 04 8b 40 10 89 04 24 e8 21 32 e9 ff 0f b6
 <0>Kernel panic: Attempted to kill init!
