Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbUBBPQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbUBBPQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:16:07 -0500
Received: from grebe.mail.pas.earthlink.net ([207.217.120.46]:10973 "EHLO
	grebe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265635AbUBBPP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:15:59 -0500
Message-ID: <401E69AD.4080606@earthlink.net>
Date: Mon, 02 Feb 2004 10:15:57 -0500
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: bttv oops
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle people,

I am having the following problem. Also if I compile bttv into the 
kernel I get a panic in the driver at boot.

Any ideas?

Thanks,
Steve

Linux joker.seclark.com 2.6.2-rc2-mm1 #24 Sun Feb 1 16:20:54 EST 2004 
i686 athlon i386 GNU/Linux

Feb  2 08:26:57 joker kernel: bttv: driver version 0.9.12 loaded
Feb  2 08:26:57 joker kernel: bttv: using 8 buffers with 2080k (520 
pages) each for capture
Feb  2 08:26:57 joker kernel: bttv: Bt8xx card found (0).
Feb  2 08:26:57 joker kernel: bttv0: Bt878 (rev 2) at 0000:00:08.0, irq: 
10, latency: 32, mmio: 0xd7021000
Feb  2 08:26:57 joker kernel: bttv0: detected: AVerMedia TVPhone98 
[card=41], PCI subsystem ID is 1461:0001
Feb  2 08:26:57 joker kernel: bttv0: using: AVerMedia TVPhone 98 
[card=41,autodetected]
Feb  2 08:26:57 joker /sbin/hotplug: no runnable 
/etc/hotplug/i2c-adapter.agent is installed
Feb  2 08:26:57 joker /sbin/hotplug: no runnable 
/etc/hotplug/i2c-dev.agent is installed
Feb  2 08:26:57 joker /sbin/hotplug: no runnable /etc/hotplug/i2c.agent 
is installed
Feb  2 08:26:57 joker kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Feb  2 08:26:57 joker kernel:  printing eip:
Feb  2 08:26:57 joker kernel: c02c1214
Feb  2 08:26:57 joker kernel: *pde = 00000000
Feb  2 08:26:57 joker kernel: Oops: 0000 [#1]
Feb  2 08:26:57 joker kernel: CPU:    0
Feb  2 08:26:57 joker kernel: EIP:    0060:[<c02c1214>]    Not tainted VLI
Feb  2 08:26:57 joker kernel: EFLAGS: 00010202
Feb  2 08:26:57 joker kernel: EIP is at i2c_master_recv+0xa4/0x110
Feb  2 08:26:57 joker kernel: eax: 00000000   ebx: 00000050   ecx: 
00000010   edx: 00004d3c
Feb  2 08:26:57 joker kernel: esi: 00000001   edi: f8ccbca4   ebp: 
f8ccbed0   esp: e681de4c
Feb  2 08:26:57 joker kernel: ds: 007b   es: 007b   ss: 0068
Feb  2 08:26:57 joker kernel: Process modprobe (pid: 7165, 
threadinfo=e681c000 task=ef128ce0)
Feb  2 08:26:57 joker kernel: Stack: f8ccbf44 00000001 00000010 00000050 
00010050 00000010 f8cd2a20 000000a0
Feb  2 08:26:57 joker kernel:        00000000 f8ccbed0 f8cd2a20 f8ccbca0 
f8cba4dc f8ccbed0 f8cd2a20 00000010
Feb  2 08:26:57 joker kernel:        f8ccbca0 f8ccbca0 00000000 f8cb6105 
f8ccbca0 f8cd2a20 000000a0 00000040
Feb  2 08:26:57 joker kernel: Call Trace:
Feb  2 08:26:57 joker kernel:  [<f8cba4dc>] bttv_readee+0x4c/0x80 [bttv]
Feb  2 08:26:57 joker kernel:  [<f8cb6105>] bttv_init_card2+0x585/0x620 
[bttv]
Feb  2 08:26:57 joker kernel:  [<f8cb4a46>] bttv_probe+0x456/0x600 [bttv]
Feb  2 08:26:57 joker kernel:  [<c01f66a2>] 
pci_device_probe_static+0x32/0x50
Feb  2 08:26:57 joker kernel:  [<c01f66e7>] __pci_device_probe+0x27/0x40
Feb  2 08:26:57 joker kernel:  [<c01f671c>] pci_device_probe+0x1c/0x40
Feb  2 08:26:57 joker kernel:  [<c02380ce>] bus_match+0x2e/0x60
Feb  2 08:26:57 joker kernel:  [<c02381e7>] driver_attach+0x57/0x80
Feb  2 08:26:57 joker kernel:  [<c023842b>] bus_add_driver+0x6b/0x80
Feb  2 08:26:57 joker kernel:  [<c02387ed>] driver_register+0x2d/0x40
Feb  2 08:26:57 joker kernel:  [<c01e96d9>] kset_add+0x29/0x30
Feb  2 08:26:57 joker kernel:  [<c01e96f1>] kset_register+0x11/0x20
Feb  2 08:26:57 joker kernel:  [<c01f68cf>] pci_register_driver+0x4f/0x70
Feb  2 08:26:57 joker kernel:  [<f8cb4fec>] bttv_init_module+0x8c/0x120 
[bttv]
Feb  2 08:26:57 joker kernel:  [<c0130ca1>] sys_init_module+0xf1/0x1b0
Feb  2 08:26:57 joker kernel:  [<c03a851a>] sysenter_past_esp+0x43/0x69
Feb  2 08:26:57 joker kernel:
Feb  2 08:26:57 joker kernel: Code: 24 04 50 57 ff 52 24 89 c6 83 c4 0c 
89 d9 ff 47 1c 0f 8e 1e 15 00 00 8b 5d
 08 53 8b 4c 24 30 51 50 8d 45 74 50 8b 85 8c 00 00 00 <8b> 10 52 68 a0 
d2 3f c0 e8 9f c0 e5 ff 83 c4 18 83 fe
 01 89 f0


