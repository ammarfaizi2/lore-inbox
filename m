Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVBOPLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVBOPLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVBOPLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:11:16 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:50164 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261748AbVBOPHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:07:52 -0500
Date: Tue, 15 Feb 2005 10:07:13 -0500 (EST)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: Re: Radeon FB troubles with recent kernels
In-reply-to: <3yatk-4mE-29@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Message-id: <20050215150713.EE7721DE4A@X31.nui.nul>
Organization: Networking Unlimited, Inc.
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
References: <3y1SR-5K6-1@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On my Thinkpad X31 with a Radeon Mobility M6 LY I see a major
>> regression going from 2.6.11-rc3 to rc4. With rc-4, the frame
>> buffer console (using "video=radeonfb:1024x768-24@60") comes up as
>> 640x480 expanded to 1024x768. The inability of ACPI suspend to turn
>> off the backlight also returns. Using rc-3, frame buffer console
>> works fine and suspend/resume appears to work reliably without
>> needing radeontool to turn off the backlight (as long as I do it
>> from X.org X).
>
>Ok, this is getting complicated. So far, I'm getting a bit more success
>reports that regression reports, so I'm keen to keep this new radeonfb
>for 2.6.11...
>
>There are several issues involved
  
Thanks for the detailed explanation.

>As far as the mode setting is concerned, I'm not sure what's going on
>whith your specific model, could you please enable radeonfb debug output
>in the kernel config and send me the complete dmesg log ?

Appended to the end of this response.

>As far as the panel blanking is concerned (either during suspend or
>normal console blanking), this is a tricky matter. It seems that a bit
>of code that works for some panels won't work with others. So far, I
>managed to isolate the issue to some panels relying on an inverted
>signal out of the chip. I'm in contact with ATI to try to solve that
>problem, it might be possible to get proper infos about the type of
>panel connected via the BIOS ROM image. Unfortunately, I don't think
>I'll get a definitive answer before 2.6.11 is released.
>
>Note that some users have successfully enabled the powerbook/ibook
>specific power management code I have in there for thinkpads. I intend t
>o merge some of that stuff after 2.6.11 is done.
>
>Ben.

Thanks for your support and efforts. 

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com

======================================================================

dmesg with radeonfb & i2c debugs enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

kernel command line: auto BOOT_IMAGE=Test_9.2 ro root=306 pci=usepirqmask desktop idebus=66 video=radeonfb:1024x768-24@60
ide_setup: idebus=66
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01601000)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 599.655 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 775068k/785792k available (2255k kernel code, 10264k reserved, 629k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1187.84 BogoMIPS (lpj=593920)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0800)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=8
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050125
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC] (gpe 28)
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x35 set to 0x1
audit: initializing netlink socket (disabled)
audit(1108478269.712:0): initialized
Initializing Cryptographic API
radeonfb_pci_register BEGIN
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
radeonfb (0000:01:00.0): Found 16384k of DDR 32 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=60) Memory=144.00 Mhz, System=144.00 MHz
radeonfb: PLL min 12000 max 35000
i2c_adapter i2c-0: registered as adapter #0
i2c_adapter i2c-1: registered as adapter #1
i2c_adapter i2c-2: registered as adapter #2
i2c_adapter i2c-3: registered as adapter #3
1 chips in connector info
 - chip 1 has 1 connectors
  * connector 0 of type 2 (CRT) : 2300
Starting monitor auto detection...
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-0: master_xfer: with 2 msgs.
i2c_adapter i2c-0: master_xfer: with 2 msgs.
radeonfb: I2C (port 1) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
i2c_adapter i2c-1: master_xfer: with 2 msgs.
radeonfb: I2C (port 2) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
Non-DDC laptop panel detected
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
i2c_adapter i2c-2: master_xfer: with 2 msgs.
radeonfb: I2C (port 3) ... not found
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
i2c_adapter i2c-3: master_xfer: with 2 msgs.
radeonfb: I2C (port 4) ... not found
radeonfb: Monitor 1 type LCD found
radeonfb: Monitor 2 type no found
radeonfb: panel ID string: 1024x768                
radeonfb: detected LVDS panel size from BIOS: 1024x768
BIOS provided panel power delay: 1000
radeondb: BIOS provided dividers will be used
ref_divider = 8
post_divider = 2
fbk_divider = 4d
Scanning BIOS table ...
 320 x 350
 320 x 400
 320 x 400
 320 x 480
 400 x 600
 512 x 384
 640 x 350
 640 x 400
 640 x 475
 640 x 480
 720 x 480
 720 x 576
 800 x 600
 848 x 480
 1024 x 768
Found panel in BIOS table:
  hblank: 320
  hOver_plus: 16
  hSync_width: 136
  vblank: 38
  vOver_plus: 2
  vSync_width: 6
  clock: 6500
Setting up default mode based on panel info
radeonfb: Dynamic Clock Power Management enabled
hStart = 656, hEnd = 792, hTotal = 960
vStart = 402, vEnd = 408, vTotal = 438
h_total_disp = 0x4f0077	   hsync_strt_wid = 0x11028a
v_total_disp = 0x18f01b5	   vsync_strt_wid = 0x60191
pixclock = 15384
freq = 6500
Console: switching to colour frame buffer device 53x18
radeonfb (0000:01:00.0): ATI Radeon LY 
radeonfb_pci_register END
ACPI: AC Adapter [AC] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3] C4[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
ACPI: Thermal Zone [THM0] (51 C)
ibm_acpi: IBM ThinkPad ACPI Extras v0.8
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: dock device not present
ibm_acpi: bay device not present
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
i8xx TCO timer: initialized (0x1060). heartbeat=30 sec (nowayout=0)
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: AGP aperture is 256M @ 0xd0000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.14.0 20050125 on minor 0: 
ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MOU] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 66MHz system bus speed for PIO modes
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 11 (level, low) -> IRQ 11
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS726060M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda4
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
input: PC Speaker
i2c /dev entries driver
i2c-core: driver dev_driver registered.
i2c_adapter i2c-0: Registered as minor 0
i2c_adapter i2c-1: Registered as minor 1
i2c_adapter i2c-2: Registered as minor 2
i2c_adapter i2c-3: Registered as minor 3
i801_smbus 0000:00:1f.3: I801 using PCI Interrupt for SMBus.
i801_smbus 0000:00:1f.3: SMBREV = 0x1
i801_smbus 0000:00:1f.3: I801_smba = 0x1880
i2c_adapter i2c-4: Registered as minor 4
i2c_adapter i2c-4: registered as adapter #4
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
NET: Registered protocol family 1
ACPI wakeup devices: 
 LID SLPB PCI0 UART PCI1 DOCK USB0 USB1 USB2 AC9M 
ACPI: (supports S0 S3 S4 S5)
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 172k freed
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Adding 1572440k swap on /dev/hda8.  Priority:42 extents:1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 11 (level, low) -> IRQ 11
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.0: UHCI Host Controller
ath_hal: module license 'Proprietary' taints kernel.
ath_hal: 0.9.12.14 (AR5210, AR5211, AR5212)
wlan: 0.8.4.5 (EXPERIMENTAL)
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 11, io base 0x1800
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ath_rate_onoe: 1.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.1: UHCI Host Controller
ath_pci: 0.9.4.12 (EXPERIMENTAL)
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 11, io base 0x1820
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 11 (level, low) -> IRQ 11
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 11, io base 0x1840
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 11 (level, low) -> IRQ 11
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 11, pci mem 0xc0000000
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
usb 3-1: new full speed USB device using uhci_hcd and address 2
ath0: 11a rates: 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
ath0: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mbps
ath0: mac 4.2 phy 3.0 5ghz radio 1.7 2ghz radio 2.3
ath0: 802.11 address: 00:05:4e:41:3e:59
ath0: Use hw queue 0 for WME_AC_BE traffic
ath0: Use hw queue 0 for WME_AC_BK traffic
ath0: Use hw queue 0 for WME_AC_VI traffic
ath0: Use hw queue 0 for WME_AC_VO traffic
ath0: Atheros 5211: mem=0xc0210000, irq=11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.0 [1014:0532]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:00.1[B] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:02:00.1 [1014:0532]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000006
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:00.2[C] -> GSI 11 (level, low) -> IRQ 11
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[c0240000-c02407ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00061b031001139f]
Bluetooth: Core ver 2.7
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.8
st: Version 20041025, fixed bufsize 32768, s/g segs 256
usbcore: registered new driver hci_usb
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
ReiserFS: hda9: found reiserfs format "3.6" with standard journal
ReiserFS: hda9: using ordered data mode
ReiserFS: hda9: journal params: device hda9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda9: checking transaction log (hda9)
ReiserFS: hda9: Using r5 hash to sort names
ReiserFS: hda10: found reiserfs format "3.6" with standard journal
ReiserFS: hda10: using ordered data mode
ReiserFS: hda10: journal params: device hda10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda10: checking transaction log (hda10)
ReiserFS: hda10: Using r5 hash to sort names
NTFS driver 2.1.22 [Flags: R/O MODULE].
NTFS volume version 3.1.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0xa00-0xaff: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 49395 usecs
intel8x0: clocking to 48000
NET: Registered protocol family 23
NET: Registered protocol family 10
Disabled Privacy Extensions on device c039d880(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device eebae000(sit0)
ath0: no IPv6 routers present
parport0: PC-style at 0x3bc [PCSPP(,...)]
lp0: using parport0 (polling).
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
hStart = 656, hEnd = 792, hTotal = 960
vStart = 402, vEnd = 408, vTotal = 438
h_total_disp = 0x4f0077	   hsync_strt_wid = 0x11028a
v_total_disp = 0x18f01b5	   vsync_strt_wid = 0x60191
pixclock = 15384
freq = 6500

                           # # #
