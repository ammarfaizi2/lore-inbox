Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbTE1P4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbTE1P4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:56:04 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:31360
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S264781AbTE1Pzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:55:46 -0400
From: "jds" <jds@soltis.cc>
To: linux-kernel@vger.kernel.org
Subject: ALSA Segmentation fault load modules 2.5.70 and 2.5.70mm1
Date: Wed, 28 May 2003 09:35:34 -0600
Message-Id: <20030528153440.M46134@soltis.cc>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi:

    I have problems when load ALSA module, this message:

    [root@toshiba root]# modprobe snd-ymfpci
Segmentation fault
    [root@toshiba root]#

    This log message:

    Debug: sleeping function called from illegal context at
include/linux/rwsem.h:43Call Trace:
[<c0119d5e>] __might_sleep+0x5e/0x70
[<c0117319>] do_page_fault+0x79/0x4b4
[<c0177cc9>] proc_create+0x89/0xe0
[<c0177b18>] proc_register+0x18/0xb0
[<c0177f42>] create_proc_entry+0x82/0xd0
[<c03340d0>] snd_create_proc_entry+0x20/0x30
[<c01172a0>] do_page_fault+0x0/0x4b4
[<c010b249>] error_code+0x2d/0x38
[<c020e6c3>] pci_bus_write_config_word+0x53/0x60
[<e08b6521>] +0x521/0x790 [snd_ymfpci]
[<e08b9efb>] +0x7c/0x281 [snd_ymfpci]
[<c017c1db>] sysfs_new_inode+0x6b/0xb0
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc5f0>] snd_ymfpci_ids+0x70/0xe0 [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<c02120ac>] __pci_device_probe+0x3c/0x50
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<c021210d>] pci_device_probe+0x4d/0x60
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c028c4b3>] bus_match+0x43/0x80
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c028c5dd>] driver_attach+0x5d/0x70
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c028c8d5>] bus_add_driver+0xa5/0xc0
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc6f8>] driver+0x98/0xa0 [snd_ymfpci]
[<c028cd51>] driver_register+0x31/0x40
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c0212351>] pci_register_driver+0x71/0xa0
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<e08c2e40>] +0x0/0x100 [snd_ymfpci]
[<e089b01a>] +0x1a/0x5a [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<c012f981>] sys_init_module+0x131/0x220
[<e08c2e40>] +0x0/0x100 [snd_ymfpci]
[<c010b04d>] sysenter_past_esp+0x52/0x71

Unable to handle kernel NULL pointer dereference at virtual address 00000004
printing eip:
c020e6c3
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c020e6c3>]    Not tainted VLI
EFLAGS: 00010046
EIP is at pci_bus_write_config_word+0x53/0x60
eax: c17f6be0   ebx: 00000246   ecx: 00000330   edx: 00000000
esi: 00000064   edi: c045c1a0   ebp: c9c65e58   esp: c9c65e38
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1618, threadinfo=c9c64000 task=cc1b98a0)
Stack: c045c1a0 c17f6be0 00000064 00000002 00000330 c9c65e90 00000800 0000000a
      c9c65ea4 e08b6521 c045c1a0 c17f6be0 00000064 00000330 000041ed 00000000
      c9c311e0 000041ed e08b9efb df703a00 c017c1db c9c65e90 0330e199 0d690388
Call Trace:
[<e08b6521>] +0x521/0x790 [snd_ymfpci]
[<e08b9efb>] +0x7c/0x281 [snd_ymfpci]
[<c017c1db>] sysfs_new_inode+0x6b/0xb0
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc5f0>] snd_ymfpci_ids+0x70/0xe0 [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<c02120ac>] __pci_device_probe+0x3c/0x50
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<c021210d>] pci_device_probe+0x4d/0x60
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c028c4b3>] bus_match+0x43/0x80
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c028c5dd>] driver_attach+0x5d/0x70
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c028c8d5>] bus_add_driver+0xa5/0xc0
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<e08bc6f8>] driver+0x98/0xa0 [snd_ymfpci]
[<c028cd51>] driver_register+0x31/0x40
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<c0212351>] pci_register_driver+0x71/0xa0
[<e08bc688>] driver+0x28/0xa0 [snd_ymfpci]
[<e08c2e40>] +0x0/0x100 [snd_ymfpci]
[<e089b01a>] +0x1a/0x5a [snd_ymfpci]
[<e08bc660>] driver+0x0/0xa0 [snd_ymfpci]
[<c012f981>] sys_init_module+0x131/0x220
[<e08c2e40>] +0x0/0x100 [snd_ymfpci]
[<c010b04d>] sysenter_past_esp+0x52/0x71

Code: f4 8b 75 f8 8b 7d fc 89 ec 5d c3 9c 5b fa 8b 45 0c 8b 57 30 89 3c 24 89
4c 24 10 c7 44 24 0c 02 00 00 00 89 74 24 08 89 44 24 04  <ff> 52 04 53 9d eb
cc b6 00 00 00 00 55 89 e5 83 ec 1c 89 75
 
  Regards.
