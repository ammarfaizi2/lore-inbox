Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTILMo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 08:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTILMo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 08:44:57 -0400
Received: from real-outmail.cc.huji.ac.il ([132.64.1.21]:19895 "EHLO
	mail3.cc.huji.ac.il") by vger.kernel.org with ESMTP id S261542AbTILMoz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 08:44:55 -0400
Message-ID: <3F61C062.1080700@mscc.huji.ac.il>
Date: Fri, 12 Sep 2003 15:47:30 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030807
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: linux-2.6.0-test5-mm1
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.21.0.1; VDF: 6.21.0.39; host: mail3.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens after I load alsa modules on boot..............

<from_dmesg>

Freeing unused kernel memory: 308k freed
Adding 313228k swap on /dev/hda6.  Priority:-1 extents:1
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:04.2
Unable to handle kernel paging request at virtual address ffffffef
  printing eip:
c01df3c0
*pde = 00001067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01df3c0>]    Not tainted
EFLAGS: 00010282
EIP is at atomic_dec_and_lock+0x10/0x60
eax: ffffffef   ebx: ffffffef   ecx: ffffffef   edx: 00000000
esi: cffe5680   edi: c03312e4   ebp: d092fec8   esp: cf96feb0
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2596, threadinfo=cf96e000 task=cf971940)
Stack: ffffffef cffe5680 c0169b30 ffffffef c032c690 ffffffef cffe5680 
c03312e4
        c0187e45 ffffffef 000041ed c0187da0 d092fee0 00000000 c0187eb6 
d092fee0
        cffe5680 d092fee4 00000000 d092fee0 c01dc86f d092fee0 d092fee0 
c0331348
Call Trace:
  [<c0169b30>] dput+0x30/0x220
  [<c0187e45>] create_dir+0x85/0x90
  [<c0187da0>] init_dir+0x0/0x20
  [<c0187eb6>] sysfs_create_dir+0x36/0x80
  [<c01dc86f>] create_dir+0x1f/0x50
  [<c01dca17>] kobject_add+0x97/0x110
  [<c01dcab3>] kobject_register+0x23/0x60
  [<c023c72a>] bus_add_driver+0x4a/0xa0
  [<c023cbbf>] driver_register+0x2f/0x40
  [<c01e5550>] pci_register_driver+0x60/0x90
  [<d0915809>] alsa_card_ens137x_init+0x19/0x5b [snd_ens1370]
  [<c013361c>] sys_init_module+0x12c/0x250
  [<c010934b>] syscall_call+0x7/0xb

Code: 8b 31 89 f2 4a 74 11 89 f0 f0 0f b1 11 31 db 39 f0 75 ed 89
  blk: queue c13d8200, I/O limit 4095Mb (mask 0xffffffff)
eth0: link up, 10Mbps, half-duplex, lpa 0x0000
liviu@starshooter liviu $

</from_dmesg>

Liviu

