Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUJISKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUJISKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267278AbUJISKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:10:36 -0400
Received: from lashout.net ([213.239.130.203]:13750 "HELO lashout.net")
	by vger.kernel.org with SMTP id S267263AbUJISKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:10:12 -0400
Date: Sat, 9 Oct 2004 18:10:08 +0000 (GMT)
From: Johannes Peeters <jpeeters@lashout.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sata_sil command 0x25 timeout, stat 0x50 host_stat 0x64
In-Reply-To: <Pine.LNX.4.53.0410091011240.16625@wodka.lashout.net>
Message-ID: <Pine.LNX.4.53.0410091808050.28093@wodka.lashout.net>
References: <Pine.LNX.4.53.0410091011240.16625@wodka.lashout.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update. I read that 2.6.7 might work better for the sata_sil driver, so
i tried running this version. But 2.6.7 doesn't solve my problem:

sata_sil version 0.54
PCI: Found IRQ 9 for device 0000:00:0e.0
ata1: SATA max UDMA/100 cmd 0xD086AE80 ctl 0xD086AE8A bmdma 0xD086AE00 irq
9
ata2: SATA max UDMA/100 cmd 0xD086AEC0 ctl 0xD086AECA bmdma 0xD086AE08 irq
9
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
irq 9: nobody cared!
 [<c01057fa>] __report_bad_irq+0x2a/0x90
 [<c01058f0>] note_interrupt+0x70/0xb0
 [<c0105b00>] do_IRQ+0xe0/0xf0
 [<c0103fac>] common_interrupt+0x18/0x20
 [<c01161ae>] __do_softirq+0x2e/0x80
 [<c0116227>] do_softirq+0x27/0x30
 [<c0105ae5>] do_IRQ+0xc5/0xf0
 [<c0103fac>] common_interrupt+0x18/0x20
 [<c01c007b>] idr_pre_get+0x2b/0x50
 [<c010d5c4>] delay_tsc+0x14/0x20
 [<c01c3ff2>] __delay+0x12/0x20
 [<c023252d>] ata_busy_sleep+0x1d/0x130
 [<c0232e44>] ata_dev_set_xfermode+0x94/0x190
 [<c0232f94>] ata_dev_set_udma+0x54/0xc0
 [<c02324d1>] ata_set_mode+0x51/0x90
 [<c02322d8>] ata_port_reset+0x88/0xc0
 [<c0234500>] ata_probe_task+0x0/0x60
 [<c02342a8>] ata_thread_iter+0x48/0xc0
 [<c0234513>] ata_probe_task+0x13/0x60
 [<c011ffdd>] worker_thread+0x1ad/0x250
 [<c010ff10>] default_wake_function+0x0/0x20
 [<c010ff10>] default_wake_function+0x0/0x20
 [<c011fe30>] worker_thread+0x0/0x250
 [<c01231aa>] kthread+0xaa/0xb0
 [<c0123100>] kthread+0x0/0xb0
 [<c010223d>] kernel_thread_helper+0x5/0x18

handlers:
[<c0234120>] (ata_interrupt+0x0/0x140)
Disabling IRQ #9
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda:<3>ata1: DMA timeout, stat 0x64
 unknown partition table
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb:<3>ata2: DMA timeout, stat 0x64
 unknown partition table
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
PCI: Found IRQ 10 for device 0000:00:10.0
ata3: SATA max UDMA/100 cmd 0xD0877C80 ctl 0xD0877C8A bmdma 0xD0877C00 irq
10
ata4: SATA max UDMA/100 cmd 0xD0877CC0 ctl 0xD0877CCA bmdma 0xD0877C08 irq
10
irq 10: nobody cared!
 [<c01057fa>] __report_bad_irq+0x2a/0x90
 [<c01058f0>] note_interrupt+0x70/0xb0
 [<c0105b00>] do_IRQ+0xe0/0xf0
 [<c0103fac>] common_interrupt+0x18/0x20
 [<c01161ae>] __do_softirq+0x2e/0x80
 [<c0116227>] do_softirq+0x27/0x30
 [<c0105ae5>] do_IRQ+0xc5/0xf0
 [<c0103fac>] common_interrupt+0x18/0x20
 [<c01c007b>] idr_pre_get+0x2b/0x50
 [<c010d5c4>] delay_tsc+0x14/0x20
 [<c01c3ff2>] __delay+0x12/0x20
 [<c023252d>] ata_busy_sleep+0x1d/0x130
 [<c0231d3b>] ata_dev_identify+0xdb/0x5f0
 [<c01c3ff2>] __delay+0x12/0x20
 [<c02329b9>] ata_bus_reset+0x129/0x210
 [<c02323e5>] sata_phy_reset+0xc5/0x140
 [<c0232284>] ata_port_reset+0x34/0xc0
 [<c0234500>] ata_probe_task+0x0/0x60
 [<c02342a8>] ata_thread_iter+0x48/0xc0
 [<c0234513>] ata_probe_task+0x13/0x60
 [<c011ffdd>] worker_thread+0x1ad/0x250
 [<c010ff10>] default_wake_function+0x0/0x20
 [<c010ff10>] default_wake_function+0x0/0x20
 [<c011fe30>] worker_thread+0x0/0x250
 [<c01231aa>] kthread+0xaa/0xb0
 [<c0123100>] kthread+0x0/0xb0
 [<c010223d>] kernel_thread_helper+0x5/0x18

handlers:
[<c0234120>] (ata_interrupt+0x0/0x140)
Disabling IRQ #10
ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata3: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
88:207f
ata4: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdc: drive cache: write back
 sdc:<3>ata3: DMA timeout, stat 0x64
 unknown partition table
Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
  Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdd: drive cache: write back
 sdd:<3>ata4: DMA timeout, stat 0x64
 unknown partition table
Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0


I will try further to get it working :)

Greetings,
Johannes Peeters

On Sat, 9 Oct 2004, Johannes Peeters wrote:

> Hello,
>
> I tried a lot of settings to get my sata drives working. I'm using 2 Sata
> Sil3112 controllers (SATALink, Sil3112ACT144, Q22389.110A & Q22389.119A)
> with both the latest bios (4.2.50) and 4 Maxtor Diamond Max Plug 9
> (6Y200M0) harddisk.
>
> In kernel 2.6.8.1, the siimage driver is working fine. The sata_sil driver
> howevers gives me weird timeouts:
>
> libata version 1.02 loaded.
> sata_sil version 0.54
> PCI: Found IRQ 9 for device 0000:00:0e.0
> ata1: SATA max UDMA/100 cmd 0xD0854E80 ctl 0xD0854E8A bmdma 0xD0854E00 irq
> 9
> ata2: SATA max UDMA/100 cmd 0xD0854EC0 ctl 0xD0854ECA bmdma 0xD0854E08 irq
> 9
> irq 9: nobody cared!
>  [<c01062ba>] __report_bad_irq+0x2a/0x90
>  [<c01063b0>] note_interrupt+0x70/0xb0
>  [<c01065f0>] do_IRQ+0xe0/0xf0
>  [<c010497c>] common_interrupt+0x18/0x20
>  [<c0118fbe>] __do_softirq+0x2e/0x80
>  [<c0119037>] do_softirq+0x27/0x30
>  [<c01065d5>] do_IRQ+0xc5/0xf0
>  [<c010497c>] common_interrupt+0x18/0x20
>  [<c021007b>] des_small_fips_encrypt+0x41b/0x9f0
>  [<c010e496>] delay_tsc+0x16/0x20
>  [<c0216822>] __delay+0x12/0x20
>  [<d08623bd>] ata_busy_sleep+0x1d/0x130 [libata]
>  [<d0861bbb>] ata_dev_identify+0xdb/0x610 [libata]
>  [<c0216822>] __delay+0x12/0x20
>  [<d0862852>] ata_bus_reset+0x132/0x220 [libata]
>  [<d0862275>] sata_phy_reset+0xc5/0x140 [libata]
>  [<d0862124>] ata_bus_probe+0x34/0xb0 [libata]
>  [<d086462c>] ata_device_add+0x1ac/0x250 [libata]
>  [<d0863ec0>] ata_interrupt+0x0/0x1b0 [libata]
>  [<d0858511>] sil_init_one+0x281/0x320 [sata_sil]
>  [<c0221702>] pci_device_probe_static+0x52/0x70
>  [<c022175c>] __pci_device_probe+0x3c/0x50
>  [<c022179c>] pci_device_probe+0x2c/0x50
>  [<c0261caf>] bus_match+0x3f/0x70
>  [<c0261ddc>] driver_attach+0x5c/0xa0
>  [<c0262301>] bus_add_driver+0x91/0xb0
>  [<c02628af>] driver_register+0x2f/0x40
>  [<c0221a1c>] pci_register_driver+0x5c/0x90
>  [<d085b00f>] sil_init+0xf/0x1b [sata_sil]
>  [<c012a5c8>] sys_init_module+0x108/0x1d0
>  [<c010400f>] syscall_call+0x7/0xb
> handlers:
> [<d0863ec0>] (ata_interrupt+0x0/0x1b0 [libata])
> Disabling IRQ #9
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_sil
> ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata2: dev 0 configured for UDMA/100
> scsi1 : sata_sil
>   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
> SCSI device sda: drive cache: write back
>  sda:<3>ata1: command 0x25 timeout, stat 0x50 host_stat 0x64
>  unknown partition table
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
>   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
> SCSI device sdb: drive cache: write back
>  sdb:<3>ata2: command 0x25 timeout, stat 0x50 host_stat 0x64
>  unknown partition table
> Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
> Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
> PCI: Found IRQ 10 for device 0000:00:10.0
> ata3: SATA max UDMA/100 cmd 0xD0856C80 ctl 0xD0856C8A bmdma 0xD0856C00 irq
> 10
> ata4: SATA max UDMA/100 cmd 0xD0856CC0 ctl 0xD0856CCA bmdma 0xD0856C08 irq
> 10
> irq 10: nobody cared!
>  [<c01062ba>] __report_bad_irq+0x2a/0x90
>  [<c01063b0>] note_interrupt+0x70/0xb0
>  [<c01065f0>] do_IRQ+0xe0/0xf0
>  [<c010497c>] common_interrupt+0x18/0x20
>  [<c0118fbe>] __do_softirq+0x2e/0x80
>  [<c0119037>] do_softirq+0x27/0x30
>  [<c01065d5>] do_IRQ+0xc5/0xf0
>  [<c010497c>] common_interrupt+0x18/0x20
>  [<c021007b>] des_small_fips_encrypt+0x41b/0x9f0
>  [<c010e494>] delay_tsc+0x14/0x20
>  [<c0216822>] __delay+0x12/0x20
>  [<d08623bd>] ata_busy_sleep+0x1d/0x130 [libata]
>  [<d0861bbb>] ata_dev_identify+0xdb/0x610 [libata]
>  [<c0216822>] __delay+0x12/0x20
>  [<d0862852>] ata_bus_reset+0x132/0x220 [libata]
>  [<d0862275>] sata_phy_reset+0xc5/0x140 [libata]
>  [<d0862124>] ata_bus_probe+0x34/0xb0 [libata]
>  [<d086462c>] ata_device_add+0x1ac/0x250 [libata]
>  [<d0863ec0>] ata_interrupt+0x0/0x1b0 [libata]
>  [<d0858511>] sil_init_one+0x281/0x320 [sata_sil]
>  [<c0221702>] pci_device_probe_static+0x52/0x70
>  [<c022175c>] __pci_device_probe+0x3c/0x50
>  [<c022179c>] pci_device_probe+0x2c/0x50
>  [<c0261caf>] bus_match+0x3f/0x70
>  [<c0261ddc>] driver_attach+0x5c/0xa0
>  [<c0262301>] bus_add_driver+0x91/0xb0
>  [<c02628af>] driver_register+0x2f/0x40
>  [<c0221a1c>] pci_register_driver+0x5c/0x90
>  [<d085b00f>] sil_init+0xf/0x1b [sata_sil]
>  [<c012a5c8>] sys_init_module+0x108/0x1d0
>  [<c010400f>] syscall_call+0x7/0xb
> handlers:
> [<d0863ec0>] (ata_interrupt+0x0/0x1b0 [libata])
> Disabling IRQ #10
> ata3: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata3: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata3: dev 0 configured for UDMA/100
> scsi2 : sata_sil
> ata4: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata4: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata4: dev 0 configured for UDMA/100
> scsi3 : sata_sil
>   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdc: 398297088 512-byte hdwr sectors (203928 MB)
> SCSI device sdc: drive cache: write back
>  sdc:<3>ata3: command 0x25 timeout, stat 0x50 host_stat 0x64
>  unknown partition table
> Attached scsi disk sdc at scsi2, channel 0, id 0, lun 0
> Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
>   Vendor: ATA       Model: Maxtor 6Y200M0    Rev: YAR5
>   Type:   Direct-Access                      ANSI SCSI revision: 05
> SCSI device sdd: 398297088 512-byte hdwr sectors (203928 MB)
> SCSI device sdd: drive cache: write back
>  sdd:<3>ata4: command 0x25 timeout, stat 0x50 host_stat 0x64
>  unknown partition table
> Attached scsi disk sdd at scsi3, channel 0, id 0, lun 0
> Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 0
>
> Reading/writing to this disc doesn't work, this gives me an endless
> process.
>
>
>
> I also tried with 2.6.9-rc3-bk7, but that gives me an other problem:
>
>
> libata version 1.02 loaded.
> sata_sil version 0.54
> PCI: Found IRQ 9 for device 0000:00:0e.0
> ata1: SATA max UDMA/100 cmd 0xD0854E80 ctl 0xD0854E8A bmdma 0xD0854E00 irq
> 9
> ata2: SATA max UDMA/100 cmd 0xD0854EC0 ctl 0xD0854ECA bmdma 0xD0854E08 irq
> 9
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_sil
> irq 9: nobody cared!
>  [<c0105e9a>] __report_bad_irq+0x2a/0x90
>  [<c0105f90>] note_interrupt+0x70/0xb0
>  [<c01061a0>] do_IRQ+0xe0/0xf0
>  [<c010413c>] common_interrupt+0x18/0x20
>  [<c011801e>] __do_softirq+0x2e/0x90
>  [<c01180a7>] do_softirq+0x27/0x30
>  [<c0106185>] do_IRQ+0xc5/0xf0
>  [<c010413c>] common_interrupt+0x18/0x20
>  [<c01020c3>] default_idle+0x23/0x40
>  [<c0102154>] cpu_idle+0x34/0x40
>  [<c044272b>] start_kernel+0x13b/0x160
>  [<c0442370>] unknown_bootoption+0x0/0x160
> handlers:
> [<d0865160>] (ata_interrupt+0x0/0x1c0 [libata])
> Disabling IRQ #9
> ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003
> 88:207f
> ata2: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
>
> After this, loading the module stops. I've wait a couple of hours, but
> this was the last message.
> Trying to enable/disable APIC & IOAPIC didn't solve the problem.
>
> Any suggestions?
>
> Thanks,
> Johannes Peeters
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
