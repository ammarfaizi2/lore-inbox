Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVD1X0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVD1X0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVD1X0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:26:40 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:60246 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262334AbVD1X0W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:26:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B9gUiws70tZapcyjLuCMAhjWHJTfYhCcYuVqpVP8CfbOQKHEKayTn3glYxXYpFC8bk7Wo8osGfcxlvFPE3OA3fmQzVcf0A2huW855CJslo8g1H+K774f2QVMZLBiLOuyJeFMhU9wPBM7spLWJqK4YesC9OafI17IaL/Omi1KnWw=
Message-ID: <87ab37ab05042816263db07a7e@mail.gmail.com>
Date: Fri, 29 Apr 2005 07:26:22 +0800
From: kylin <fierykylin@gmail.com>
Reply-To: kylin <fierykylin@gmail.com>
To: dely.l.sy@intel.com.sun.com
Subject: RE: 2.6.12-rc2-mm3 pciehp regression
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

my dell 2800 server with intel E7520 and broadcom pcie NIC runs fedora
C 3 (kernel updated to 2.6.11.6)now,
but on occasion it can not booting up wit acpi on.
ofen need me to shudown forcibly and open again.
When i turn apcioff with the option acpi=off in grub ,it boots up successfully.
i diff the dmesg of the acpi and noacpi boot up below:
and often the acpi booting will dead at 
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 17
-ACPI wakeup devices: 
-PCI0 PALO PBLO VPR0 PBHI VPR1 PICH 
-ACPI: (supports S0 S4 S5)
and the line below is the last message shown in the acpi boot death scene . 
i have no idear 
regards
////////////////////////////////
the diff file :
--- 26116dmesg	2005-04-27 21:39:59.000000000 +0800
+++ 2611noacpi	2005-04-28 19:50:30.000000000 +0800
@@ -1,4 +1,12 @@
-reserved)
+Linux version 2.6.11.6 (root@localhost.localdomain) (gcc version
3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #3 Wed Apr 27 20:59:11 CST 2005
+BIOS-provided physical RAM map:
+ BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
+ BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
+ BIOS-e820: 000000003ffc0000 - 000000003ffcfc00 (ACPI data)
+ BIOS-e820: 000000003ffcfc00 - 000000003ffff000 (reserved)
+ BIOS-e820: 00000000e0000000 - 00000000fec90000 (reserved)
+ BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
+ BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
 127MB HIGHMEM available.
 896MB LOWMEM available.
@@ -7,31 +15,19 @@
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32704 pages, LIFO batch:7
 DMI 2.3 present.
-ACPI: RSDP (v000 DELL                                  ) @ 0x000fd650
-ACPI: RSDT (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000a) @ 0x000fd664
-ACPI: FADT (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000a) @ 0x000fd6b0
-ACPI: MADT (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000a) @ 0x000fd724
-ACPI: SPCR (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000a) @ 0x000fd7cc
-ACPI: HPET (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000a) @ 0x000fd81c
-ACPI: MCFG (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000a) @ 0x000fd854
-ACPI: DSDT (v001 DELL   PE BKC   0x00000001 MSFT 0x0100000e) @ 0x00000000
-ACPI: PM-Timer IO Port: 0x808
-ACPI: HPET id: 0xffffffff base: 0xfed00000
 Allocating PCI resources starting at 40000000 (gap: 3ffff000:a0001000)
 Built 1 zonelists
-Kernel command line: ro root=LABEL=/ rhgb quiet
+Kernel command line: ro root=LABEL=/ rhgb acpi=off
 Initializing CPU#0
 PID hash table entries: 4096 (order: 12, 65536 bytes)
+Detected 2794.874 MHz processor.
+Using tsc for high-res timesource
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 Memory: 1034300k/1048320k available (2607k kernel code, 13248k
reserved, 701k data, 188k init, 130816k highmem)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Using HPET for base-timer
-Using HPET for gettimeofday
-Detected 2793.416 MHz processor.
-Using hpet for high-res timesource
-Calibrating delay loop... 5537.79 BogoMIPS (lpj=2768896)
+Calibrating delay loop... 5521.40 BogoMIPS (lpj=2760704)
 Security Framework v1.0.0 initialized
 SELinux:  Initializing.
 SELinux:  Starting in permissive mode
@@ -52,62 +48,34 @@
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Checking 'hlt' instruction... OK.
-ACPI: setting ELCR to 0200 (from 0c88)
 checking if image is initramfs... it is
 Freeing initrd memory: 332k freed
 NET: Registered protocol family 16
 PCI: PCI BIOS revision 2.10 entry at 0xfbf0e, last bus=16
-PCI: Using MMCONFIG
+PCI: Using configuration type 1
 mtrr: v2.0 (20020519)
 ACPI: Subsystem revision 20050211
-ACPI: Interpreter enabled
-ACPI: Using PIC for interrupt routing
-ACPI: PCI Root Bridge [PCI0] (00:00)
-PCI: Probing PCI hardware (bus 00)
-PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
-PCI: Transparent bridge - 0000:00:1e.0
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.DOBA._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PALO.DOBB._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBLO._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.VPR0._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBHI._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBHI.PXB1._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PBHI.PXB2._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.VPR1._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.VPR1.PXC1._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.VPR1.PXC2._PRT]
-ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PICH._PRT]
-ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12)
-ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12)
-ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12)
-ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11 12)
-ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
-ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
-ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12) *0, disabled.
-ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12)
+ACPI: Interpreter disabled.
 Linux Plug and Play Support v0.97 (c) Adam Belay
-pnp: PnP ACPI init
-pnp: PnP ACPI: found 12 devices
+pnp: PnP ACPI: disabled
 SCSI subsystem initialized
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
-PCI: Using ACPI for IRQ routing
-** PCI interrupts are no longer routed automatically.  If this
-** causes a device to stop working, it is probably because the
-** driver failed to call pci_enable_device().  As a temporary
-** workaround, the "pci=routeirq" argument restores the old
-** behavior.  If this argument makes the device work again,
-** please email the output of "lspci" to bjorn.helgaas@hp.com
-** so I can fix the driver.
-pnp: 00:09: ioport range 0x800-0x87f could not be reserved
-pnp: 00:09: ioport range 0x880-0x8bf has been reserved
-pnp: 00:09: ioport range 0x8c0-0x8df has been reserved
-pnp: 00:09: ioport range 0xc00-0xc0f has been reserved
-pnp: 00:09: ioport range 0xc10-0xc1f has been reserved
-pnp: 00:09: ioport range 0xca0-0xcaf has been reserved
-pnp: 00:09: ioport range 0xc20-0xc3f has been reserved
+PCI: Probing PCI hardware
+PCI: Probing PCI hardware (bus 00)
+PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
+PCI: Transparent bridge - 0000:00:1e.0
+PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
+PCI: IRQ 0 for device 0000:00:02.0 doesn't match PIRQ mask - try
pci=usepirqmask
+PCI: Found IRQ 11 for device 0000:00:02.0
+PCI: Sharing IRQ 11 with 0000:00:03.0
+PCI: Sharing IRQ 11 with 0000:00:04.0
+PCI: Sharing IRQ 11 with 0000:00:05.0
+PCI: Sharing IRQ 11 with 0000:00:06.0
+PCI: Sharing IRQ 11 with 0000:00:1d.0
+PCI: Sharing IRQ 11 with 0000:07:00.0
+PCI: Sharing IRQ 11 with 0000:0b:07.0
+PCI: Sharing IRQ 11 with 0000:0d:00.0
 apm: BIOS not found.
 highmem bounce pool size: 64 pages
 Total HugeTLB memory allocated, 0
@@ -125,7 +93,6 @@
 serio: i8042 KBD port at 0x60,0x64 irq 1
 Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
 ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
-ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
@@ -135,7 +102,6 @@
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 ICH5: IDE controller at PCI slot 0000:00:1f.1
 PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
-ACPI: PCI interrupt 0000:00:1f.1[A]: no GSI - using IRQ 0
 ICH5: chipset revision 2
 ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
@@ -167,16 +133,13 @@
 Initializing IPsec netlink socket
 NET: Registered protocol family 1
 NET: Registered protocol family 17
-ACPI wakeup devices: 
-PCI0 PALO PBLO VPR0 PBHI VPR1 PICH 
-ACPI: (supports S0 S4 S5)
 Freeing unused kernel memory: 188k freed
 megaraid cmm: 2.20.2.5 (Release Date: Fri Jan 21 00:01:03 EST 2005)
 megaraid: 2.20.4.5 (Release Date: Thu Feb 03 12:27:22 EST 2005)
 megaraid: probe new device 0x1028:0x0013:0x1028:0x016e: bus 2:slot 14:func 0
-ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 7
-PCI: setting IRQ 7 as level-triggered
-ACPI: PCI interrupt 0000:02:0e.0[A] -> GSI 7 (level, low) -> IRQ 7
+PCI: Found IRQ 7 for device 0000:02:0e.0
+PCI: Sharing IRQ 7 with 0000:00:1d.2
+PCI: Sharing IRQ 7 with 0000:10:0d.0
 megaraid: fw version:[513O] bios version:[H418]
 scsi0 : LSI Logic MegaRAID driver
 scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
@@ -218,27 +181,46 @@
 Floppy drive(s): fd0 is 1.44M
 FDC 0 is a National Semiconductor PC87306
 tg3.c:v3.23 (February 15, 2005)
-ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
-PCI: setting IRQ 11 as level-triggered
-ACPI: PCI interrupt 0000:07:00.0[A] -> GSI 11 (level, low) -> IRQ 11
+PCI: Found IRQ 11 for device 0000:07:00.0
+PCI: Sharing IRQ 11 with 0000:00:02.0
+PCI: Sharing IRQ 11 with 0000:00:03.0
+PCI: Sharing IRQ 11 with 0000:00:04.0
+PCI: Sharing IRQ 11 with 0000:00:05.0
+PCI: Sharing IRQ 11 with 0000:00:06.0
+PCI: Sharing IRQ 11 with 0000:00:1d.0
+PCI: Sharing IRQ 11 with 0000:0d:00.0
+PCI: Sharing IRQ 11 with 0000:0b:07.0
 PCI: Setting latency timer of device 0000:07:00.0 to 64
 eth0: Tigon3 [partno(BCM95721A211) rev 4101 PHY(5750)]
(PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:10:18:0e:06:49
 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
-ACPI: PCI interrupt 0000:0d:00.0[A] -> GSI 11 (level, low) -> IRQ 11
+PCI: Found IRQ 11 for device 0000:0d:00.0
+PCI: Sharing IRQ 11 with 0000:00:02.0
+PCI: Sharing IRQ 11 with 0000:00:03.0
+PCI: Sharing IRQ 11 with 0000:00:04.0
+PCI: Sharing IRQ 11 with 0000:00:05.0
+PCI: Sharing IRQ 11 with 0000:00:06.0
+PCI: Sharing IRQ 11 with 0000:00:1d.0
+PCI: Sharing IRQ 11 with 0000:07:00.0
+PCI: Sharing IRQ 11 with 0000:0b:07.0
 PCI: Setting latency timer of device 0000:0d:00.0 to 64
 eth1: Tigon3 [partno(BCM95721A211) rev 4101 PHY(5750)]
(PCIX:100MHz:32-bit) 10/100/1000BaseT Ethernet 00:10:18:0e:06:ab
 eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
 Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
 Copyright (c) 1999-2004 Intel Corporation.
-ACPI: PCI interrupt 0000:0b:07.0[A] -> GSI 11 (level, low) -> IRQ 11
+PCI: Found IRQ 11 for device 0000:0b:07.0
+PCI: Sharing IRQ 11 with 0000:00:02.0
+PCI: Sharing IRQ 11 with 0000:00:03.0
+PCI: Sharing IRQ 11 with 0000:00:04.0
+PCI: Sharing IRQ 11 with 0000:00:05.0
+PCI: Sharing IRQ 11 with 0000:00:06.0
+PCI: Sharing IRQ 11 with 0000:00:1d.0
+PCI: Sharing IRQ 11 with 0000:07:00.0
+PCI: Sharing IRQ 11 with 0000:0d:00.0
 e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
-ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
-ACPI: PCI interrupt 0000:0c:08.0[A] -> GSI 11 (level, low) -> IRQ 11
+PCI: Found IRQ 11 for device 0000:0c:08.0
 e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
 hw_random hardware driver 1.0.0 loaded
-ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 3
-PCI: setting IRQ 3 as level-triggered
-ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 3 (level, low) -> IRQ 3
+PCI: Found IRQ 3 for device 0000:00:1d.7
 ehci_hcd 0000:00:1d.7: EHCI Host Controller
 PCI: Setting latency timer of device 0000:00:1d.7 to 64
 ehci_hcd 0000:00:1d.7: irq 3, pci mem 0xdff00000
@@ -248,16 +230,22 @@
 hub 1-0:1.0: USB hub found
 hub 1-0:1.0: 6 ports detected
 USB Universal Host Controller Interface driver v2.2
-ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
+PCI: Found IRQ 11 for device 0000:00:1d.0
+PCI: Sharing IRQ 11 with 0000:00:02.0
+PCI: Sharing IRQ 11 with 0000:00:03.0
+PCI: Sharing IRQ 11 with 0000:00:04.0
+PCI: Sharing IRQ 11 with 0000:00:05.0
+PCI: Sharing IRQ 11 with 0000:00:06.0
+PCI: Sharing IRQ 11 with 0000:07:00.0
+PCI: Sharing IRQ 11 with 0000:0d:00.0
+PCI: Sharing IRQ 11 with 0000:0b:07.0
 uhci_hcd 0000:00:1d.0: UHCI Host Controller
 PCI: Setting latency timer of device 0000:00:1d.0 to 64
 uhci_hcd 0000:00:1d.0: irq 11, io base 0x7ce0
 uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
 hub 2-0:1.0: USB hub found
 hub 2-0:1.0: 2 ports detected
-ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
-PCI: setting IRQ 10 as level-triggered
-ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 10 (level, low) -> IRQ 10
+PCI: Found IRQ 10 for device 0000:00:1d.1
 uhci_hcd 0000:00:1d.1: UHCI Host Controller
 usb 1-3: new high speed USB device using ehci_hcd and address 2
 PCI: Setting latency timer of device 0000:00:1d.1 to 64
@@ -265,7 +253,9 @@
 uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
 hub 3-0:1.0: USB hub found
 hub 3-0:1.0: 2 ports detected
-ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 7 (level, low) -> IRQ 7
+PCI: Found IRQ 7 for device 0000:00:1d.2
+PCI: Sharing IRQ 7 with 0000:02:0e.0
+PCI: Sharing IRQ 7 with 0000:10:0d.0
 uhci_hcd 0000:00:1d.2: UHCI Host Controller
 PCI: Setting latency timer of device 0000:00:1d.2 to 64
 uhci_hcd 0000:00:1d.2: irq 7, io base 0x7ca0
@@ -281,9 +271,6 @@
 NET: Registered protocol family 10
 Disabled Privacy Extensions on device c03ff220(lo)
 IPv6 over IPv4 tunneling driver
-ACPI: Power Button (FF) [PWRF]
-ibm_acpi: ec object not found
-ACPI: Video Device [EVGA] (multi-head: no  rom: yes  post: no)
 device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
 hda: packet command error: status=0x51 { DriveReady SeekComplete Error }
 hda: packet command error: error=0x54 { AbortedCommand LastFailedSense=0x05 }
@@ -291,10 +278,8 @@
 cdrom: open failed.
 SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
 SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
-parport: PnPBIOS parport detected.
-parport0: PC-style at 0x278 (0x678), irq 5 [PCSPP,TRISTATE]
-Trying to free free DMA1
-pnp: Device 00:08 disabled.
+parport0: PC-style at 0x278 (0x678) [PCSPP,TRISTATE]
+parport0: irq 5 detected
 ip_tables: (C) 2000-2002 Netfilter core team
 ip_tables: (C) 2000-2002 Netfilter core team
 tg3: eth0: Link is up at 100 Mbps, full duplex.
@@ -304,10 +289,13 @@
 eth2: no IPv6 routers present
 SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
 i2c /dev entries driver
-pnp: Device 00:08 activated.
-parport: PnPBIOS parport detected.
-parport0: PC-style at 0x278 (0x678), irq 5 [PCSPP,TRISTATE]
-lp0: using parport0 (interrupt-driven).
+parport0: PC-style at 0x278 (0x678) [PCSPP,TRISTATE]
+parport0: irq 5 detected
+lp0: using parport0 (polling).
 lp0: console ready
-ACPI: PCI interrupt 0000:10:0d.0[A] -> GSI 7 (level, low) -> IRQ 7
+PCI: Found IRQ 7 for device 0000:10:0d.0
+PCI: Sharing IRQ 7 with 0000:00:1d.2
+PCI: Sharing IRQ 7 with 0000:02:0e.0
 [drm] Initialized radeon 1.14.0 20050125 on minor 0: 
+pciehp: Unknown symbol pcie_port_service_register
+pciehp: Unknown symbol pcie_port_service_unregister

-- 
we who r about to die,salute u!
