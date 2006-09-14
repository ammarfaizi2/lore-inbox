Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWINKfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWINKfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWINKfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:35:20 -0400
Received: from holoclan.de ([62.75.158.126]:47823 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1751114AbWINKfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:35:17 -0400
Date: Thu, 14 Sep 2006 12:32:29 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ltp] do I have to worry?
Message-ID: <20060914103229.GC7806@gimli>
References: <20060912102844.GH7767@gimli> <20060912144106.GT7767@gimli> <450712D2.6080209@intel.com> <20060912205154.GB7767@gimli> <450720CA.3070303@intel.com> <20060912214845.GE7767@gimli> <45073051.1030708@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <45073051.1030708@intel.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Sep 12, 2006 at 03:10:25PM -0700, Auke Kok
	wrote: > Martin Lorenz wrote: > >Dear Auke, > > > >thank you for your
	quick response > >I currently compile a new kernel from Linus' latest
	tree with the attached > >patches to get suspend with my sata drive and
	my wireless working. > > > >I will test the hotdocking with this kernel
	as soon as I am back at work > >because the X6 is there > > > >I think I
	found the bridge: > >/usr/local/bin/vmnet-bridge -d
	/var/run/vmnet-bridge-0.pid /dev/vmnet0 eth0 > >so it's the vmware
	module > > > >I will try with loaded and unloaded vmware modules to tell
	the difference > > > >I hope I can provide some help > > cool, let me
	know what happens once you get to it. Even if it turns out to > be a
	vmware problem I can take a look at it and pass it on to vmware maybe.
	[...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 12, 2006 at 03:10:25PM -0700, Auke Kok wrote:
> Martin Lorenz wrote:
> >Dear Auke,
> >
> >thank you for your quick response
> >I currently compile a new kernel from Linus' latest tree with the attached
> >patches to get suspend with my sata drive and my wireless working.
> >
> >I will test the hotdocking with this kernel as soon as I am back at work
> >because the X6 is there
> >
> >I think I found the bridge:
> >/usr/local/bin/vmnet-bridge -d /var/run/vmnet-bridge-0.pid /dev/vmnet0 eth0
> >so it's the vmware module
> >
> >I will try with loaded and unloaded vmware modules to tell the difference
> >
> >I hope I can provide some help
> 
> cool, let me know what happens once you get to it. Even if it turns out to 
> be a vmware problem I can take a look at it and pass it on to vmware maybe.

diden't see it again. I will keep my eyes open but hot docking seems to work
with a vmware bridge running.

I attach the dmesg of this latest try

even leaving the USB memory in the bay while undocking is ok now.
only it dosen't get reattached on docking than. I had to unplug and replug
it.



my status is as follows:

commit 14bcfd12d228ef264340bc59c0bc961827e2fbcd
tree 8673b699067071e1e439cc1fd7e072910590cf63
parent 3581f3bf31e8b79837cbfd9220c304c2bfcf3378
author Martin Lorenz <mlo@gimli.lorenz.eu.org> Mi, 13 Sep 2006 10:10:41
+0200
committer Martin Lorenz <mlo@gimli.lorenz.eu.org> Mi, 13 Sep 2006 10:10:41
+0200

    The set of patches by Forrest Zhao
    I need this to get resume working with my SATA controller or disk
    00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller AHCI (rev 02)
    Vendor: ATA      Model: FUJITSU MHV2080B Rev: 0084

commit 3581f3bf31e8b79837cbfd9220c304c2bfcf3378
tree c1ba92c4aff33bcd2a48fb107068e6db81a84917
parent 95064a75ebf8744e1ff595e8cd7ff9b6c851523e
author Martin Lorenz <mlo@gimli.lorenz.eu.org> Mi, 13 Sep 2006 10:10:41
+0200
committer Martin Lorenz <mlo@gimli.lorenz.eu.org> Mi, 13 Sep 2006 10:10:41
+0200

    the contents of version 1.2.15 of the ieee80211 project
    use this to get the ipw3945ABG wireless adapter up and running

commit 95064a75ebf8744e1ff595e8cd7ff9b6c851523e
tree ada80794ea45710e86666cd3cf340187a1e38fd0
parent bd314d976e22e82c55e96603804ed7cb0514d252
author Linus Torvalds <torvalds@g5.osdl.org> Di, 12 Sep 2006 18:41:36 -0700
committer Linus Torvalds <torvalds@g5.osdl.org> Di, 12 Sep 2006 18:41:36
-0700

    Linux v2.6.18-rc7

    One last time..


regarding the SATA patches I recently found some discussion about Forrest
Zhaos patchset and lost the track somewhere on GMANE.

maybe Forrest, Tejun, or Jeff or whoever knows could tell the audience what 
the latest status on this issue is

cheers and thanks
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_2.6.18-rc7-ahci+ieee80211-g14bcfd12-dirty.hotdock"

08267] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[    0.209948] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[    0.210049] PCI: Bridge: 0000:00:1c.0
[    0.210142]   IO window: 2000-2fff
[    0.210237]   MEM window: ee000000-ee0fffff
[    0.210330]   PREFETCH window: disabled.
[    0.210424] PCI: Bridge: 0000:00:1c.1
[    0.210516]   IO window: 3000-4fff
[    0.210619]   MEM window: ec000000-edffffff
[    0.210714]   PREFETCH window: e4000000-e40fffff
[    0.210809] PCI: Bridge: 0000:00:1c.2
[    0.210903]   IO window: 5000-6fff
[    0.210996]   MEM window: e8000000-e9ffffff
[    0.211091]   PREFETCH window: e4100000-e41fffff
[    0.211186] PCI: Bridge: 0000:00:1c.3
[    0.211279]   IO window: 7000-8fff
[    0.211373]   MEM window: ea000000-ebffffff
[    0.211468]   PREFETCH window: e4200000-e42fffff
[    0.211569] PCI: Bus 22, cardbus bridge: 0000:15:00.0
[    0.211670]   IO window: 00009000-000090ff
[    0.211766]   IO window: 00009400-000094ff
[    0.211861]   PREFETCH window: e0000000-e1ffffff
[    0.211957]   MEM window: e6000000-e7ffffff
[    0.212052] PCI: Bridge: 0000:00:1e.0
[    0.212144]   IO window: 9000-cfff
[    0.212238]   MEM window: e4300000-e7ffffff
[    0.212333]   PREFETCH window: e0000000-e3ffffff
[    0.212449] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 169
[    0.212642] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.212665] ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 21 (level, low) -> IRQ 177
[    0.212850] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.212873] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
[    0.213057] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.213080] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 23 (level, low) -> IRQ 193
[    0.213265] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.213277] PCI: Enabling device 0000:00:1e.0 (0005 -> 0007)
[    0.213375] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    0.213394] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 201
[    0.213579] PCI: Setting latency timer of device 0000:15:00.0 to 64
[    0.213621] NET: Registered protocol family 2
[    0.225642] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.225889] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.228862] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[    0.229695] TCP: Hash tables configured (established 262144 bind 65536)
[    0.229793] TCP reno registered
[    0.230096] Simple Boot Flag at 0x35 set to 0x1
[    0.231777] audit: initializing netlink socket (disabled)
[    0.231888] audit(1158224747.688:1): initialized
[    0.232079] highmem bounce pool size: 64 pages
[    0.232433] Initializing Cryptographic API
[    0.232528] io scheduler noop registered
[    0.232693] io scheduler anticipatory registered
[    0.232839] io scheduler deadline registered
[    0.232995] io scheduler cfq registered (default)
[    0.233490] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    0.233543] assign_interrupt_mode Found MSI capability
[    0.233707] Allocate Port Service[0000:00:1c.0:pcie00]
[    0.233757] Allocate Port Service[0000:00:1c.0:pcie02]
[    0.233804] Allocate Port Service[0000:00:1c.0:pcie03]
[    0.233861] PCI: Setting latency timer of device 0000:00:1c.1 to 64
[    0.233914] assign_interrupt_mode Found MSI capability
[    0.234055] Allocate Port Service[0000:00:1c.1:pcie00]
[    0.234109] Allocate Port Service[0000:00:1c.1:pcie02]
[    0.234157] Allocate Port Service[0000:00:1c.1:pcie03]
[    0.234215] PCI: Setting latency timer of device 0000:00:1c.2 to 64
[    0.234267] assign_interrupt_mode Found MSI capability
[    0.234407] Allocate Port Service[0000:00:1c.2:pcie00]
[    0.234454] Allocate Port Service[0000:00:1c.2:pcie02]
[    0.234501] Allocate Port Service[0000:00:1c.2:pcie03]
[    0.234562] PCI: Setting latency timer of device 0000:00:1c.3 to 64
[    0.234641] assign_interrupt_mode Found MSI capability
[    0.234782] Allocate Port Service[0000:00:1c.3:pcie00]
[    0.234831] Allocate Port Service[0000:00:1c.3:pcie02]
[    0.234876] Allocate Port Service[0000:00:1c.3:pcie03]
[    0.268446] Real Time Clock Driver v1.12ac
[    0.268620] hpet_resources: 0xfed00000 is busy
[    0.268650] Linux agpgart interface v0.101 (c) Dave Jones
[    0.268793] agpgart: Detected an Intel 945GM Chipset.
[    0.270805] agpgart: Detected 7932K stolen memory.
[    0.288266] agpgart: AGP aperture is 256M @ 0xd0000000
[    0.288412] [drm] Initialized drm 1.0.1 20051102
[    0.288916] loop: loaded (max 8 devices)
[    0.289008] Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
[    0.289104] Copyright (c) 1999-2006 Intel Corporation.
[    0.290103] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 201
[    0.290299] PCI: Setting latency timer of device 0000:02:00.0 to 64
[    0.335831] e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:16:d3:22:9b:82
[    0.380318] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[    0.380552] netconsole: not configured, aborting
[    0.380707] libata version 2.00 loaded.
[    0.380763] ahci 0000:00:1f.2: version 2.0
[    0.380783] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 201
[    4.686501] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    4.686512] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0x1 impl SATA mode
[    4.686649] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
[    4.686843] ata1: SATA max UDMA/133 cmd 0xF8826500 ctl 0x0 bmdma 0x0 irq 58
[    4.687013] ata2: Could not start DMA engineof port (-1)
[    4.687107] ata2: SATA max UDMA/133 cmd 0xF8826580 ctl 0x0 bmdma 0x0 irq 58
[    4.687275] ata3: Could not start DMA engineof port (-1)
[    4.687369] ata3: SATA max UDMA/133 cmd 0xF8826600 ctl 0x0 bmdma 0x0 irq 58
[    4.687539] ata4: Could not start DMA engineof port (-1)
[    4.687633] ata4: SATA max UDMA/133 cmd 0xF8826680 ctl 0x0 bmdma 0x0 irq 58
[    4.687740] scsi0 : ahci
[    5.145782] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.146239] ata1.00: ATA-7, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 31/32)
[    5.146373] ata1.00: ata1: dev 0 multi count 16
[    5.148803] ata1.00: configured for UDMA/100
[    5.148901] scsi1 : ahci
[    5.452283] ata2: SATA link down (SStatus 0 SControl 0)
[    5.452386] scsi2 : ahci
[    5.755800] ata3: SATA link down (SStatus 0 SControl 0)
[    5.755904] scsi3 : ahci
[    6.058320] ata4: SATA link down (SStatus 0 SControl 0)
[    6.058538]   Vendor: ATA       Model: FUJITSU MHV2080B  Rev: 0084
[    6.060041]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    6.060570] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    6.060685] sda: Write Protect is off
[    6.060777] sda: Mode Sense: 00 3a 00 00
[    6.060801] SCSI device sda: drive cache: write back
[    6.060953] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    6.061061] sda: Write Protect is off
[    6.061153] sda: Mode Sense: 00 3a 00 00
[    6.061176] SCSI device sda: drive cache: write back
[    6.061270]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 >
[    6.282647] sd 0:0:0:0: Attached scsi disk sda
[    6.282860] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    6.290501] serio: i8042 AUX port at 0x60,0x64 irq 12
[    6.291397] serio: i8042 KBD port at 0x60,0x64 irq 1
[    6.291652] mice: PS/2 mouse device common for all mice
[    6.291746] i2c /dev entries driver
[    6.292856] ACPI: PCI Interrupt 0000:00:1f.3[A] -> GSI 23 (level, low) -> IRQ 193
[    6.293175] hdaps: inverting axis readings.
[    6.293273] hdaps: Lenovo ThinkPad X60 detected.
[    6.306167] input: AT Translated Set 2 keyboard as /class/input/input0
[    6.306881] input: hdaps as /class/input/input1
[    6.306977] hdaps: driver successfully loaded.
[    6.307068] EDAC MC: Ver: 2.0.1 Sep 13 2006
[    6.307780] TCP bic registered
[    6.307878] NET: Registered protocol family 1
[    6.307977] NET: Registered protocol family 17
[    6.308076] Starting balanced_irq
[    6.308171] Using IPI No-Shortcut mode
[    6.308686] ACPI: (supports S0 S3 S4 S5)
[    6.309076] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[    6.309221] Time: tsc clocksource has been installed.
[    6.311981] VFS: Mounted root (ext2 filesystem) readonly.
[    6.312217] Freeing unused kernel memory: 176k freed
[    8.826149] input: PC Speaker as /class/input/input2
[    9.220193] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[    9.220373] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[    9.638649] usbcore: registered new driver usbfs
[    9.638785] usbcore: registered new driver hub
[    9.792798] ieee1394: Initialized config rom entry `ip1394'
[    9.839003] ACPI: PCI Interrupt 0000:15:00.1[B] -> GSI 17 (level, low) -> IRQ 66
[    9.839203] PCI: Setting latency timer of device 0000:15:00.1 to 64
[    9.892913] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[66]  MMIO=[e4301000-e43017ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[    9.908845] sdhci: Secure Digital Host Controller Interface driver, 0.12
[    9.908945] sdhci: Copyright(c) Pierre Ossman
[    9.909073] sdhci: SDHCI controller found at 0000:15:00.2 [1180:0822] (rev 18)
[    9.909229] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 74
[    9.910432] PCI: Setting latency timer of device 0000:15:00.2 to 64
[    9.912495] mmc0: SDHCI at 0xe4301800 irq 74 DMA
[    9.940463] irda_init()
[    9.940479] NET: Registered protocol family 23
[    9.955662] USB Universal Host Controller Interface driver v3.0
[    9.955815] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 201
[    9.956008] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[    9.956014] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    9.956311] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[    9.956481] uhci_hcd 0000:00:1d.0: irq 201, io base 0x00001820
[    9.956733] usb usb1: configuration #1 chosen from 1 choice
[    9.956864] hub 1-0:1.0: USB hub found
[    9.956964] hub 1-0:1.0: 2 ports detected
[   10.058132] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 66
[   10.058329] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   10.058335] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   10.058467] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   10.058634] uhci_hcd 0000:00:1d.1: irq 66, io base 0x00001840
[   10.058869] usb usb2: configuration #1 chosen from 1 choice
[   10.059425] hub 2-0:1.0: USB hub found
[   10.059528] hub 2-0:1.0: 2 ports detected
[   10.160976] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 74
[   10.161173] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   10.161179] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   10.161316] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   10.161483] uhci_hcd 0000:00:1d.2: irq 74, io base 0x00001860
[   10.161706] usb usb3: configuration #1 chosen from 1 choice
[   10.161838] hub 3-0:1.0: USB hub found
[   10.161935] hub 3-0:1.0: 2 ports detected
[   10.263780] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 82
[   10.263974] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   10.263979] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   10.264103] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[   10.264280] uhci_hcd 0000:00:1d.3: irq 82, io base 0x00001880
[   10.264504] usb usb4: configuration #1 chosen from 1 choice
[   10.264638] hub 4-0:1.0: USB hub found
[   10.264735] hub 4-0:1.0: 2 ports detected
[   10.366364] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 82
[   10.366570] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   10.366576] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   10.366711] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
[   10.366883] ehci_hcd 0000:00:1d.7: debug port 1
[   10.366984] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[   10.366993] ehci_hcd 0000:00:1d.7: irq 82, io mem 0xee444000
[   10.370963] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   10.371497] usb usb5: configuration #1 chosen from 1 choice
[   10.371626] hub 5-0:1.0: USB hub found
[   10.371724] hub 5-0:1.0: 8 ports detected
[   10.472469] Yenta: CardBus bridge found at 0000:15:00.0 [17aa:201c]
[   10.491279] IBM TrackPoint firmware: 0x0e, buttons: 3/3
[   10.512826] input: TPPS/2 IBM TrackPoint as /class/input/input3
[   10.517678] pnp: Device 00:0a activated.
[   10.517783] nsc_ircc_pnp_probe() : From PnP, found firbase 0x2F8 ; irq 5 ; dma 1.
[   10.517812] nsc-ircc, chip->init
[   10.517919] nsc-ircc, Found chip at base=0x164e
[   10.518055] nsc-ircc, driver loaded (Dag Brattli)
[   10.518245] IrDA: Registered device irda0
[   10.518403] nsc-ircc, Found dongle: No dongle connected
[   10.518505] nsc_ircc_init_dongle_interface(), No dongle connected
[   10.594825] Yenta: ISA IRQ mask 0x0c98, PCI irq 201
[   10.594925] Socket status: 30000006
[   10.595018] pcmcia: parent PCI bridge I/O window: 0x9000 - 0xcfff
[   10.595116] pcmcia: parent PCI bridge Memory window: 0xe4300000 - 0xe7ffffff
[   10.595214] pcmcia: parent PCI bridge Memory window: 0xe0000000 - 0xe3ffffff
[   10.595584] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 66
[   10.595796] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   10.777818] hda_intel: azx_get_response timeout, switching to single_cmd mode...
[   11.114301] usb 4-1: new full speed USB device using uhci_hcd and address 2
[   11.162367] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40600192017]
[   11.216871] eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[   11.275973] usb 4-1: configuration #1 chosen from 1 choice
[   11.344946] Bluetooth: Core ver 2.10
[   11.345543] NET: Registered protocol family 31
[   11.345679] Bluetooth: HCI device and connection manager initialized
[   11.345819] Bluetooth: HCI socket layer initialized
[   11.350409] Bluetooth: HCI USB driver ver 2.9
[   11.484701] usb 4-2: new full speed USB device using uhci_hcd and address 3
[   11.650409] usb 4-2: configuration #1 chosen from 1 choice
[   11.656911] usbcore: registered new driver hci_usb
[   22.270448] Adding 1951856k swap on /dev/sda12.  Priority:-1 extents:1 across:1951856k
[   22.271664] Adding 2931820k swap on /dev/sda13.  Priority:-2 extents:1 across:2931820k
[   24.443370] Non-volatile memory driver v1.2
[   24.479615] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   24.479716] ieee1394: sbp2: Try serialize_io=0 for better performance
[   24.499685] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
[   24.499785] ibm_acpi: http://ibm-acpi.sf.net/
[   24.519528] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
[   24.520306] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
[   24.521642] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   24.521920] ACPI: Processor [CPU0] (supports 8 throttling states)
[   24.523080] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
[   24.523787] ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
[   24.525183] ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
[   24.525460] ACPI: Processor [CPU1] (supports 8 throttling states)
[   24.748000] Time: hpet clocksource has been installed.
[   43.927000] ReiserFS: sda14: found reiserfs format "3.6" with standard journal
[   45.905000] ReiserFS: sda14: warning: CONFIG_REISERFS_CHECK is set ON
[   45.905000] ReiserFS: sda14: warning: - it is slow mode for debugging.
[   45.905000] ReiserFS: sda14: using ordered data mode
[   45.917000] ReiserFS: sda14: journal params: device sda14, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   45.918000] ReiserFS: sda14: checking transaction log (sda14)
[   45.918000] ReiserFS: sda14: journal-1153: found in header: first_unflushed_offset 4203, last_flushed_trans_id 8137
[   45.928000] ReiserFS: sda14: journal-1206: Starting replay from offset 34952443859051, trans_id 1
[   45.928000] ReiserFS: sda14: journal-1299: Setting newest_mount_id to 103
[   45.962000] ReiserFS: sda14: Using r5 hash to sort names
[   46.025000] ReiserFS: sda8: found reiserfs format "3.6" with standard journal
[   47.160000] ReiserFS: sda8: warning: CONFIG_REISERFS_CHECK is set ON
[   47.160000] ReiserFS: sda8: warning: - it is slow mode for debugging.
[   47.160000] ReiserFS: sda8: using ordered data mode
[   47.177000] ReiserFS: sda8: journal params: device sda8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   47.177000] ReiserFS: sda8: checking transaction log (sda8)
[   47.177000] ReiserFS: sda8: journal-1153: found in header: first_unflushed_offset 6487, last_flushed_trans_id 355399
[   47.182000] ReiserFS: sda8: journal-1206: Starting replay from offset 1526431377004887, trans_id 3223778538
[   47.182000] ReiserFS: sda8: journal-1299: Setting newest_mount_id to 103
[   47.194000] ReiserFS: sda8: Using r5 hash to sort names
[   47.232000] ReiserFS: sda11: found reiserfs format "3.6" with standard journal
[   47.352000] ReiserFS: sda11: warning: CONFIG_REISERFS_CHECK is set ON
[   47.352000] ReiserFS: sda11: warning: - it is slow mode for debugging.
[   47.352000] ReiserFS: sda11: using ordered data mode
[   47.360000] ReiserFS: sda11: journal params: device sda11, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   47.360000] ReiserFS: sda11: checking transaction log (sda11)
[   47.360000] ReiserFS: sda11: journal-1153: found in header: first_unflushed_offset 4295, last_flushed_trans_id 4171
[   47.376000] ReiserFS: sda11: journal-1206: Starting replay from offset 17918603563207, trans_id 3223626341
[   47.376000] ReiserFS: sda11: journal-1299: Setting newest_mount_id to 103
[   47.404000] ReiserFS: sda11: Using r5 hash to sort names
[   47.421000] ReiserFS: sda10: found reiserfs format "3.6" with standard journal
[   47.476000] ReiserFS: sda10: warning: CONFIG_REISERFS_CHECK is set ON
[   47.476000] ReiserFS: sda10: warning: - it is slow mode for debugging.
[   47.476000] ReiserFS: sda10: using ordered data mode
[   47.487000] ReiserFS: sda10: journal params: device sda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   47.487000] ReiserFS: sda10: checking transaction log (sda10)
[   47.487000] ReiserFS: sda10: journal-1153: found in header: first_unflushed_offset 4295, last_flushed_trans_id 4171
[   47.497000] ReiserFS: sda10: journal-1206: Starting replay from offset 17918603563207, trans_id 3223626341
[   47.497000] ReiserFS: sda10: journal-1299: Setting newest_mount_id to 103
[   47.509000] ReiserFS: sda10: Using r5 hash to sort names
[   47.526000] ReiserFS: sda9: found reiserfs format "3.6" with standard journal
[   47.623000] ReiserFS: sda9: warning: CONFIG_REISERFS_CHECK is set ON
[   47.623000] ReiserFS: sda9: warning: - it is slow mode for debugging.
[   47.624000] ReiserFS: sda9: using ordered data mode
[   47.633000] ReiserFS: sda9: journal params: device sda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   47.633000] ReiserFS: sda9: checking transaction log (sda9)
[   47.633000] ReiserFS: sda9: journal-1153: found in header: first_unflushed_offset 1755, last_flushed_trans_id 26788
[   47.638000] ReiserFS: sda9: journal-1206: Starting replay from offset 115057878894299, trans_id 3223626341
[   47.638000] ReiserFS: sda9: journal-1299: Setting newest_mount_id to 103
[   47.638000] ReiserFS: sda9: Using r5 hash to sort names
[   47.664000] ReiserFS: sda7: found reiserfs format "3.6" with standard journal
[   48.215000] ReiserFS: sda7: warning: CONFIG_REISERFS_CHECK is set ON
[   48.216000] ReiserFS: sda7: warning: - it is slow mode for debugging.
[   48.216000] ReiserFS: sda7: using ordered data mode
[   48.225000] ReiserFS: sda7: journal params: device sda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   48.226000] ReiserFS: sda7: checking transaction log (sda7)
[   48.226000] ReiserFS: sda7: journal-1153: found in header: first_unflushed_offset 3289, last_flushed_trans_id 352744
[   48.238000] ReiserFS: sda7: journal-1206: Starting replay from offset 1515028238830809, trans_id 4159454704
[   48.238000] ReiserFS: sda7: journal-1299: Setting newest_mount_id to 103
[   48.297000] ReiserFS: sda7: Using r5 hash to sort names
[   48.337000] ReiserFS: sda6: found reiserfs format "3.6" with standard journal
[   48.505000] ReiserFS: sda6: warning: CONFIG_REISERFS_CHECK is set ON
[   48.505000] ReiserFS: sda6: warning: - it is slow mode for debugging.
[   48.505000] ReiserFS: sda6: using ordered data mode
[   48.518000] ReiserFS: sda6: journal params: device sda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
[   48.519000] ReiserFS: sda6: checking transaction log (sda6)
[   48.519000] ReiserFS: sda6: journal-1153: found in header: first_unflushed_offset 8049, last_flushed_trans_id 345519
[   48.523000] ReiserFS: sda6: journal-1206: Starting replay from offset 1483997100121969, trans_id 4159454704
[   48.523000] ReiserFS: sda6: journal-1299: Setting newest_mount_id to 103
[   48.559000] ReiserFS: sda6: Using r5 hash to sort names
[   54.499000] tun: Universal TUN/TAP device driver, 1.6
[   54.500000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   54.875000] ACPI: AC Adapter [AC] (off-line)
[   54.898000] ACPI: Battery Slot [BAT0] (battery present)
[   54.911000] ACPI: Power Button (FF) [PWRF]
[   54.911000] ACPI: Lid Switch [LID]
[   54.912000] ACPI: Sleep Button (CM) [SLPB]
[   54.925000] ACPI: ACPI Dock Station Driver 
[   54.971000] ACPI: Thermal Zone [THM0] (46 C)
[   54.974000] ACPI: Thermal Zone [THM1] (47 C)
[   54.987000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   54.988000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
[   65.887000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
[   66.024000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
[   66.024000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 66
[   66.024000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[   66.218000] hda_intel: azx_get_response timeout, switching to single_cmd mode...
[   90.003000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 201
[   90.003000] [drm] Initialized i915 1.5.0 20060119 on minor 0
[  534.677000] vmmon: module license 'unspecified' taints kernel.
[  534.679000] /dev/vmmon[5602]: Module vmmon: registered with major=10 minor=165
[  534.679000] /dev/vmmon[5602]: Module vmmon: initialized
[  534.682000] /dev/vmmon[5608]: Module vmmon: unloaded
[  552.136000] /dev/vmmon[5857]: Module vmmon: registered with major=10 minor=165
[  552.136000] /dev/vmmon[5857]: Module vmmon: initialized
[  552.194000] /dev/vmnet: open called by PID 5880 (vmnet-bridge)
[  552.194000] /dev/vmnet: hub 0 does not exist, allocating memory.
[  552.194000] /dev/vmnet: port on hub 0 successfully opened
[  552.194000] bridge-eth0: enabling the bridge
[  552.194000] bridge-eth0: up
[  552.194000] bridge-eth0: already up
[  552.194000] bridge-eth0: attached
[  552.247000] /dev/vmnet: open called by PID 5887 (vmnet-netifup)
[  552.247000] /dev/vmnet: hub 1 does not exist, allocating memory.
[  552.247000] /dev/vmnet: port on hub 1 successfully opened
[  552.308000] /dev/vmnet: open called by PID 5905 (vmnet-dhcpd)
[  552.309000] /dev/vmnet: port on hub 1 successfully opened
[  602.546000] /dev/vmnet: open called by PID 5982 (vmware-vmx)
[  602.546000] /dev/vmnet: port on hub 1 successfully opened
[  602.622000] /dev/vmmon[5989]: host clock rate change request 0 -> 19
[  602.622000] /dev/vmmon[5989]: host clock rate change request 19 -> 83
[  646.634000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
[  646.634000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
[  647.147000] ACPI: docking
[  647.349000] usb 5-6: new high speed USB device using ehci_hcd and address 4
[  647.463000] usb 5-6: configuration #1 chosen from 1 choice
[  647.463000] hub 5-6:1.0: USB hub found
[  647.463000] hub 5-6:1.0: 4 ports detected
[  647.743000] usb 5-6.1: new low speed USB device using ehci_hcd and address 5
[  647.834000] usb 5-6.1: configuration #1 chosen from 1 choice
[  648.012000] usb 5-6.3: new low speed USB device using ehci_hcd and address 6
[  648.118000] usb 5-6.3: configuration #1 chosen from 1 choice
[  648.124000] usbcore: registered new driver hiddev
[  648.129000] input: Logitech USB-PS/2 Optical Mouse as /class/input/input4
[  648.130000] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.7-6.1
[  648.159000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input5
[  648.159000] input: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[  648.175000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input6
[  648.175000] input: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[  648.175000] usbcore: registered new driver usbhid
[  648.175000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[ 3581.904000] usb 5-6.2: new high speed USB device using ehci_hcd and address 7
[ 3581.989000] usb 5-6.2: configuration #1 chosen from 1 choice
[ 3582.059000] Initializing USB Mass Storage driver...
[ 3582.060000] usbcore: registered new driver usb-storage
[ 3582.060000] USB Mass Storage support registered.
[ 3583.110000] usb 5-6.2: usbfs: interface 0 claimed by usbfs while 'vmware-vmx' sets config #1
[ 3626.016000] usb 5-6.2: USB disconnect, address 7
[ 3650.548000] /dev/vmmon[5982]: host clock rate change request 83 -> 0
[ 3650.556000] vmmon: Had to deallocate locked 13966 pages from vm driver f2fca000
[ 3650.564000] vmmon: Had to deallocate AWE 4424 pages from vm driver f2fca000
[ 3657.937000] usb 5-6.2: new high speed USB device using ehci_hcd and address 8
[ 3658.022000] usb 5-6.2: configuration #1 chosen from 1 choice
[ 3658.023000] scsi4 : SCSI emulation for USB Mass Storage devices
[ 3658.023000] usb-storage: device found at 8
[ 3658.023000] usb-storage: waiting for device to settle before scanning
[ 3663.025000]   Vendor: USB 2.0   Model: memory            Rev: 0.00
[ 3663.025000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[ 3663.026000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[ 3663.027000] sdb: Write Protect is off
[ 3663.027000] sdb: Mode Sense: 00 00 00 00
[ 3663.027000] sdb: assuming drive cache: write through
[ 3663.028000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[ 3663.029000] sdb: Write Protect is off
[ 3663.029000] sdb: Mode Sense: 00 00 00 00
[ 3663.029000] sdb: assuming drive cache: write through
[ 3663.029000]  sdb: sdb1
[ 3663.217000] sd 4:0:0:0: Attached scsi removable disk sdb
[ 3663.218000] usb-storage: device scan complete
[ 3902.714000] /dev/vmnet: open called by PID 8118 (vmware-vmx)
[ 3902.714000] /dev/vmnet: port on hub 1 successfully opened
[ 3902.770000] /dev/vmmon[8131]: host clock rate change request 0 -> 19
[ 3902.770000] /dev/vmmon[8131]: host clock rate change request 19 -> 83
[11207.313000] /dev/vmnet: open called by PID 8118 (vmware-vmx)
[11207.314000] device eth0 entered promiscuous mode
[11207.314000] audit(1158228754.977:2): dev=eth0 prom=256 old_prom=0 auid=4294967295
[11207.314000] bridge-eth0: enabled promiscuous mode
[11207.314000] /dev/vmnet: port on hub 0 successfully opened
[11233.083000] ACPI: undocking
[11233.143000] usb 5-6: USB disconnect, address 4
[11233.143000] usb 5-6.1: USB disconnect, address 5
[11233.143000] usb 5-6.2: USB disconnect, address 8
[11233.153000] usb 5-6.3: USB disconnect, address 6
[11241.530000] e1000: eth0: e1000_watchdog: NIC Link is Down
[11247.328000] bridge-eth0: disabling the bridge
[11247.328000] device eth0 left promiscuous mode
[11247.328000] audit(1158228794.989:3): dev=eth0 prom=0 old_prom=256 auid=4294967295
[11247.328000] bridge-eth0: disabled promiscuous mode
[11247.332000] bridge-eth0: down
[11247.369000] bridge-eth0: enabling the bridge
[11247.370000] device eth0 entered promiscuous mode
[11247.370000] audit(1158228795.031:4): dev=eth0 prom=256 old_prom=0 auid=4294967295
[11247.370000] bridge-eth0: enabled promiscuous mode
[11247.370000] bridge-eth0: up
[11269.783000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
[11269.783000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
[11269.849000] usb 5-6: new high speed USB device using ehci_hcd and address 9
[11269.963000] usb 5-6: configuration #1 chosen from 1 choice
[11269.963000] hub 5-6:1.0: USB hub found
[11269.963000] hub 5-6:1.0: 4 ports detected
[11270.177000] ACPI: docking
[11270.242000] usb 5-6.1: new low speed USB device using ehci_hcd and address 10
[11270.333000] usb 5-6.1: configuration #1 chosen from 1 choice
[11270.336000] input: Logitech USB-PS/2 Optical Mouse as /class/input/input7
[11270.336000] input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.7-6.1
[11270.513000] usb 5-6.3: new low speed USB device using ehci_hcd and address 11
[11270.619000] usb 5-6.3: configuration #1 chosen from 1 choice
[11270.627000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input8
[11270.627000] input: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[11270.638000] input: Microsoft Comfort Curve Keyboard 2000 as /class/input/input9
[11270.638000] input: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:1d.7-6.3
[11286.776000] usb 5-6.2: new high speed USB device using ehci_hcd and address 12
[11286.861000] usb 5-6.2: configuration #1 chosen from 1 choice
[11286.876000] scsi5 : SCSI emulation for USB Mass Storage devices
[11286.876000] usb-storage: device found at 12
[11286.876000] usb-storage: waiting for device to settle before scanning
[11291.878000]   Vendor: USB 2.0   Model: memory            Rev: 0.00
[11291.878000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[11291.879000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[11291.880000] sdb: Write Protect is off
[11291.880000] sdb: Mode Sense: 00 00 00 00
[11291.880000] sdb: assuming drive cache: write through
[11291.881000] SCSI device sdb: 1024000 512-byte hdwr sectors (524 MB)
[11291.882000] sdb: Write Protect is off
[11291.882000] sdb: Mode Sense: 00 00 00 00
[11291.882000] sdb: assuming drive cache: write through
[11291.882000]  sdb: sdb1
[11292.071000] sd 5:0:0:0: Attached scsi removable disk sdb
[11292.073000] usb-storage: device scan complete

--jRHKVT23PllUwdXP--
