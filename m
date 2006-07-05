Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWGEVn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWGEVn6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWGEVn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:43:58 -0400
Received: from smtp.ono.com ([62.42.230.12]:28976 "EHLO resmta03.ono.com")
	by vger.kernel.org with ESMTP id S965046AbWGEVn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:43:57 -0400
Date: Wed, 5 Jul 2006 23:43:47 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm6
Message-ID: <20060705234347.47ef2600@werewolf.auna.net>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
References: <20060703030355.420c7155.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.1cvs54 (GTK+ 2.10.0; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 03:03:55 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> 
> 
> - A major update to the e1000 driver.
> 

Doesn't find my root drive :(.

Its a SATA drive, on PIIX.
Last -mm I tried ('cause of the raid problems) was -mm1, so I don't know
when did this broke. Under -mm1, the disk is this:

libata version 1.30 loaded.
ata_piix 0000:00:1f.2: version 1.10tj1ac3
ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi0 : ata_piix
ata1: ENTER, pcs=0x13 base=0
ata1: LEAVE, pcs=0x13 present_mask=0x1
ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:407f
ata1.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48 
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ata2: ENTER, pcs=0x13 base=2
ata2: LEAVE, pcs=0x11 present_mask=0x0
ata2: SATA port has no device.
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda

With -mm6, the kernel doesn't find it. I get this on boot:

kinit: try_name sda,1 = dev(8,1)
kinit: name_to_dev_t(/dev/sda1) = dev(8.1)
kinit: root_dev = dev(8,1)
kinit: failed to identify filesystem /dev/root, trying all
kinit: trying to mount /dev/root on /root with type ext3
kinit: Cannot open root device dev(8,1)

I have tried to get this message from -mm1, but could not get it in any log.
But... I remember to see that the boot message is like:

kinit: try_name sda,1 = sda1(8,1)
                        ^^^^
I have verified I built -mm6 with ext3,sata-piix and so on, all builtin.

Any ideas ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam01 (gcc 4.1.1 20060518 (prerelease)) #2 SMP PREEMPT Wed
