Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUJSM64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUJSM64 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 08:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUJSM64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 08:58:56 -0400
Received: from smtp08.auna.com ([62.81.186.18]:3503 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S269190AbUJSM6d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 08:58:33 -0400
Date: Tue, 19 Oct 2004 12:58:31 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Timeout problems with ATA/SATA
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.5
Message-Id: <1098190711l.7834l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I'm getting some proeblems and hangs with latest kernels.
I have two kind of problems, with ATA and with SATA-RAID.
SATA disks ata1-8 are part of a raid5 array exported via samba
(two promise controlers, 3 out of 4 ports used on each).
hde is an ATA disk for system root.

hde gives errors with 2.6.9 and -rc4-mm1. Also ata5 (SATA).
2.6.9-rc3-mm3 is working fine.

With 2.6.9-rc4-mm1, I get this messages:

Oct 18 19:31:54 nada kernel: Linux version 2.6.9-rc4-mm1 (root@nada.cps.unizar.es) (gcc version 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 SMP Thu Oct 14 23:57:32 CEST 2004
...
Oct 18 19:31:54 nada kernel: VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
Oct 18 19:31:54 nada kernel:     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
Oct 18 19:31:54 nada kernel:     ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:DMA
Oct 18 19:31:54 nada kernel: Probing IDE interface ide2...
Oct 18 19:31:54 nada kernel: hde: Maxtor 6Y080L0, ATA DISK drive
Oct 18 19:31:54 nada kernel: ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
...
Oct 18 19:31:54 nada kernel: ata5: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 88:407f
Oct 18 19:31:54 nada kernel: ata5: dev 0 ATA, max UDMA/133, 490234752 sectors: lba48
Oct 18 19:31:54 nada kernel: ata5: dev 0 configured for UDMA/133
Oct 18 19:31:54 nada kernel: scsi4 : sata_promise
...
Oct 18 19:31:54 nada kernel:   Vendor: ATA       Model: Maxtor 7Y250M0    Rev: YAR5
Oct 18 19:31:54 nada kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
...
Oct 18 19:31:54 nada kernel:  sde: sde1
Oct 18 19:31:54 nada kernel: Attached scsi disk sde at scsi5, channel 0, id 0, lun 0
Oct 18 19:31:54 nada kernel: SCSI device sdf: 490234752 512-byte hdwr sectors (251000 MB)
Oct 18 19:31:54 nada kernel: SCSI device sdf: drive cache: write back
...
Oct 18 20:54:10 nada kernel: ata5: command timeout
Oct 18 20:54:30 nada kernel: hde: dma_timer_expiry: dma status == 0x24
Oct 18 20:54:40 nada kernel: hde: DMA interrupt recovery
Oct 18 20:54:40 nada kernel: hde: lost interrupt
<tons of similar messages>
...

With 2.6.9:
Oct 19 11:11:45 nada kernel: Linux version 2.6.9 (root@nada.cps.unizar.es) (gcc
...
Oct 19 13:07:03 nada kernel: ata5: command timeout
Oct 19 13:16:24 nada smb: smbd shutdown succeeded
Oct 19 13:16:24 nada nmbd[10910]: [2004/10/19 13:16:24, 0] nmbd/nmbd.c:terminate(54) 
Oct 19 13:16:24 nada nmbd[10910]:   Got SIGTERM: going down... 
Oct 19 13:16:24 nada smb: nmbd shutdown succeeded

Any ideas ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4


