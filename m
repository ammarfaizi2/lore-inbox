Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265921AbTF3W2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 18:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265938AbTF3W2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 18:28:12 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:23912 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265921AbTF3W1K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 18:27:10 -0400
Message-ID: <3F00BC9A.8050002@sbcglobal.net>
Date: Mon, 30 Jun 2003 17:41:30 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: USB hiddev support 2.5.7x
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having trouble with hiddev in 2.5.70 and later with an APC UPS. 

Could it be related to this message?:
kernel: drivers/usb/core/hub.c: usb-00:0a.2-3 clear tt 1 (00b0) error -32
last message repeated 2 times

I get that in the log when I try to open the hiddev device from apcupsd 
or nut.  The APC is listed in lsusb and is using the hid driver...

This boot log is from 2.5.70, but I'm pretty sure 2.5.73 is essentially 
the same...I can send a log from 2.5.73 if required.

Inspecting /boot/System.map-2.5.70
Loaded 30635 symbols from /boot/System.map-2.5.70.
Symbols match kernel version 2.5.70.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
hdg: AOpen Inc. DVD-ROM DVD-1640 PRO 0122, ATAPI CD/DVD-ROM drive
<4>ide3 at 0xc000-0xc007,0xc402 on irq 11
<4>hda: max request size: 128KiB
<6>hda: host protected area => 1
<6>hda: 40000464 sectors (20480 MB) w/1024KiB Cache, CHS=39683/16/63, 
UDMA(33)
<6> hda: hda1 hda2
<4>hde: max request size: 128KiB
<6>hde: host protected area => 1
<6>hde: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=119150/16/63, 
UDMA(133)
<6> hde: hde1 hde2
<4>end_request: I/O error, dev hdb, sector 0
<4>hdb: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
<6>Uniform CD-ROM driver Revision: 3.12
<4>end_request: I/O error, dev hdg, sector 0
<4>hdg: ATAPI 40X DVD-ROM drive, 512kB Cache
<4>ide-floppy driver 0.99.newide
<6>hdc: 98304kB, 196608 blocks, 512 sector size
<6>hdc: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
<6> hdc: hdc4
<6> hdc: hdc4
<4>kobject_register failed for hdc4 (-17)
<4>Call Trace: [kobject_register+48/72]  [add_partition+170/180]  
[register_disk+271/324]  [add_disk+52/64]  [exact_match+0/12]  
[exact_lock+0/28]  [idefloppy_attach+326/372]  [ata_attach+142/432]  
[ide_register_driver+212/268]  [idefloppy_init+20/32]  
[do_initcalls+60/140]  [do_basic_setup+25/36]  [init+51/392]  
[init+0/392]  [kernel_thread_helper+5/12]
<7>request_module: failed /sbin/modprobe -- scsi_hostadapter. error = -16
<4>Console: switching to colour frame buffer device 160x64
<7>drivers/usb/host/ehci-hcd.c: block sizes: qh 128 qtd 96 itd 128 sitd 64
<6>ehci-hcd 00:0a.2: NEC Corporation USB 2.0
<6>ehci-hcd 00:0a.2: irq 9, pci mem d182c000
<6>Please use the 'usbfs' filetype instead, the 'usbdevfs' name is 
deprecated.
<6>ehci-hcd 00:0a.2: new USB bus registered, assigned bus number 1
<7>ehci-hcd 00:0a.2: ehci_start hcs_params 0x2293 dbg=0 cc=2 pcc=2 ports=3
<7>ehci-hcd 00:0a.2: ehci_start portroute 1 0 1
<7>ehci-hcd 00:0a.2: ehci_start hcc_params e806 thresh 0 uframes 
256/512/1024 park
<7>ehci-hcd 00:0a.2: capability 0001 at e8
<7>ehci-hcd 00:0a.2: reset command 080b02 park=3 ithresh=8 period=1024 
Reset HALT
<7>ehci-hcd 00:0a.2: init command 010009 (park)=0 ithresh=1 period=256 RUN
<6>ehci-hcd 00:0a.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
<7>ehci-hcd 00:0a.2: root hub device address 1
<7>usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb1: Product: NEC Corporation USB 2.0
<6>usb usb1: Manufacturer: Linux 2.5.70 ehci-hcd
<6>usb usb1: SerialNumber: 00:0a.2
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb1: usb_new_device - registering interface 1-0:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 1-0:0: usb_device_probe
<7>hub 1-0:0: usb_device_probe - got id
<6>hub 1-0:0: USB hub found
<6>hub 1-0:0: 3 ports detected
<7>hub 1-0:0: standalone hub
<7>hub 1-0:0: individual port power switching
<7>hub 1-0:0: individual port over-current protection
<7>hub 1-0:0: Single TT
<7>hub 1-0:0: TT requires at most 8 FS bit times
<7>hub 1-0:0: Port indicators are not supported
<7>hub 1-0:0: power on to power good time: 0ms
<7>hub 1-0:0: hub controller current requirement: 0mA
<7>hub 1-0:0: local power source is good
<7>hub 1-0:0: no over-current condition exists
<7>hub 1-0:0: enabling power on all ports
<7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
<7>ohci-hcd: block sizes: ed 64 td 64
<6>ohci-hcd 00:0a.0: NEC Corporation USB
<6>ohci-hcd 00:0a.0: irq 10, pci mem d182e000
<6>ohci-hcd 00:0a.0: new USB bus registered, assigned bus number 2
<7>ohci-hcd 00:0a.0: USB HC reset_hc 00:0a.0: ctrl = 0x0 ;
<7>ohci-hcd 00:0a.0: root hub device address 1
<7>usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb2: Product: NEC Corporation USB
<6>usb usb2: Manufacturer: Linux 2.5.70 ohci-hcd
<6>usb usb2: SerialNumber: 00:0a.0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb2: usb_new_device - registering interface 2-0:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 2-0:0: usb_device_probe
<7>hub 2-0:0: usb_device_probe - got id
<6>hub 2-0:0: USB hub found
<6>hub 2-0:0: 2 ports detected
<7>hub 2-0:0: standalone hub
<7>hub 2-0:0: ganged power switching
<7>hub 2-0:0: global over-current protection
<7>hub 2-0:0: Port indicators are not supported
<7>hub 2-0:0: power on to power good time: 30ms
<7>hub 2-0:0: hub controller current requirement: 0mA
<7>hub 2-0:0: local power source is good
<7>hub 2-0:0: no over-current condition exists
<7>hub 2-0:0: enabling power on all ports
<7>ehci-hcd 00:0a.2: GetStatus port 2 status 001803 POWER sig=j  CSC CONNECT
<7>hub 1-0:0: port 2, status 501, change 1, 480 Mb/s
<7>ohci-hcd 00:0a.0: created debug files
<7>ohci-hcd 00:0a.0: OHCI controller state
<7>ohci-hcd 00:0a.0: OHCI 1.0, with legacy support registers
<7>ohci-hcd 00:0a.0: control 0x08f HCFS=operational IE PLE CBSR=3
<7>ohci-hcd 00:0a.0: cmdstatus 0x00000 SOC=0
<7>ohci-hcd 00:0a.0: intrstatus 0x00000004 SF
<7>ohci-hcd 00:0a.0: intrenable 0x80000012 MIE UE WDH
<7>ohci-hcd 00:0a.0: hcca frame #00e2
<7>ohci-hcd 00:0a.0: roothub.a 0f000202 POTPGT=15 NPS NDP=2
<7>ohci-hcd 00:0a.0: roothub.b 00000000 PPCM=0000 DR=0000
<7>ohci-hcd 00:0a.0: roothub.status 00000000
<7>ohci-hcd 00:0a.0: roothub.portstatus [0] 0x00000100 PPS
<7>ohci-hcd 00:0a.0: roothub.portstatus [1] 0x00000100 PPS
<6>ohci-hcd 00:0a.1: NEC Corporation USB (#2)
<6>ohci-hcd 00:0a.1: irq 12, pci mem d1830000
<6>ohci-hcd 00:0a.1: new USB bus registered, assigned bus number 3
<7>ohci-hcd 00:0a.1: USB HC reset_hc 00:0a.1: ctrl = 0x0 ;
<7>ohci-hcd 00:0a.1: root hub device address 1
<7>usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb3: Product: NEC Corporation USB (#2)
<6>usb usb3: Manufacturer: Linux 2.5.70 ohci-hcd
<6>usb usb3: SerialNumber: 00:0a.1
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb usb3: usb_new_device - registering interface 3-0:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 3-0:0: usb_device_probe
<7>hub 3-0:0: usb_device_probe - got id
<6>hub 3-0:0: USB hub found
<6>hub 3-0:0: 1 port detected
<7>hub 3-0:0: standalone hub
<7>hub 3-0:0: ganged power switching
<7>hub 3-0:0: global over-current protection
<7>hub 3-0:0: Port indicators are not supported
<7>hub 3-0:0: power on to power good time: 30ms
<7>hub 3-0:0: hub controller current requirement: 0mA
<7>hub 3-0:0: local power source is good
<7>hub 3-0:0: no over-current condition exists
<7>hub 3-0:0: enabling power on all ports
<6>hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
<7>ohci-hcd 00:0a.1: created debug files
<7>ohci-hcd 00:0a.1: OHCI controller state
<7>ohci-hcd 00:0a.1: OHCI 1.0, with legacy support registers
<7>ohci-hcd 00:0a.1: control 0x08f HCFS=operational IE PLE CBSR=3
<7>ohci-hcd 00:0a.1: cmdstatus 0x00000 SOC=0
<7>ohci-hcd 00:0a.1: intrstatus 0x00000004 SF
<7>ohci-hcd 00:0a.1: intrenable 0x80000012 MIE UE WDH
<7>ohci-hcd 00:0a.1: hcca frame #00dd
<7>ohci-hcd 00:0a.1: roothub.a 0f000201 POTPGT=15 NPS NDP=1
<7>ohci-hcd 00:0a.1: roothub.b 00000000 PPCM=0000 DR=0000
<7>ohci-hcd 00:0a.1: roothub.status 00000000
<7>ohci-hcd 00:0a.1: roothub.portstatus [0] 0x00000100 PPS
<6>drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
<6>drivers/usb/core/usb.c: registered new driver usblp
<6>drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
<6>Initializing USB Mass Storage driver...
<6>drivers/usb/core/usb.c: registered new driver usb-storage
<6>USB Mass Storage support registered.
<6>drivers/usb/core/usb.c: registered new driver hiddev
<6>drivers/usb/core/usb.c: registered new driver hid
<6>drivers/usb/input/hid-core.c: v2.0:USB HID core driver
<6>drivers/usb/core/usb.c: registered new driver usbnet
<6>drivers/usb/core/usb.c: registered new driver usbserial
<6>drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
<6>drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Handspring Visor / Treo / Palm 4.0 / Clié 4.x
<6>drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Sony Clié 3.5
<6>drivers/usb/core/usb.c: registered new driver visor
<6>drivers/usb/serial/visor.c: USB HandSpring Visor, Palm m50x, Sony 
Clié driver v2.1
<6>drivers/usb/serial/usb-serial.c: USB Serial support registered for 
PocketPC PDA
<6>drivers/usb/serial/ipaq.c: USB PocketPC PDA driver v0.5
<6>drivers/usb/core/usb.c: registered new driver ipaq
<6>drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Keyspan PDA
<6>drivers/usb/serial/usb-serial.c: USB Serial support registered for 
Keyspan PDA - (prerenumeration)
<6>drivers/usb/core/usb.c: registered new driver keyspan_pda
<6>drivers/usb/serial/keyspan_pda.c: USB Keyspan PDA Converter driver v1.1
<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker
<7>ehci-hcd 00:0a.2: port 2 full speed --> companion
<7>ehci-hcd 00:0a.2: GetStatus port 2 status 003801 POWER OWNER sig=j  
CONNECT
<7>ehci-hcd 00:0a.2: GetStatus port 3 status 001803 POWER sig=j  CSC CONNECT
<7>hub 1-0:0: port 3, status 501, change 1, 480 Mb/s
<6>input: Analog 2-axis 4-button joystick at pnp00:01.03/gameport0 [TSC 
timer, 395 MHz clock, 1425 ns res]
<6>gameport: NS558 PnP at pnp00:01.03 io 0x200 size 8 speed 701 kHz
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>input: AT Set 2 keyboard on isa0060/serio0
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>I2O Core - (C) Copyright 1999 Red Hat Software
<6>I2O: Event thread created as pid 11
<6>i2o: Checking for PCI I2O controllers...
<6>I2O configuration manager v 0.04.
<6>  (C) Copyright 1999 Red Hat Software
<6>I2O Block Storage OSM v0.9
<6>   (c) Copyright 1999-2001 Red Hat Software.
<6>i2o_block: Checking for Boot device...
<6>i2o_block: Checking for I2O Block devices...
<6>i2o_scsi.c: Version 0.1.2
<6>  chain_pool: 0 bytes @ c131e760
<6>  (512 byte buffers X 4 can_queue X 0 i2o controllers)
<6>i2c /dev entries driver module version 2.7.0 (20021208)
<6>Advanced Linux Sound Architecture Driver Version 0.9.2 (Thu Mar 20 
13:31:57 2003 UTC).
<7>request_module: failed /sbin/modprobe -- snd-card-0. error = -16
<3>pnp: res: The resources requested do not match those set for the PnP 
device '00:01.00'.
<3>sb16: no OPL device at 0x388-0x38a
<6>ALSA device list:
<6>  #0: Sound Blaster 16 at 0x220, irq 5, dma 1&5
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP: routing cache hash table of 2048 buckets, 16Kbytes
<6>TCP: Hash tables configured (established 16384 bind 16384)
<6>IPv4 over IPv4 tunneling driver
<6>GRE over IPv4 tunneling driver
<6>Linux IP multicast router 0.06 plus PIM-SM
<4>ip_conntrack version 2.1 (2047 buckets, 16376 max) - 304 bytes per 
conntrack
<4>ip_tables: (C) 2000-2002 Netfilter core team
<6>hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
<4>arp_tables: (C) 2002 David S. Miller
<7>hub 1-0:0: port 3 not reset yet, waiting 10ms
<6>Initializing IPsec netlink socket
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<6>IPv6 v0.8 for NET4.0
<6>IPv6 over IPv4 tunneling driver
<4>ip6_tables: (C) 2000-2002 Netfilter core team
<7>ehci-hcd 00:0a.2: port 3 high speed
<7>ehci-hcd 00:0a.2: GetStatus port 3 status 001005 POWER sig=se0  PE 
CONNECT
<6>hub 1-0:0: new USB device on port 3, assigned address 2
<7>usb 1-3: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 1-3: Product: USB2.0 Hub Controller
<6>usb 1-3: Manufacturer: NEC Corporation
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-3: usb_new_device - registering interface 1-3:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hub 1-3:0: usb_device_probe
<7>hub 1-3:0: usb_device_probe - got id
<6>hub 1-3:0: USB hub found
<6>hub 1-3:0: 4 ports detected
<7>hub 1-3:0: standalone hub
<7>hub 1-3:0: individual port power switching
<7>hub 1-3:0: global over-current protection
<7>hub 1-3:0: Single TT
<7>hub 1-3:0: TT requires at most 16 FS bit times
<7>hub 1-3:0: Port indicators are  supported
<7>hub 1-3:0: power on to power good time: 0ms
<7>hub 1-3:0: hub controller current requirement: 100mA
<7>hub 1-3:0: local power source is good
<7>hub 1-3:0: no over-current condition exists
<7>drivers/usb/host/ehci-sched.c: scheduled qh c131a100 usecs 7/0 period 
256.0 starting 255.0 (gap 0)
<7>hub 1-3:0: enabling power on all ports
<7>ohci-hcd 00:0a.1: GetStatus roothub.portstatus [1] = 0x00010101 CSC 
PPS CCS
<7>hub 3-0:0: port 1, status 101, change 1, 12 Mb/s
<7>registering ipv6 mark target
<6>BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
<7>UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-25
<7>UDF-fs DEBUG fs/udf/super.c:1472:udf_fill_super: Multi-session=0
<7>UDF-fs DEBUG fs/udf/super.c:460:udf_vrs: Starting at sector 16 (2048 
byte sectors)
<7>UDF-fs DEBUG fs/udf/super.c:1208:udf_check_valid: Failed to read byte 
32768. Assuming open disc. Skipping validity check
<6>hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
<7>UDF-fs DEBUG fs/udf/misc.c:286:udf_read_tagged: location mismatch 
block 256, tag 4294967295 != 256
<7>UDF-fs DEBUG fs/udf/super.c:1262:udf_load_partition: No Anchor block 
found
<4>UDF-fs: No partition found (1)
<7>ohci-hcd 00:0a.1: GetStatus roothub.portstatus [1] = 0x00100103 PRSC 
PPS PES CCS
<6>hub 3-0:0: new USB device on port 1, assigned address 2
<7>ohci-hcd 00:0a.1: urb cfd8dd80 path 1 ep0out 5fc20000 cc 5 --> status 
-110
<4>found reiserfs format "3.6" with standard journal
<7>ohci-hcd 00:0a.1: urb cfd8dd80 path 1 ep0out 5fc20000 cc 5 --> status 
-110
<3>usb 3-1: USB device not accepting new address=2 (error=-110)
<7>ohci-hcd 00:0a.1: GetStatus roothub.portstatus [1] = 0x00100103 PRSC 
PPS PES CCS
<6>hub 3-0:0: new USB device on port 1, assigned address 3
<7>ohci-hcd 00:0a.1: urb cfd8dd80 path 1 ep0out 5fc20000 cc 5 --> status 
-110
<7>ohci-hcd 00:0a.1: urb cfd8dd80 path 1 ep0out 5fc20000 cc 5 --> status 
-110
<3>usb 3-1: USB device not accepting new address=3 (error=-110)
<7>hub 1-3:0: port 1, status 301, change 1, 1.5 Mb/s
<6>hub 1-3:0: debounce: port 1: delay 100ms stable 4 status 0x301
<6>hub 1-3:0: new USB device on port 1, assigned address 3
<7>usb 1-3.1: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 1-3.1: Product: USB Receiver
<6>usb 1-3.1: Manufacturer: Logitech
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-3.1: usb_new_device - registering interface 1-3.1:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hid 1-3.1:0: usb_device_probe
<7>hid 1-3.1:0: usb_device_probe - got id
<6>input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-00:0a.2-3.1
<7>hub 1-3:0: port 3, status 301, change 1, 1.5 Mb/s
<6>hub 1-3:0: debounce: port 3: delay 100ms stable 4 status 0x301
<6>hub 1-3:0: new USB device on port 3, assigned address 4
<7>usb 1-3.3: new device strings: Mfr=3, Product=1, SerialNumber=2
<6>usb 1-3.3: Product: Back-UPS ES 350 FW:800.e3.D USB FW:e3
<6>usb 1-3.3: Manufacturer: APC
<6>usb 1-3.3: SerialNumber: AB0233345257 
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-3.3: usb_new_device - registering interface 1-3.3:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>hid 1-3.3:0: usb_device_probe
<7>hid 1-3.3:0: usb_device_probe - got id
<7>drivers/usb/host/ehci-q.c: clear tt 00:0a.2-3 p3 buffer, a4 ep0
<3>drivers/usb/core/hub.c: usb-00:0a.2-3 clear tt 1 (0040) error -32
<7>drivers/usb/host/ehci-q.c: clear tt 00:0a.2-3 p3 buffer, a4 ep0
<3>drivers/usb/core/hub.c: usb-00:0a.2-3 clear tt 1 (0040) error -32
<7>drivers/usb/host/ehci-q.c: clear tt 00:0a.2-3 p3 buffer, a4 ep0
<7>drivers/usb/core/file.c: looking for a minor, starting at 0
<3>drivers/usb/core/hub.c: usb-00:0a.2-3 clear tt 1 (0040) error -32
<6>hiddev0: USB HID v1.10 Device [APC Back-UPS ES 350 FW:800.e3.D USB 
FW:e3] on usb-00:0a.2-3.3
<7>hub 1-3:0: port 4, status 101, change 1, 12 Mb/s
<6>hub 1-3:0: debounce: port 4: delay 100ms stable 4 status 0x101
<7>hub 1-3:0: port 4 not reset yet, waiting 10ms
<6>hub 1-3:0: new USB device on port 4, assigned address 5
<7>usb 1-3.4: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 1-3.4: Product: Perfection636
<6>usb 1-3.4: Manufacturer: EPSON
<7>drivers/usb/core/usb.c: usb_hotplug
<7>usb 1-3.4: usb_new_device - registering interface 1-3.4:0
<7>drivers/usb/core/usb.c: usb_hotplug
<7>ehci-hcd 00:0a.2: GetStatus port 2 status 003802 POWER OWNER sig=j  CSC
<7>hub 1-0:0: port 2, status 0, change 1, 12 Mb/s
<4>Reiserfs journal params: device hde1, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
<4>reiserfs: checking transaction log (hde1) for (hde1)
<4>Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<6>Freeing unused kernel memory: 184k freed
<6>Adding 1052216k swap on /dev/hda1.  Priority:42 extents:1
<6>Disabled Privacy Extensions on device c04e6640(lo)
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.


