Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbTGJQ5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269421AbTGJQ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:56:59 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:36869 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265398AbTGJQ4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:56:20 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.74-mm3 oops when registering USB serial console
Date: Fri, 11 Jul 2003 01:09:03 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200307110106.32132.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Randy Dunlap for fixing the USB console config.

Sorry, this is like fighting dragons, cut off one head, get 2 more ;-)

Kernel: 2.5.74-mm3 
Command line: vga=0xf07 ro root=/dev/hda2 4 console=ttyUSB0,115200n8r
module-init-tools version 0.9.10
USB config all modules

Jul 11 00:35:39 mhfl2 kernel: Warning: unable to open an initial console.
Jul 11 00:35:40 mhfl2 kernel: spurious 8259A interrupt: IRQ7.
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usbfs
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver hub
Jul 11 00:35:40 mhfl2 kernel: ohci-hcd 0000:00:14.0: ALi Corporation USB 1.1 Controller
Jul 11 00:35:40 mhfl2 kernel: ohci-hcd 0000:00:14.0: irq 7, pci mem cf826000
Jul 11 00:35:40 mhfl2 kernel: ohci-hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
Jul 11 00:35:40 mhfl2 kernel: usb usb1: Product: ALi Corporation USB 1.1 Controller
Jul 11 00:35:40 mhfl2 kernel: usb usb1: Manufacturer: Linux 2.5.74-mm3-mhf47 ohci-hcd
Jul 11 00:35:40 mhfl2 kernel: usb usb1: SerialNumber: 0000:00:14.0
Jul 11 00:35:40 mhfl2 kernel: hub 1-0:0: USB hub found
Jul 11 00:35:40 mhfl2 kernel: hub 1-0:0: 2 ports detected
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver hiddev
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver hid
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Jul 11 00:35:40 mhfl2 kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Jul 11 00:35:40 mhfl2 kernel: hub 1-0:0: new USB device on port 2, assigned address 2

Jul 11 00:35:40 mhfl2 kernel: EXT3 FS on hda2, internal journal
Jul 11 00:35:40 mhfl2 kernel: Adding 546200k swap on /dev/hda4.  Priority:-1 extents:1
Jul 11 00:35:40 mhfl2 kernel: kjournald starting.  Commit interval 5 seconds
Jul 11 00:35:40 mhfl2 kernel: EXT3 FS on hda1, internal journal
Jul 11 00:35:40 mhfl2 kernel: EXT3-fs: mounted filesystem with ordered data mode.
Jul 11 00:35:40 mhfl2 kernel: kjournald starting.  Commit interval 5 seconds
Jul 11 00:35:40 mhfl2 kernel: EXT3 FS on hda3, internal journal
Jul 11 00:35:40 mhfl2 kernel: EXT3-fs: mounted filesystem with ordered data mode.

Jul 11 00:35:40 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/core/usb.c: registered new driver usbserial
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Jul 11 00:35:40 mhfl2 kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
Jul 11 00:35:40 mhfl2 kernel: pl2303 1-2:0: PL-2303 converter detected
Jul 11 00:35:41 mhfl2 kernel: usb 1-2: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Jul 11 00:35:41 mhfl2 kernel: Unable to handle kernel paging request at virtual address cf828170
Jul 11 00:35:41 mhfl2 kernel:  printing eip:
Jul 11 00:35:41 mhfl2 kernel: cf828170
Jul 11 00:35:41 mhfl2 kernel: *pde = 012b2067
Jul 11 00:35:41 mhfl2 kernel: *pte = 00000000
Jul 11 00:35:41 mhfl2 kernel: Oops: 0000 [#1]
Jul 11 00:35:41 mhfl2 kernel: CPU:    0
Jul 11 00:35:41 mhfl2 kernel: EIP:    0060:[<cf828170>]    Not tainted VLI
Jul 11 00:35:41 mhfl2 kernel: EFLAGS: 00010282
Jul 11 00:35:41 mhfl2 kernel: EIP is at 0xcf828170
Jul 11 00:35:41 mhfl2 kernel: eax: c041c22e   ebx: cf8b0f20   ecx: c0424a6c   edx: cf828170
Jul 11 00:35:41 mhfl2 kernel: esi: c0424a68   edi: cf8b0f27   ebp: ce313e40   esp: ce313e20
Jul 11 00:35:41 mhfl2 kernel: ds: 007b   es: 007b   ss: 0068
Jul 11 00:35:41 mhfl2 kernel: Process modprobe (pid: 202, threadinfo=ce312000 task=ce8dece0)
Jul 11 00:35:41 mhfl2 kernel: Stack: c011e6ea cf8b0f20 c041c22e ce58125e ce58122c ce5811d8 00000000 00000000 
Jul 11 00:35:41 mhfl2 kernel:        ce313e4c cf8adbfa cf8b0f20 ce313f04 cf8acc43 00000000 00000000 cf839f38 
Jul 11 00:35:41 mhfl2 kernel:        cf839fa0 cf839e20 cf838244 ce584580 ce581158 cec2e218 cec2e29e 00000001 
Jul 11 00:35:41 mhfl2 kernel: Call Trace:
Jul 11 00:35:41 mhfl2 kernel:  [<c011e6ea>] register_console+0xb6/0x16c
Jul 11 00:35:41 mhfl2 kernel:  [<cf8adbfa>] usb_serial_console_init+0x3a/0x40 [usbserial]
Jul 11 00:35:41 mhfl2 kernel:  [<cf8acc43>] usb_serial_probe+0xa07/0xb8c [usbserial]
Jul 11 00:35:41 mhfl2 kernel:  [<cf838244>] pl2303_read_int_callback+0x0/0x1b8 [pl2303]
Jul 11 00:35:41 mhfl2 kernel:  [<c011e330>] call_console_drivers+0xdc/0xe8
Jul 11 00:35:41 mhfl2 kernel:  [<c011e53d>] release_console_sem+0x31/0x90
Jul 11 00:35:41 mhfl2 kernel:  [<c011e4ba>] printk+0x112/0x128
Jul 11 00:35:41 mhfl2 kernel:  [<cf844096>] usb_device_probe+0x7e/0xcc [usbcore]
Jul 11 00:35:41 mhfl2 kernel:  [<cf8440b1>] usb_device_probe+0x99/0xcc [usbcore]
Jul 11 00:35:42 mhfl2 kernel:  [<c023a294>] bus_match+0x38/0x68
Jul 11 00:35:42 mhfl2 kernel:  [<c023a37a>] driver_attach+0x3e/0x58
Jul 11 00:35:42 mhfl2 kernel:  [<c023a5ce>] bus_add_driver+0x6e/0x8c
Jul 11 00:35:42 mhfl2 kernel:  [<c023a95a>] driver_register+0x36/0x3c
Jul 11 00:35:42 mhfl2 kernel:  [<cf8441bb>] usb_register+0x6f/0xb0 [usbcore]
Jul 11 00:35:42 mhfl2 kernel:  [<cf83c017>] pl2303_init+0x17/0x27 [pl2303]
Jul 11 00:35:42 mhfl2 kernel:  [<c012fbe4>] sys_init_module+0xe0/0x1ac
Jul 11 00:35:42 mhfl2 kernel:  [<c010adf7>] syscall_call+0x7/0xb
Jul 11 00:35:42 mhfl2 kernel: 
Jul 11 00:35:42 mhfl2 kernel: Code:  Bad EIP value.

Regards
Michael


-- 
Powered by linux-2.5.74-mm3. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

