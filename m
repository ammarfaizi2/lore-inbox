Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUELDiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUELDiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 23:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUELDiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 23:38:03 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:56242 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264962AbUELDhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 23:37:51 -0400
Message-ID: <40A19C03.9090601@myrealbox.com>
Date: Tue, 11 May 2004 20:37:39 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andy Lutomirski <luto@myrealbox.com>
Subject: Re: oops on keyboard disconnect
References: <40A193AD.8000902@myrealbox.com>
In-Reply-To: <40A193AD.8000902@myrealbox.com>
Content-Type: multipart/mixed;
 boundary="------------090006030201020504060000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090006030201020504060000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andy Lutomirski wrote:
> I have a Logitech Cordless Elite Duo (I don't use it's mouse, but it's 
> there) and a Logitech Dual Optical mouse.  Both are plugged into a hub, 
> and the hub is on a switch (with another computer) so it gets frequently 
> connected and disconnected.
> 
> Kernel is 2.6.6-mm1 with 4kstacks reverted and tainted by the nvidia 
> module (yes, I know, but I've been running the same module for some time 
> on different kernels and I haven't seen this one...).
> 
> lsusb does nothing after this oops.
> 

ok... this one is 100% reproducable by switching hub off the system.

Here's the entire serial console output without any binary modules.
There was no problem with 2.6.6-rc2-mm1.

--Andy

--------------090006030201020504060000
Content-Type: text/plain;
 name="linuxcrash.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linuxcrash.log"

Restarting system.
Linux version 2.6.6-mm1 (andy@luto.stanford.edu) (gcc version 3.3.3 20040412 (Re
d Hat Linux 3.3.3-7)) #5 Tue May 11 19:20:17 PDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa3f0
ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT 0x00000097) @ 0x1fff0030
ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT 0x00000097) @ 0x1fff00c0
ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/hda1 console=ttyS0,115200 console=tty0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2000.943 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 516116k/524224k available (1874k kernel code, 7328k reserved, 833k data,
 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3923.96 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 110k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdab1, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7510
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x645b, dseg 0xf0000
PnPBIOS: 11 nodes reported by PnP BIOS; 11 recorded by driver
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: Using ACPI for IRQ routing
vesafb: probe of vesafb0 failed with error -6
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU1] (supports C1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.0
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: ST3160023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
ide-floppy driver 0.99.newide
ehci_hcd 0000:00:10.4: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.4: irq 5, pci mem e085ad00
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 11, io base 0000d400
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#2)
uhci_hcd 0000:00:10.1: irq 11, io base 0000d800
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#3)
uhci_hcd 0000:00:10.2: irq 10, io base 0000dc00
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller 
(#4)
uhci_hcd 0000:00:10.3: irq 10, io base 0000e000
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5)
SMBIOS facility v1.0 2004-04-19
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 136k freed
usb 3-2: new full speed USB device using address 2
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-2.1: new low speed USB device using address 3
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:10.1-2.1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.1-2.1
usb 3-2.2: new low speed USB device using address 4
bttv: readee error
bttv0: Hauppauge eeprom: invalid
bttv0: using tuner=17
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 17 (Philips NTSC_M (MK2)) by bt878 #0 [sw]

Fedora Core release 1.92 (FC2 Test 3)
Kernel 2.6.6-mm1 on an i686

login: Unable to handle kernel NULL pointer dereference at vir
tual address 00000000
       ___      ______
      0--,|    /OOOOOO\
     {_o  /  /OO plop OO\
       \__\_/OO oh dear OOO\s
          \OOOOOOOOOOOOOOOO/
           __XXX__   __XXX__
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0251b34>]    Not tainted VLI
EFLAGS: 00010293   (2.6.6-mm1) 
EIP is at usb_ifnum_to_if+0x24/0x40
eax: 00000000   ebx: c1581400   ecx: 00000000   edx: 00000001
esi: 00000002   edi: 00000001   ebp: df323c24   esp: c15ede80
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 43, threadinfo=c15ec000 task=c15ef6b0)
Stack: df323c00 00000000 00000001 c0257a7a 00000282 defe8800 00000001 00000282 
       00000100 df3aac44 00000000 c0267a00 c1589294 c0372f20 df323c00 df323c24 
       c0251a05 c15892a4 c0372f40 c0207166 c15892a4 df323ccc c0207278 c15892a4 
Call Trace:
 [<c0257a7a>] usb_set_interface+0x1a/0x130
 [<c0267a00>] hid_free_device+0x50/0x60
 [<c0251a05>] usb_unbind_interface+0x45/0x70
 [<c0207166>] device_release_driver+0x56/0x60
 [<c0207278>] bus_remove_device+0x48/0x90
 [<c020637a>] device_del+0x5a/0x90
 [<c02063b8>] device_unregister+0x8/0x10
 [<c0257961>] usb_disable_device+0x61/0xb0
 [<c025247f>] usb_disconnect+0x8f/0xe0
 [<c02524ba>] usb_disconnect+0xca/0xe0
 [<c0254794>] hub_port_connect_change+0x244/0x270
 [<c0253c6a>] hub_port_status+0x3a/0xb0
 [<c02d2efc>] schedule+0x27c/0x470
 [<c0254a49>] hub_events+0x289/0x300
 [<c0120f6a>] free_uid+0x1a/0xc0
 [<c0254aeb>] hub_thread+0x2b/0xe0
 [<c0116280>] default_wake_function+0x0/0x10
 [<c0254ac0>] hub_thread+0x0/0xe0
 [<c010427d>] kernel_thread_helper+0x5/0x18

Code: 00 00 90 8d 74 26 00 57 89 d7 56 53 8b 98 9c 01 00 00 31 c0 85 db 74 24 0f
 b6 43 04 31 c9 39 c1 7d 18 89 c6 8d 76 00 8b 44 8b 0c <8b> 10 0f b6 52 02 39 fa
 74 07 41 39 f1 7c ed 31 c0 5b 5e 5f c3 
 hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)

--------------090006030201020504060000--
