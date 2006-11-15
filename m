Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030805AbWKOSWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030805AbWKOSWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030806AbWKOSWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:22:32 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:6984 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030805AbWKOSWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:22:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=uCMq408kA3AybzHbuXSSKXSSKB+uwZEiuWtTAQR5wG0AdjDa44f0N1R5uljEqoL0c//gKA3DutO6oqibTCzFx9iHBLbhOJRsPxldCyxUBPqQ3lZKo+3U6X2vNK0uawSWlour8pMS+QPN4UfAu6DEU/608Gz2MX3K9KqOYzpzvPA=
Message-ID: <455B5ADF.2040503@gmail.com>
Date: Wed, 15 Nov 2006 11:22:23 -0700
From: "Berck E. Nash" <flyboy@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com> <455B0BD7.20108@gmail.com>
In-Reply-To: <455B0BD7.20108@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050502070702050704050102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050502070702050704050102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Hmmm.. Can you try with the attached patch applied?  Also, please turn 
> on kernel config 'Kernel Hacking -> Show timing info on printks' and 
> report boot dmesg.

Looks like you forgot to attach the patch, so I couldn't test it:) 
Here's the section with the annoying hang with timing info.  I noticed 
that there are similar messages repeated later, but without as much 
hang, so I've attached the entire dmesg as well, in case it's of any help.

[   74.774249] scsi2 : ahci
[   75.232531] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  105.197121] ata2.00: qc timeout (cmd 0xec)
[  105.197168] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  113.040691] ata2: port is slow to respond, please be patient (Status 
0x80)
[  135.973052] ata2: port failed to respond (30 secs, Status 0x80)
[  135.973098] ata2: COMRESET failed (device not ready)
[  135.973145] ata2: hardreset failed, retrying in 5 secs
[  141.836829] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  142.366267] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[  143.171270] ata2: SATA link down (SStatus 0 SControl 300)

Berck

--------------050502070702050704050102
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg"

0000, IRQs 2, 8, 0
[   69.455284] hpet0: 3 64-bit timers, 14318180 Hz
[   69.456340] PCI-GART: No AMD northbridge found.
[   69.457171] pnp: the driver 'system' has been registered
[   69.457204] pnp: match found with the PnP device '00:01' and the driver 'system'
[   69.457211] pnp: match found with the PnP device '00:07' and the driver 'system'
[   69.457214] pnp: 00:07: ioport range 0x290-0x297 has been reserved
[   69.457263] pnp: match found with the PnP device '00:08' and the driver 'system'
[   69.457268] pnp: match found with the PnP device '00:0b' and the driver 'system'
[   69.457273] pnp: match found with the PnP device '00:0c' and the driver 'system'
[   69.457277] pnp: match found with the PnP device '00:0d' and the driver 'system'
[   69.457529] PCI: Bridge: 0000:00:01.0
[   69.457572]   IO window: disabled.
[   69.457616]   MEM window: faa00000-feafffff
[   69.457660]   PREFETCH window: cff00000-efefffff
[   69.457705] PCI: Bridge: 0000:00:1c.0
[   69.457747]   IO window: disabled.
[   69.457792]   MEM window: disabled.
[   69.457836]   PREFETCH window: cfe00000-cfefffff
[   69.457882] PCI: Bridge: 0000:00:1c.3
[   69.457925]   IO window: c000-cfff
[   69.457970]   MEM window: fa900000-fa9fffff
[   69.458016]   PREFETCH window: disabled.
[   69.458062] PCI: Bridge: 0000:00:1e.0
[   69.458105]   IO window: b000-bfff
[   69.458150]   MEM window: fa700000-fa8fffff
[   69.458195]   PREFETCH window: 50000000-500fffff
[   69.458250] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
[   69.458336] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   69.458350] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
[   69.458437] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   69.458452] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
[   69.458542] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   69.458551] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   69.458574] NET: Registered protocol family 2
[   69.470778] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[   69.470955] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[   69.471933] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   69.472651] TCP: Hash tables configured (established 131072 bind 65536)
[   69.472698] TCP reno registered
[   69.472779] wait_for_probes: waiting for 0 threads
[   69.473533] audit: initializing netlink socket (disabled)
[   69.473588] audit(1163589194.294:1): initialized
[   69.473824] Loading Reiser4. See www.namesys.com for a description of Reiser4.
[   69.473961] io scheduler noop registered
[   69.474033] io scheduler anticipatory registered (default)
[   69.485926] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   69.485959] assign_interrupt_mode Found MSI capability
[   69.486043] Allocate Port Service[0000:00:01.0:pcie00]
[   69.486140] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[   69.486188] assign_interrupt_mode Found MSI capability
[   69.486262] Allocate Port Service[0000:00:1c.0:pcie00]
[   69.486304] Allocate Port Service[0000:00:1c.0:pcie02]
[   69.486327] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[   69.486361] assign_interrupt_mode Found MSI capability
[   69.486434] Allocate Port Service[0000:00:1c.3:pcie00]
[   69.486545] ACPI: Power Button (FF) [PWRF]
[   69.486621] ACPI: Power Button (CM) [PWRB]
[   69.486989] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU1PM] [20060707]
[   69.487395] ACPI: Processor [CPU1] (supports 8 throttling states)
[   69.487703] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU2PM] [20060707]
[   69.488101] ACPI: Processor [CPU2] (supports 8 throttling states)
[   69.488204] ACPI: Getting cpuindex for acpiid 0x3
[   69.488251] ACPI: Getting cpuindex for acpiid 0x4
[   69.490315] Real Time Clock Driver v1.12ac
[   69.490469] hpet_resources: 0xfed00000 is busy
[   69.490478] Linux agpgart interface v0.101 (c) Dave Jones
[   69.490524] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   69.490800] pnp: the driver 'serial' has been registered
[   69.491058] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   69.491105] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   69.491193] ICH7: IDE controller at PCI slot 0000:00:1f.1
[   69.491245] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
[   69.491335] ICH7: chipset revision 1
[   69.491377] ICH7: not 100% native mode: will probe irqs later
[   69.491428]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
[   69.491549]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
[   69.491667] Probing IDE interface ide0...
[   70.163549] hda: LITE-ON LTR-48246S, ATAPI CD/DVD-ROM drive
[   70.878178] hdb: _NEC DVD_RW ND-3520AW, ATAPI CD/DVD-ROM drive
[   70.931385] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   70.931525] Probing IDE interface ide1...
[   71.449695] SiI680: IDE controller at PCI slot 0000:01:00.0
[   71.449752] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 21 (level, low) -> IRQ 21
[   71.449842] SiI680: chipset revision 2
[   71.449900] SiI680: BASE CLOCK == 133
[   71.449982] SiI680: 100% native mode on irq 21
[   71.450029]     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
[   71.450135]     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
[   71.450240] Probing IDE interface ide2...
[   71.714929] hde: SAMSUNG WN316025A (1.6 GB), ATA DISK drive
[   72.327426] ide2 at 0xffffc2000000ec80-0xffffc2000000ec87,0xffffc2000000ec8a on irq 21
[   72.327552] Probing IDE interface ide3...
[   72.591453] hdg: MAXTOR 6L040J2, ATA DISK drive
[   73.202922] ide3 at 0xffffc2000000ecc0-0xffffc2000000ecc7,0xffffc2000000ecca on irq 21
[   73.203182] hde: max request size: 64KiB
[   73.203226] hde: 3145968 sectors (1610 MB) w/109KiB Cache, CHS=3121/16/63, DMA
[   73.208831]  hde: hde1
[   73.219935] hdg: max request size: 64KiB
[   73.221077] hdg: 78198750 sectors (40037 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(133)
[   73.221390] hdg: cache flushes supported
[   73.221449]  hdg: hdg1
[   73.239729] hda: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
[   73.239989] Uniform CD-ROM driver Revision: 3.20
[   73.280394] hdb: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   73.294784] ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 22 (level, low) -> IRQ 22
[   73.299579] libata version 2.00 loaded.
[   73.299620] ahci 0000:00:1f.2: version 2.0
[   73.299647] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
[   73.299940] pnp: the driver 'i8042 kbd' has been registered
[   73.299973] pnp: match found with the PnP device '00:0a' and the driver 'i8042 kbd'
[   73.299979] pnp: the driver 'i8042 aux' has been registered
[   73.300010] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   73.300133] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   73.302838] serio: i8042 KBD port at 0x60,0x64 irq 1
[   73.302905] serio: i8042 AUX port at 0x60,0x64 irq 12
[   73.303054] mice: PS/2 mouse device common for all mice
[   73.303115] EDAC MC: Ver: 2.0.1 Nov 12 2006
[   73.303311] TCP cubic registered
[   73.303357] Initializing XFRM netlink socket
[   73.303410] NET: Registered protocol family 1
[   73.303461] NET: Registered protocol family 17
[   73.303511] NET: Registered protocol family 15
[   73.303562] wait_for_probes: waiting for 3 threads
[   73.326541] input: AT Translated Set 2 keyboard as /class/input/input0
[   73.504483] scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
[   73.504485]         <Adaptec 2940 Ultra2 SCSI adapter>
[   73.504486]         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
[   73.504487] 
[   73.764444] scsi 0:0:1:0: Direct-Access     IBM-PCCO ST39102LC     !# B219 PQ: 0 ANSI: 2
[   73.764508] scsi0:A:1:0: Tagged Queuing enabled.  Depth 8
[   73.764595]  target0:0:1: Beginning Domain Validation
[   73.771070]  target0:0:1: wide asynchronous
[   73.775828]  target0:0:1: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   73.780114]  target0:0:1: Domain Validation skipping write tests
[   73.780161]  target0:0:1: Ending Domain Validation
[   73.781059] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   73.783078] sda: Write Protect is off
[   73.783122] sda: Mode Sense: ab 00 10 08
[   73.784693] SCSI device sda: drive cache: write back w/ FUA
[   73.785517] SCSI device sda: 17774160 512-byte hdwr sectors (9100 MB)
[   73.787530] sda: Write Protect is off
[   73.787574] sda: Mode Sense: ab 00 10 08
[   73.789147] SCSI device sda: drive cache: write back w/ FUA
[   73.789194]  sda: sda1 sda2
[   73.795382] sd 0:0:1:0: Attached scsi disk sda
[   73.795475] sd 0:0:1:0: Attached scsi generic sg0 type 0
[   73.798550] scsi 0:0:2:0: Direct-Access     SGI      SEAGATE ST39102L 2702 PQ: 0 ANSI: 2
[   73.798610] scsi0:A:2:0: Tagged Queuing enabled.  Depth 8
[   73.798688]  target0:0:2: Beginning Domain Validation
[   73.804025]  target0:0:2: wide asynchronous
[   73.807961]  target0:0:2: FAST-40 WIDE SCSI 80.0 MB/s ST (25 ns, offset 15)
[   73.811434]  target0:0:2: Domain Validation skipping write tests
[   73.811481]  target0:0:2: Ending Domain Validation
[   73.812364] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   73.815781] sdb: Write Protect is off
[   73.815826] sdb: Mode Sense: cf 00 10 08
[   73.819585] SCSI device sdb: drive cache: write back w/ FUA
[   73.820462] SCSI device sdb: 17781520 512-byte hdwr sectors (9104 MB)
[   73.823873] sdb: Write Protect is off
[   73.823917] sdb: Mode Sense: cf 00 10 08
[   73.827680] SCSI device sdb: drive cache: write back w/ FUA
[   73.827726]  sdb: sdb1
[   73.833982] sd 0:0:2:0: Attached scsi disk sdb
[   73.834081] sd 0:0:2:0: Attached scsi generic sg1 type 0
[   74.303870] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   74.303877] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[   74.303937] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[   74.304043] ata1: SATA max UDMA/133 cmd 0xFFFFC2000001E900 ctl 0x0 bmdma 0x0 irq 316
[   74.304170] ata2: SATA max UDMA/133 cmd 0xFFFFC2000001E980 ctl 0x0 bmdma 0x0 irq 316
[   74.304278] ata3: SATA max UDMA/133 cmd 0xFFFFC2000001EA00 ctl 0x0 bmdma 0x0 irq 316
[   74.304389] ata4: SATA max UDMA/133 cmd 0xFFFFC2000001EA80 ctl 0x0 bmdma 0x0 irq 316
[   74.304450] scsi1 : ahci
[   74.761641] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   74.764015] ata1.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48 
[   74.764063] ata1.00: ata1: dev 0 multi count 16
[   74.774201] ata1.00: configured for UDMA/133
[   74.774249] scsi2 : ahci
[   75.232531] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  105.197121] ata2.00: qc timeout (cmd 0xec)
[  105.197168] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  113.040691] ata2: port is slow to respond, please be patient (Status 0x80)
[  135.973052] ata2: port failed to respond (30 secs, Status 0x80)
[  135.973098] ata2: COMRESET failed (device not ready)
[  135.973145] ata2: hardreset failed, retrying in 5 secs
[  141.836829] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  142.366267] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[  143.171270] ata2: SATA link down (SStatus 0 SControl 300)
[  143.171322] scsi3 : ahci
[  143.629025] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  143.629851] ata3.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
[  143.629910] ata3.00: ata3: dev 0 multi count 16
[  143.637526] ata3.00: configured for UDMA/133
[  143.637574] scsi4 : ahci
[  143.941875] ata4: SATA link down (SStatus 0 SControl 300)
[  143.941989] scsi 1:0:0:0: Direct-Access     ATA      WDC WD360GD-00FL 31.0 PQ: 0 ANSI: 5
[  143.942136] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  143.942189] sdc: Write Protect is off
[  143.942232] sdc: Mode Sense: 00 3a 00 00
[  143.942245] SCSI device sdc: drive cache: write back
[  143.942319] SCSI device sdc: 72303840 512-byte hdwr sectors (37020 MB)
[  143.942373] sdc: Write Protect is off
[  143.942415] sdc: Mode Sense: 00 3a 00 00
[  143.942428] SCSI device sdc: drive cache: write back
[  143.942473]  sdc: sdc1 sdc2
[  143.952358] sd 1:0:0:0: Attached scsi disk sdc
[  143.952454] sd 1:0:0:0: Attached scsi generic sg2 type 0
[  143.952565] scsi 3:0:0:0: Direct-Access     ATA      ST3250823AS      3.03 PQ: 0 ANSI: 5
[  143.952691] SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
[  143.952744] sdd: Write Protect is off
[  143.952786] sdd: Mode Sense: 00 3a 00 00
[  143.952799] SCSI device sdd: drive cache: write back
[  143.952872] SCSI device sdd: 488397168 512-byte hdwr sectors (250059 MB)
[  143.952924] sdd: Write Protect is off
[  143.952967] sdd: Mode Sense: 00 3a 00 00
[  143.952979] SCSI device sdd: drive cache: write back
[  143.953024]  sdd: sdd1 sdd2
[  143.973954] sd 3:0:0:0: Attached scsi disk sdd
[  143.974052] sd 3:0:0:0: Attached scsi generic sg3 type 0
[  143.974196] wait_for_probes: waiting for 0 threads
[  143.974953] reiser4: sdc1: found disk format 4.0.0.
[  145.196509] VFS: Mounted root (reiser4 filesystem) readonly.
[  145.196604] Freeing unused kernel memory: 200k freed
[  147.360573] Floppy drive(s): fd0 is 1.44M
[  147.376273] FDC 0 is a post-1991 82077
[  147.405642] usbcore: registered new interface driver usbfs
[  147.405709] usbcore: registered new interface driver hub
[  147.405779] usbcore: registered new device driver usb
[  147.422003] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[  147.422107] PCI: Setting latency timer of device 0000:02:00.0 to 64
[  147.422165] sky2 v1.10 addr 0xfa9fc000 irq 19 Yukon-EC (0xb6) rev 2
[  147.422403] sky2 eth0: addr 00:18:f3:3d:1b:06
[  147.496925] uhci_hcd: Unknown symbol usb_hcd_pci_suspend
[  147.496999] uhci_hcd: Unknown symbol usb_hcd_resume_root_hub
[  147.497061] uhci_hcd: Unknown symbol usb_hcd_pci_probe
[  147.497137] uhci_hcd: Unknown symbol usb_check_bandwidth
[  147.497226] uhci_hcd: Unknown symbol usb_disabled
[  147.497290] uhci_hcd: Unknown symbol usb_release_bandwidth
[  147.497406] uhci_hcd: Unknown symbol usb_claim_bandwidth
[  147.497487] uhci_hcd: Unknown symbol usb_hcd_pci_resume
[  147.497568] uhci_hcd: Unknown symbol usb_hcd_giveback_urb
[  147.497641] uhci_hcd: Unknown symbol usb_hcd_poll_rh_status
[  147.497723] uhci_hcd: Unknown symbol usb_hcd_pci_remove
[  147.497788] uhci_hcd: Unknown symbol usb_root_hub_lost_power
[  147.505461] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
[  147.505565] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[  147.505569] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[  147.505724] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[  147.505834] ehci_hcd 0000:00:1d.7: debug port 1
[  147.505884] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[  147.505893] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xfebfbc00
[  147.509807] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[  147.509909] usb usb1: new device found, idVendor=0000, idProduct=0000
[  147.509958] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.510008] usb usb1: Product: EHCI Host Controller
[  147.510053] usb usb1: Manufacturer: Linux 2.6.19-rc5-mm1 ehci_hcd
[  147.510101] usb usb1: SerialNumber: 0000:00:1d.7
[  147.510225] usb usb1: configuration #1 chosen from 1 choice
[  147.510291] hub 1-0:1.0: USB hub found
[  147.510342] hub 1-0:1.0: 8 ports detected
[  147.513491] USB Universal Host Controller Interface driver v3.0
[  147.514126] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
[  147.514225] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
[  147.514262] i2c_adapter i2c-0: adapter [SMBus I801 adapter at 0400] registered
[  147.514288] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
[  147.514387] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[  147.514391] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[  147.514459] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[  147.514539] uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
[  147.514634] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
[  147.520329] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[  147.520333] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[  147.520433] usb usb2: new device found, idVendor=0000, idProduct=0000
[  147.520483] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.520531] usb usb2: Product: UHCI Host Controller
[  147.520577] usb usb2: Manufacturer: Linux 2.6.19-rc5-mm1 uhci_hcd
[  147.520624] usb usb2: SerialNumber: 0000:00:1d.0
[  147.520733] usb usb2: configuration #1 chosen from 1 choice
[  147.520802] hub 2-0:1.0: USB hub found
[  147.520851] hub 2-0:1.0: 2 ports detected
[  147.520919] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[  147.521005] uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
[  147.523530] ACPI: PCI Interrupt 0000:00:1d.2[C] -> <6>usb usb3: new device found, idVendor=0000, idProduct=0000
[  147.523573] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.523577] usb usb3: Product: UHCI Host Controller
[  147.523579] usb usb3: Manufacturer: Linux 2.6.19-rc5-mm1 uhci_hcd
[  147.523581] usb usb3: SerialNumber: 0000:00:1d.1
[  147.523646] usb usb3: configuration #1 chosen from 1 choice
[  147.523669] hub 3-0:1.0: USB hub found
[  147.523675] hub 3-0:1.0: 2 ports detected
[  147.523704] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
[  147.523716] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[  147.523719] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[  147.523741] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[  147.523777] uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
[  147.523838] usb usb4: new device found, idVendor=0000, idProduct=0000
[  147.523841] usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.523843] usb usb4: Product: UHCI Host Controller
[  147.523844] usb usb4: Manufacturer: Linux 2.6.19-rc5-mm1 uhci_hcd
[  147.523846] usb usb4: SerialNumber: 0000:00:1d.3
[  147.523891] usb usb4: configuration #1 chosen from 1 choice
[  147.523910] hub 4-0:1.0: USB hub found
[  147.523914] hub 4-0:1.0: 2 ports detected
[  147.539333] GSI 18 (level, low) -> IRQ 18
[  147.539390] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[  147.539394] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[  147.539472] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
[  147.539558] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
[  147.539676] usb usb5: new device found, idVendor=0000, idProduct=0000
[  147.539732] usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
[  147.539782] usb usb5: Product: UHCI Host Controller
[  147.539827] usb usb5: Manufacturer: Linux 2.6.19-rc5-mm1 uhci_hcd
[  147.539873] usb usb5: SerialNumber: 0000:00:1d.2
[  147.539991] usb usb5: configuration #1 chosen from 1 choice
[  147.540055] hub 5-0:1.0: USB hub found
[  147.540101] hub 5-0:1.0: 2 ports detected
[  147.570396] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
[  147.570540] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[  147.621303] hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
[  148.439518] usb 1-7: new high speed USB device using ehci_hcd and address 6
[  148.501973] Adding 1959920k swap on /dev/sdc2.  Priority:-1 extents:1 across:1959920k
[  148.554509] usb 1-7: new device found, idVendor=05e3, idProduct=0606
[  148.554567] usb 1-7: new device strings: Mfr=0, Product=1, SerialNumber=0
[  148.554614] usb 1-7: Product: USB2.0 Hub
[  148.554725] usb 1-7: configuration #1 chosen from 1 choice
[  148.555024] hub 1-7:1.0: USB hub found
[  148.555377] hub 1-7:1.0: 4 ports detected
[  148.760729] usb 2-1: new low speed USB device using uhci_hcd and address 2
[  148.931995] usb 2-1: new device found, idVendor=045e, idProduct=001e
[  148.932043] usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
[  148.932090] usb 2-1: Product: Microsoft IntelliMouse® Explorer
[  148.932135] usb 2-1: Manufacturer: Microsoft
[  148.932252] usb 2-1: configuration #1 chosen from 1 choice
[  149.097333] usb 2-2: new low speed USB device using uhci_hcd and address 3
[  149.255606] usb 2-2: new device found, idVendor=0d3d, idProduct=0001
[  149.255709] usb 2-2: new device strings: Mfr=0, Product=2, SerialNumber=0
[  149.255812] usb 2-2: Product: USBPS2
[  149.255970] usb 2-2: configuration #1 chosen from 1 choice
[  149.444210] i2c_adapter i2c-9191: ISA main adapter registered
[  149.448478] i2c-core: driver [eeprom] registered
[  149.448483] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x50
[  149.448502] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a0, DAT0=78, DAT1=00
[  149.450638] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a0, DAT0=78, DAT1=00
[  149.450656] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a0, DAT0=78, DAT1=00
[  149.452677] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a0, DAT0=78, DAT1=00
[  149.452681] i2c_adapter i2c-0: client [eeprom] registered with bus id 0-0050
[  149.452712] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x51
[  149.452730] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a2, DAT0=78, DAT1=00
[  149.454696] i801_smbus 0000:00:1f.3: Error: no response!
[  149.454715] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a2, DAT0=78, DAT1=00
[  149.454719] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x52
[  149.454736] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a4, DAT0=78, DAT1=00
[  149.456751] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a4, DAT0=78, DAT1=00
[  149.456769] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a4, DAT0=78, DAT1=00
[  149.458788] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a4, DAT0=78, DAT1=00
[  149.458792] i2c_adapter i2c-0: client [eeprom] registered with bus id 0-0052
[  149.458816] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x53
[  149.458834] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a6, DAT0=78, DAT1=00
[  149.460811] i801_smbus 0000:00:1f.3: Error: no response!
[  149.460830] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a6, DAT0=78, DAT1=00
[  149.460833] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x54
[  149.460851] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=a8, DAT0=78, DAT1=00
[  149.462848] i801_smbus 0000:00:1f.3: Error: no response!
[  149.462866] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=a8, DAT0=78, DAT1=00
[  149.462870] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x55
[  149.462887] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=aa, DAT0=78, DAT1=00
[  149.464887] i801_smbus 0000:00:1f.3: Error: no response!
[  149.464907] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=aa, DAT0=78, DAT1=00
[  149.464910] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x56
[  149.464928] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=ac, DAT0=78, DAT1=00
[  149.466924] i801_smbus 0000:00:1f.3: Error: no response!
[  149.466943] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=ac, DAT0=78, DAT1=00
[  149.466946] i2c_adapter i2c-0: found normal entry for adapter 0, addr 0x57
[  149.466963] i801_smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD=30, ADD=ae, DAT0=78, DAT1=00
[  149.468962] i801_smbus 0000:00:1f.3: Error: no response!
[  149.468980] i801_smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD=30, ADD=ae, DAT0=78, DAT1=00
[  149.484960] i2c_adapter i2c-9191: Driver w83627ehf registered
[  149.484968] i2c_adapter i2c-9191: client [w83627ehf] registered with bus id 9191-0290
[  149.489348] Initializing USB Mass Storage driver...
[  149.540220] usb 5-1: new full speed USB device using uhci_hcd and address 2
[  149.697140] usb 5-1: new device found, idVendor=07af, idProduct=0006
[  149.697188] usb 5-1: new device strings: Mfr=1, Product=2, SerialNumber=0
[  149.697236] usb 5-1: Product: DPCM-USB
[  149.697280] usb 5-1: Manufacturer: Microtech International, Inc
[  149.697417] usb 5-1: configuration #1 chosen from 1 choice
[  149.874425] usb 5-2: new full speed USB device using uhci_hcd and address 3
[  150.184871] usb 1-7.3: new high speed USB device using ehci_hcd and address 7
[  150.262165] usbcore: registered new interface driver hiddev
[  150.267647] usb 1-7.3: new device found, idVendor=0bda, idProduct=8187
[  150.267697] usb 1-7.3: new device strings: Mfr=1, Product=2, SerialNumber=3
[  150.267745] usb 1-7.3: Product: RTL8187_Wireless
[  150.267790] usb 1-7.3: Manufacturer: Manufacturer_Realtek_RTL8187_
[  150.267837] usb 1-7.3: SerialNumber: 0015AF05C9DE
[  150.267964] usb 1-7.3: configuration #1 chosen from 1 choice
[  150.276515] input: Microsoft Microsoft IntelliMouse® Explorer as /class/input/input1
[  150.276601] input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Explorer] on usb-0000:00:1d.0-1
[  150.290540] input: USBPS2 as /class/input/input2
[  150.290616] input: USB HID v1.00 Keyboard [USBPS2] on usb-0000:00:1d.0-2
[  150.312537] input: USBPS2 as /class/input/input3
[  150.312627] input: USB HID v1.00 Mouse [USBPS2] on usb-0000:00:1d.0-2
[  150.312754] usbcore: registered new interface driver usbhid
[  150.312800] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[  150.313225] scsi5 : SCSI emulation for USB Mass Storage devices
[  150.313316] usb-storage: device found at 2
[  150.313318] usb-storage: waiting for device to settle before scanning
[  150.313326] usbcore: registered new interface driver usb-storage
[  150.313374] USB Mass Storage support registered.
[  150.432062] ata2: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0x2 frozen
[  150.432125] ata2: (irq_stat 0x00000040, connection status changed)
[  150.487257] reiser4: sda1: found disk format 4.0.0.
[  150.624672] logsave[1192]: segfault at 0000000000000000 rip 0000000000000000 rsp 00007fff96b7c278 error 4
[  150.952806] ata2: waiting for device to spin up (8 secs)
[  151.513482] sky2 eth0: enabling interface
[  153.979191] sky2 eth0: Link is up at 1000 Mbps, full duplex, flow control both
[  155.050946] usb 5-2: new device found, idVendor=03f0, idProduct=0401
[  155.051006] usb 5-2: new device strings: Mfr=1, Product=2, SerialNumber=3
[  155.051054] usb 5-2: Product: HP ScanJet 5200C
[  155.051098] usb 5-2: Manufacturer: Hewlett-Packard
[  155.051143] usb 5-2: SerialNumber: SG91U161Z2HT
[  155.051279] usb 5-2: configuration #1 chosen from 1 choice
[  155.315660] scsi 5:0:0:0: Direct-Access     ßßßßßßßß ßßßßßßßßßßßßßßßß X{s? PQ: 0 ANSI: 2
[  155.330669] sd 5:0:0:0: Attached scsi removable disk sde
[  155.330749] sd 5:0:0:0: Attached scsi generic sg4 type 0
[  155.331191] usb-storage: device scan complete
[  159.143855] ata2: soft resetting port
[  159.298902] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  165.583612] nvidia: module license 'NVIDIA' taints kernel.
[  165.839513] ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[  165.839526] PCI: Setting latency timer of device 0000:04:00.0 to 64
[  165.839812] NVRM: loading NVIDIA Linux x86_64 Kernel Module  1.0-9629  Wed Nov  1 19:27:33 PST 2006
[  166.246524] i2c_adapter i2c-1: adapter [NVIDIA i2c adapter 0 at 4:00.0] registered
[  166.246532] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x50
[  166.246536] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x51
[  166.246539] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x52
[  166.246541] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x53
[  166.246544] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x54
[  166.246546] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x55
[  166.246549] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x56
[  166.246551] i2c_adapter i2c-1: found normal entry for adapter 1, addr 0x57
[  166.246570] i2c_adapter i2c-2: adapter [NVIDIA i2c adapter 1 at 4:00.0] registered
[  166.246573] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x50
[  166.246575] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x51
[  166.246578] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x52
[  166.246581] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x53
[  166.246583] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x54
[  166.246586] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x55
[  166.246588] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x56
[  166.246591] i2c_adapter i2c-2: found normal entry for adapter 2, addr 0x57
[  166.246609] i2c_adapter i2c-3: adapter [NVIDIA i2c adapter 2 at 4:00.0] registered
[  166.246615] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x50
[  166.246619] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x51
[  166.246622] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x52
[  166.246627] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x53
[  166.246631] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x54
[  166.246634] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x55
[  166.246639] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x56
[  166.246643] i2c_adapter i2c-3: found normal entry for adapter 3, addr 0x57
[  189.264067] ata2.00: qc timeout (cmd 0xec)
[  189.264075] ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
[  190.284155] ata2: hard resetting port
[  198.050132] ata2: port is slow to respond, please be patient (Status 0x80)
[  220.984721] ata2: port failed to respond (30 secs, Status 0x80)
[  220.984727] ata2: COMRESET failed (device not ready)
[  220.984731] ata2: hardreset failed, retrying in 5 secs
[  225.980360] ata2: hard resetting port
[  226.859646] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  226.859714] ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA 
[  226.859717] ata2.00: ata2: dev 0 multi count 1
[  226.866670] ata2.00: configured for UDMA/133
[  226.866678] ata2: EH complete
[  226.866914] scsi 2:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
[  226.867060] SCSI device sdf: 640 512-byte hdwr sectors (0 MB)
[  226.867151] sdf: Write Protect is off
[  226.867154] sdf: Mode Sense: 00 3a 00 00
[  226.867342] SCSI device sdf: drive cache: write through
[  226.867474] SCSI device sdf: 640 512-byte hdwr sectors (0 MB)
[  226.867564] sdf: Write Protect is off
[  226.867567] sdf: Mode Sense: 00 3a 00 00
[  226.867737] SCSI device sdf: drive cache: write through
[  226.867740]  sdf: unknown partition table
[  226.867951] sd 2:0:0:0: Attached scsi disk sdf
[  226.867985] sd 2:0:0:0: Attached scsi generic sg5 type 0

--------------050502070702050704050102--
