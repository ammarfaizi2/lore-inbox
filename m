Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264312AbUENB3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbUENB3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264311AbUENB3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:29:15 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:179 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264312AbUENB1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:27:34 -0400
Message-ID: <40A4207D.9000003@myrealbox.com>
Date: Thu, 13 May 2004 18:27:25 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2 (oops on keyboard/mouse USB hub unplug)
References: <fa.h3bu70j.nm6rj1@ifi.uio.no>
In-Reply-To: <fa.h3bu70j.nm6rj1@ifi.uio.no>
Content-Type: multipart/mixed;
 boundary="------------040509060907020903080000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040509060907020903080000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> 
> Changes since 2.6.6-mm1:
> 
>  bk-usb.patch

Unplugging my hub still oopses.  This one was introduced in -mm1 
(2.6.6-rc2-mm1 was fine), and reverting mm1's bk-usb.patch fixed it. 
This happens every time.

Anything I can do to help?

--Andy

--------------040509060907020903080000
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

0: 00000000fff80000 - 0000000100000000 (reserved)
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
Kernel command line: ro root=/dev/hda1 console=ttyS0,115200 console=tty0 commonc
ap.newcaps=1
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2000.223 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 516108k/524224k available (1878k kernel code, 7336k reserved, 834k data,
 136k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3956.73 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:     After vendor identify, caps: 078bfbff e1d3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU:     After all inits, caps: 078bfbff e1d3fbff 00000000 00000010
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
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
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
Experimental capability support is on
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
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
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
EXT3 FS on hda1, internal journal
Adding 1004052k swap on /dev/hda2.  Priority:-1 extents:1
SGI XFS with ACLs, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hda7
Ending clean XFS mount for filesystem: hda7
ReiserFS: hda5: found reiserfs format "3.6" with standard journal
ReiserFS: hda5: using ordered data mode
ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda5: checking transaction log (hda5)
ReiserFS: hda5: Using r5 hash to sort names
ReiserFS: hda6: found reiserfs format "3.6" with standard journal
ReiserFS: hda6: using ordered data mode
ReiserFS: hda6: journal params: device hda6, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda6: checking transaction log (hda6)
ReiserFS: hda6: Using r5 hash to sort names
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1203 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[3]  MMIO=[cfffd000-cfffd7ff]  Max 
Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0010dc00002c7728]
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 296 bytes per conntrack
Bridge firewalling registered
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
eth0: NatSemi DP8381[56] at 0xe0977000, 00:40:f4:58:9c:a9, IRQ 5.
r8169 Gigabit Ethernet driver 1.2 loaded
eth1: Identified chip type is 'RTL8169s/8110s'.
eth1: RTL8169 at 0xe0b54f00, 00:0c:76:4e:df:cc, IRQ 11
hostap_crypt: registered algorithm 'NULL'
hostap_pci: CVS (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_pci: Registered netdevice wifi0
prism2_hw_init: initialized in 198 ms
wifi0: trying to read PDA from 0x007f0000: failed
wifi0: trying to read PDA from 0x003f0000: failed
wifi0: trying to read PDA from 0x00390000: failed
wifi0: trying to read PDA from 0x007f0002: OK
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.0.7
wifi0: STA: id=0x1f v1.3.5
wifi0: defaulting to host-based encryption as a workaround for firmware bug in H
ost AP mode WEP
wifi0: defaulting to bogus WDS frame as a workaround for firmware bug in Host AP
 mode WDS
wifi0: Intersil Prism2.5 PCI: mem=0xcdcff000, irq=3
wifi0: registered netdevice wlan0
prism2_download: dl_cmd=5 start_addr=0x003f0c01 num_areas=3
  area 0: addr=0x007e17fe len=53400 ptr=0x080524b8
  area 1: addr=0x007f0800 len=4066 ptr=0x0805f558
  area 2: addr=0x007fe000 len=3282 ptr=0x08060540
prism2_hw_init: initialized in 82 ms
wifi0: Writing 53400 bytes at 0x007e17fe
wifi0: Writing 4066 bytes at 0x007f0800
wifi0: Writing 3282 bytes at 0x007fe000
prism2_hw_init: initialized in 29 ms
wifi0: trying to read PDA from 0x007f0000: failed
wifi0: trying to read PDA from 0x003f0000: failed
wifi0: trying to read PDA from 0x00390000: failed
wifi0: trying to read PDA from 0x007f0002: OK
wifi0: NIC: id=0x8013 v1.0.0
wifi0: PRI: id=0x15 v1.0.7
wifi0: STA: id=0x1f v1.8.0
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
eth0: Promiscuous mode enabled.
device eth0 entered promiscuous mode
br0: port 1(eth0) entering learning state
br0: topology change detected, propgating
br0: port 1(eth0) entering forwarding state
wlan0 unsupported ioctl(0x8946)
device wlan0 entered promiscuous mode
br0: port 2(wlan0) entering learning state
br0: topology change detected, propgating
br0: port 2(wlan0) entering forwarding state
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Linux video capture interface: v1.00
bttv: driver version 0.9.14 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0a.0, irq: 10, latency: 32, mmio: 0xcddfe000
bttv0: using: Hauppauge (bt848) [card=2,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=003fffff [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv: readee error
bttv0: Hauppauge eeprom: invalid
bttv0: Hauppauge eeprom: model=0, tuner= (4), radio=no
bttv0: using tuner=17
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea642
0,tda8425,pic16c54 (PV951),ta8874z
tuner: chip found at addr 0xc0 i2c-bus bt878 #0 [sw]
tuner: type set to 17 (Philips NTSC_M (MK2)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
usb 3-2: new full speed USB device using address 2
hub 3-2:1.0: USB hub found
hub 3-2:1.0: 4 ports detected
usb 3-2.1: new low speed USB device using address 3
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:10.1-2.1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.1-2.1
usb 3-2.2: new low speed USB device using address 4
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:10.1
-2.2
usb 3-2: USB disconnect, address 2
usb 3-2.1: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0251df4
*pde = 00000000
       ___      ______
      0--,|    /OOOOOO\
     {_o  /  /OO plop OO\
       \__\_/OO oh dear OOO\s
          \OOOOOOOOOOOOOOOO/
           __XXX__   __XXX__
Oops: 0000 [#1]
PREEMPT 
Modules linked in: evdev w83627hf i2c_sensor i2c_isa i2c_viapro tuner tvaudio bt
tv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev snd_cs4281 snd
_rawmidi snd_ac97_codec snd_pcm snd_page_alloc snd_opl3_lib snd_seq_device snd_t
imer snd_hwdep snd soundcore tun hostap_pci hostap r8169 natsemi bridge ip_nat_f
tp ip_conntrack_ftp ipt_limit ipt_REJECT ipt_state iptable_filter ipt_REDIRECT i
pt_multiport iptable_nat ip_conntrack ip_tables ohci1394 ieee1394 reiserfs xfs b
attery ac
CPU:    0
EIP:    0060:[<c0251df4>]    Not tainted VLI
EFLAGS: 00010293   (2.6.6-mm2) 
EIP is at usb_ifnum_to_if+0x24/0x40
eax: 00000000   ebx: db676e00   ecx: 00000000   edx: 00000001
esi: 00000002   edi: 00000001   ebp: dec73024   esp: c15ede80
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 43, threadinfo=c15ec000 task=c15ef6b0)
Stack: dec73000 00000000 00000001 c0257e9a 00000282 d5634a00 00000001 00000286 
       00000100 d4f94c44 00000000 c0268780 df7e4754 c0373f80 dec73000 dec73024 
       c0251cc5 df7e4764 c0373fa0 c0207426 df7e4764 dec730cc c0207538 df7e4764 
Call Trace:
 [<c0257e9a>] usb_set_interface+0x1a/0x140
 [<c0268780>] hid_free_device+0x50/0x60
 [<c0251cc5>] usb_unbind_interface+0x45/0x70
 [<c0207426>] device_release_driver+0x56/0x60
 [<c0207538>] bus_remove_device+0x48/0x90
 [<c020663a>] device_del+0x5a/0x90
 [<c0206678>] device_unregister+0x8/0x10
 [<c0257d81>] usb_disable_device+0x61/0xb0
 [<c0252741>] usb_disconnect+0x91/0xe0
 [<c025277c>] usb_disconnect+0xcc/0xe0
 [<c0254b3e>] hub_port_connect_change+0x28e/0x2c0
 [<c0253f7a>] hub_port_status+0x3a/0xb0
 [<c02d3cfc>] schedule+0x27c/0x470
 [<c0254e15>] hub_events+0x2a5/0x320
 [<c0120fa1>] free_uid+0x11/0x80
 [<c0254ebb>] hub_thread+0x2b/0xe0
 [<c01162c0>] default_wake_function+0x0/0x10
 [<c0254e90>] hub_thread+0x0/0xe0
 [<c010427d>] kernel_thread_helper+0x5/0x18

Code: 00 00 90 8d 74 26 00 57 89 d7 56 53 8b 98 9c 01 00 00 31 c0 85 db 74 24 0f
 b6 43 04 31 c9 39 c1 7d 18 89 c6 8d 76 00 8b 44 8b 0c <8b> 10 0f b6 52 02 39 fa
 74 07 41 39 f1 7c ed 31 c0 5b 5e 5f c3 
 hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20

--------------040509060907020903080000
Content-Type: text/plain;
 name="lsusb.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lsusb.txt"

Bus 005 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mm2 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro
ller (#4)
  iSerial                 1 0000:00:10.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xbf
  PortPwrCtrlMask    0x6a 
  Language IDs: (length=4)
     0409 English(US)

Bus 004 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mm2 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro
ller (#3)
  iSerial                 1 0000:00:10.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xbf
  PortPwrCtrlMask    0x6a 
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mm2 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro
ller (#2)
  iSerial                 1 0000:00:10.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xbf
  PortPwrCtrlMask    0x6a 
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mm2 uhci_hcd
  iProduct                2 VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro
ller
  iSerial                 1 0000:00:10.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xbf
  PortPwrCtrlMask    0x6a 
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.6-mm2 ehci_hcd
  iProduct                2 VIA Technologies, Inc. USB 2.0
  iSerial                 1 0000:00:10.4
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
          Usage Type               Data
        wMaxPacketSize     0x0002  bytes 2 once
        bInterval              12
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts             8
  wHubCharacteristic 0x0008
    Ganged power switching
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0xbf 0x6a
  PortPwrCtrlMask    0x45  0x5b 
  Language IDs: (length=4)
     0409 English(US)
--------------040509060907020903080000--
