Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUEGNUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUEGNUx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 09:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUEGNUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 09:20:53 -0400
Received: from imap.gmx.net ([213.165.64.20]:15071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263574AbUEGNUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 09:20:47 -0400
Date: Fri, 7 May 2004 15:20:45 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [linux-2.6.5] oops when plugging CDC USB network device...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <8293.1083936045@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When plugging a Motorola SurfBoard 5100 device into my box, khubd oopses.
Kernel is stock linux-2.6.5.

Chipset is nForce 2 (OHCI), USB 2 EHCI controller disabled, so just USB 1.1
controller active.

Please CC me if more information would be handy.

Harvested from kernel logs:

ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
ohci_hcd 0000:00:02.0: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:02.0: reset, control = 0x684
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 20, pci mem e080a000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: nVidia Corporation nForce2 USB Controller
usb usb1: Manufacturer: Linux 2.6.5 ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: registering 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub  
hub 1-0:1.0: unknown reserved power switching mode
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms 
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
ohci_hcd 0000:00:02.0: created debug files
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.0: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:02.0: hcca frame #0025
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000 
ohci_hcd 0000:00:02.0: roothub.status 00000000
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
ohci_hcd 0000:00:02.1: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:02.1: reset, control = 0x684
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 22, pci mem e080c000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: root hub device address 1
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb2: Product: nVidia Corporation nForce2 USB Controller (#2)
usb usb2: Manufacturer: Linux 2.6.5 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.1
usb usb2: registering 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub  
hub 2-0:1.0: unknown reserved power switching mode
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: Port indicators are not supported
hub 2-0:1.0: power on to power good time: 2ms 
hub 2-0:1.0: hub controller current requirement: 0mA
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: enabling power on all ports
ohci_hcd 0000:00:02.1: created debug files
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.1: intrenable 0x80000002 MIE WDH
ohci_hcd 0000:00:02.1: hcca frame #0026
ohci_hcd 0000:00:02.1: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000 
ohci_hcd 0000:00:02.1: roothub.status 00000000
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
drivers/usb/core/usb.c: registered new driver usbnet
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [1] = 0x00010101 CSC PPS
CCS
hub 1-0:1.0: port 1, status 101, change 1, 12 Mb/s
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x101
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [1] = 0x00100103 PRSC
PPS PES CCS
usb 1-1: new full speed USB device using address 2
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=3
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 1-1: Product: USB Cable Modem
usb 1-1: registering 1-1:1.0 (config #1, interface 0)
usbnet 1-1:1.0: usb_probe_interface
usbnet 1-1:1.0: usb_probe_interface - got id
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c028ff64
*pde = 00000000
Oops: 0000 [#1]
DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c028ff64>]    Not tainted
EFLAGS: 00010296   (2.6.5) 
EIP is at usb_disable_interface+0x14/0x50
eax: df3a4ef8   ebx: 00000000   ecx: 00000000   edx: dffdaf38
esi: 00000001   edi: 00000000   ebp: df3aabf8   esp: df98bcfc   
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=df98a000 task=df9bb9e0)
Stack: 00000001 0000000b 00000001 00000001 df3d5d94 df3aabf8 c0290257
df3aabf8
       df3a4ef8 0000000b 00000001 00000001 00000001 00000000 00000000
00001388
       00000000 df3a4ef8 df3d5d94 df3d5d94 df3d5d44 00000001 c029e301
df3aabf8
Call Trace:
 [<c0290257>] usb_set_interface+0xb7/0x1a0
 [<c029e301>] get_endpoints+0xb1/0x120
 [<c029e4bb>] generic_cdc_bind+0xcb/0x220
 [<c029e708>] cdc_bind+0x28/0xe0
 [<c0263d7b>] alloc_netdev+0x7b/0xb0
 [<c02a084e>] usbnet_probe+0x49e/0x510
 [<c01a8a9d>] sysfs_new_inode+0x5d/0xb0
 [<c0287516>] usb_probe_interface+0xb6/0xd0
 [<c02526ef>] bus_match+0x3f/0x70
 [<c0252761>] device_attach+0x41/0xa0
 [<c0252965>] bus_add_device+0x75/0xc0
 [<c0251715>] device_add+0xa5/0x140
 [<c029068b>] usb_set_configuration+0x24b/0x2f0
 [<c0288530>] usb_new_device+0x2d0/0x5a0
 [<c028adca>] hub_port_connect_change+0x1ea/0x2f0
 [<c028b2f5>] hub_events+0x425/0x5e0
 [<c028b4dd>] hub_thread+0x2d/0x100
 [<c01198a0>] default_wake_function+0x0/0x20
 [<c028b4b0>] hub_thread+0x0/0x100
 [<c0104d91>] kernel_thread_helper+0x5/0x14

Code: 80 7b 04 00 74 26 31 f6 8d 74 26 00 8b 43 0c 47 0f b6 44 30 


-- 
Daniel J Blueman

"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info

