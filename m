Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265413AbSL1Twv>; Sat, 28 Dec 2002 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265469AbSL1Twv>; Sat, 28 Dec 2002 14:52:51 -0500
Received: from services.cam.org ([198.73.180.252]:2394 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S265413AbSL1Twt>;
	Sat, 28 Dec 2002 14:52:49 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [BK PATCH] USB changes for 2.5.53
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Sat, 28 Dec 2002 15:01:19 -0500
References: <20021228075959.GA14314@kroah.com>
Organization: me
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20021228200120.79E3F10BA@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> Hi,
> 
> Here's a lot of little USB changes, mostly all of them are conversions
> to using the driver core model better for usb and usb-serial devices.
> 
> Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

Something in this seems to be ooping here:


Dec 28 14:39:10 oscar kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
Dec 28 14:39:10 oscar kernel: hub 1-0:0: new USB device on port 1, assigned address 2
Dec 28 14:39:10 oscar kernel: hub 1-1:0: USB hub found
Dec 28 14:39:10 oscar kernel: hub 1-1:0: 4 ports detected
Dec 28 14:39:10 oscar kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x301
Dec 28 14:39:10 oscar kernel: hub 1-0:0: new USB device on port 2, assigned address 3
Dec 28 14:39:10 oscar kernel: usb 1-2: Product: Microsoft IntelliMouse<AE> Optical
Dec 28 14:39:10 oscar kernel: usb 1-2: Manufacturer: Microsoft
Dec 28 14:39:10 oscar kernel: hub 1-1:0: debounce: port 1: delay 100ms stable 4 status 0x101
Dec 28 14:39:10 oscar kernel: hub 1-1:0: new USB device on port 1, assigned address 4
Dec 28 14:39:10 oscar kernel: usb 1-1.1: Product: Prolific Technology Inc.
Dec 28 14:39:10 oscar kernel: usb 1-1.1: Manufacturer: Prolific Technology Inc.
Dec 28 14:39:10 oscar kernel: usb 1-1.1: SerialNumber: Prolific Technology Inc.
Dec 28 14:39:10 oscar kernel: hub 1-1:0: debounce: port 4: delay 100ms stable 4 status 0x101
Dec 28 14:39:10 oscar kernel: hub 1-1:0: new USB device on port 4, assigned address 5
Dec 28 14:39:10 oscar kernel: usb 1-1.4: Product: USB SSFDC
Dec 28 14:39:10 oscar kernel: usb 1-1.4: Manufacturer: SanDisk
Dec 28 14:39:10 oscar kernel: Adding 393552k swap on /dev/hda1.  Priority:1 extents:1
Dec 28 14:39:10 oscar kernel: Adding 393584k swap on /dev/hde1.  Priority:1 extents:1
Dec 28 14:39:10 oscar kernel: Adding 393584k swap on /dev/hdg1.  Priority:1 extents:1
Dec 28 14:39:10 oscar kernel: Module crc32 cannot be unloaded due to unsafe usage in lib/crc32.c:554
Dec 28 14:39:10 oscar kernel: Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 28 14:39:10 oscar kernel: PCI: Found IRQ 11 for device 00:0a.0
Dec 28 14:39:10 oscar kernel: IRQ routing conflict for 00:0a.0, have irq 9, want irq 11
Dec 28 14:39:10 oscar kernel: tulip0:  EEPROM default media type Autosense.
Dec 28 14:39:10 oscar kernel: tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
Dec 28 14:39:10 oscar kernel: tulip0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
Dec 28 14:39:10 oscar kernel: eth0: Digital DS21140 Tulip rev 34 at 0xc000, 00:C0:F0:32:30:70, IRQ 9.
Dec 28 14:39:10 oscar kernel: via-rhine.c:v1.10-LK1.1.15  November-22-2002  Written by Donald Becker
Dec 28 14:39:10 oscar kernel:   http://www.scyld.com/network/via-rhine.html
Dec 28 14:39:10 oscar kernel: PCI: Found IRQ 9 for device 00:08.0
Dec 28 14:39:10 oscar kernel: IRQ routing conflict for 00:08.0, have irq 11, want irq 9
Dec 28 14:39:10 oscar kernel: eth1: VIA VT86C100A Rhine at 0xed120000, 00:80:c8:f9:ee:ba, IRQ 11.
Dec 28 14:39:10 oscar kernel: eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.
Dec 28 14:39:10 oscar kernel: SCSI subsystem driver Revision: 1.00
Dec 28 14:39:10 oscar kernel: Initializing USB Mass Storage driver...
Dec 28 14:39:10 oscar kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse<AE> Optical] on usb-00:07.2-2
Dec 28 14:39:10 oscar kernel: drivers/usb/core/usb.c: registered new driver hid
Dec 28 14:39:10 oscar kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Dec 28 14:39:10 oscar kernel: drivers/usb/core/usb.c: registered new driver usbserial
Dec 28 14:39:10 oscar kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Dec 28 14:39:10 oscar kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
Dec 28 14:39:10 oscar kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Dec 28 14:39:10 oscar kernel:   Vendor: Sandisk   Model: ImageMate SDDR-0  Rev: 0208
Dec 28 14:39:10 oscar kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec 28 14:39:10 oscar kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Dec 28 14:39:10 oscar kernel: USB Mass Storage support registered.
Dec 28 14:39:10 oscar kernel: pl2303 1-1.1:0: PL-2303 hack: descriptors matched but endpoints did not
Dec 28 14:39:10 oscar kernel:  printing eip:
Dec 28 14:39:10 oscar kernel: e09873e0
Dec 28 14:39:10 oscar kernel: Oops: 0000
Dec 28 14:39:10 oscar kernel: CPU:    0
Dec 28 14:39:10 oscar kernel: EIP:    0060:[<e09873e0>]    Not tainted
Dec 28 14:39:10 oscar kernel: EFLAGS: 00010286
Dec 28 14:39:10 oscar kernel: EIP is at usb_serial_probe+0x3a4/0xbd8 [usbserial]
Dec 28 14:39:10 oscar kernel: eax: 00000000   ebx: dfceb6a6   ecx: c0292aa8   edx: dfceb600
Dec 28 14:39:10 oscar kernel: esi: dfd0e240   edi: e0996980   ebp: df871efc   esp: df871e4c
Dec 28 14:39:10 oscar kernel: ds: 007b   es: 007b   ss: 0068
Dec 28 14:39:10 oscar kernel: Process modprobe (pid: 221, threadinfo=df870000 task=df613300)
Dec 28 14:39:10 oscar kernel: Stack: dfceb6a6 e0995797 e099696c e09968e0 e0996820 00000000 00000246 defe5820
Dec 28 14:39:10 oscar kernel:        df871e88 c0150db8 00000000 00000001 00000001 00000001 00000001 00000286
Dec 28 14:39:10 oscar kernel:        e0996980 dfa57000 dfbfe000 df871eb4 dfd13320 00003245 df871ec4 c01166b9
Dec 28 14:39:10 oscar kernel: Call Trace:
Dec 28 14:39:10 oscar kernel:  [<e0995797>] __module_usb_device_size+0xb/0x1054 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e099696c>] pl2303_driver+0x8c/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e09968e0>] pl2303_driver+0x0/0xa0 [pl2303]
Dec 28 14:39:10 oscar pppd[464]: kernel does not support PPP filtering
Dec 28 14:39:10 oscar kernel:  [<e0996820>] +0x0/0xb4 [pl2303]
Dec 28 14:39:10 oscar kernel:  [alloc_inode+40/316] alloc_inode+0x28/0x13c
Dec 28 14:39:10 oscar kernel:  [<e0996980>] pl2303_device+0x0/0xe0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [call_console_drivers+221/232] call_console_drivers+0xdd/0xe8
Dec 28 14:39:10 oscar kernel:  [release_console_sem+86/200] release_console_sem+0x56/0xc8
Dec 28 14:39:10 oscar kernel:  [printk+303/348] printk+0x12f/0x15c
Dec 28 14:39:10 oscar kernel:  [<e09968e0>] pl2303_driver+0x0/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e0996820>] +0x0/0xb4 [pl2303]
Dec 28 14:39:10 oscar kernel:  [usb_device_probe+244/348] usb_device_probe+0xf4/0x15c
Dec 28 14:39:10 oscar kernel:  [<e0996820>] +0x0/0xb4 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e09968f8>] pl2303_driver+0x18/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [bus_match+56/108] bus_match+0x38/0x6c
Dec 28 14:39:10 oscar kernel:  [driver_attach+66/108] driver_attach+0x42/0x6c
Dec 28 14:39:10 oscar kernel:  [<e09968f8>] pl2303_driver+0x18/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e09968f8>] pl2303_driver+0x18/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [bus_add_driver+172/204] bus_add_driver+0xac/0xcc
Dec 28 14:39:10 oscar kernel:  [<e09968f8>] pl2303_driver+0x18/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e09968e0>] pl2303_driver+0x0/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e0996918>] pl2303_driver+0x38/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [driver_register+54/56] driver_register+0x36/0x38
Dec 28 14:39:10 oscar kernel:  [<e09968f8>] pl2303_driver+0x18/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [usb_register+116/168] usb_register+0x74/0xa8
Dec 28 14:39:10 oscar kernel:  [<e09968f8>] pl2303_driver+0x18/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e0999017>] +0x17/0x25 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e09968e0>] pl2303_driver+0x0/0xa0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [<e0996980>] pl2303_device+0x0/0xe0 [pl2303]
Dec 28 14:39:10 oscar kernel:  [sys_init_module+274/408] sys_init_module+0x112/0x198
Dec 28 14:39:10 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 28 14:39:10 oscar kernel:
Dec 28 14:39:10 oscar kernel: Code: ff 30 68 00 93 98 e0 e8 44 f3 78 df 83 c4 10 89 9d 70 ff ff
Dec 28 14:39:10 oscar kernel:  <6>warning: process `update' used the obsolete bdflush system call
Dec 28 14:39:10 oscar kernel: Fix your initscripts?
Dec 28 14:39:10 oscar kernel: IPv4 over IPv4 tunneling driver

Ideas?
Ed Tomlinson

