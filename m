Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUDKMIO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 08:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUDKMIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 08:08:14 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:52305 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S262337AbUDKMIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 08:08:10 -0400
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
Organization: adaptive planet
To: linux-kernel@vger.kernel.org
Subject: crash of usb ... backtrace included.
Date: Sun, 11 Apr 2004 14:08:08 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404111408.08828.wim.delvaux@adaptiveplanet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apr 11 13:58:32 buro kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000070
Apr 11 13:58:32 buro kernel:  printing eip:
Apr 11 13:58:32 buro kernel: c01746c1
Apr 11 13:58:32 buro kernel: *pde = 00000000
Apr 11 13:58:32 buro kernel: Oops: 0002 [#1]
Apr 11 13:58:32 buro kernel: PREEMPT
Apr 11 13:58:32 buro kernel: CPU:    0
Apr 11 13:58:32 buro kernel: EIP:    0060:[sysfs_hash_and_remove+21/125]    
Tainted: P   VLI
Apr 11 13:58:32 buro kernel: EFLAGS: 00010282   (2.6.5-mm3)
Apr 11 13:58:32 buro kernel: EIP is at sysfs_hash_and_remove+0x15/0x7d
Apr 11 13:58:32 buro kernel: eax: 00000000   ebx: e1ac33e0   ecx: 00000070   
edx: ffff0001
Apr 11 13:58:32 buro kernel: esi: cf512c80   edi: e1ac3380   ebp: e1ac33e0   
esp: df72be34
Apr 11 13:58:32 buro kernel: ds: 007b   es: 007b   ss: 0068
Apr 11 13:58:32 buro kernel: Process khubd (pid: 754, threadinfo=df72b000 
task=df719130)
Apr 11 13:58:32 buro kernel: Stack: d9076880 e09d44a0 e1ac33e0 d17b2130 
c01cb7a0 cf512c80 c0286d6f c01cbb18
Apr 11 13:58:32 buro kernel:        d17b2130 e1ac33cc d17b2000 d17b2000 
d13aa400 d13aa524 e1ab92d4 d17b2130
Apr 11 13:58:32 buro kernel:        d9076890 d9076580 e09d2d8c d17b2000 
d9076880 e09d44a0 d9076980 e09d44a0
Apr 11 13:58:32 buro kernel: Call Trace:
Apr 11 13:58:32 buro kernel:  [class_device_dev_unlink+26/30] 
class_device_dev_unlink+0x1a/0x1e
Apr 11 13:58:32 buro kernel:  [class_device_del+117/174] 
class_device_del+0x75/0xae
Apr 11 13:58:32 buro kernel:  [__crc_journal_invalidatepage+2591152/3661950] 
hci_unregister_dev+0x10/0xa1 [bluetooth]
Apr 11 13:58:32 buro kernel:  [__crc_pci_enable_bridges+182274/4730582] 
hci_usb_disconnect+0x35/0x7d [hci_usb]
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2905856/3188212] 
usb_unbind_interface+0x7a/0x7c [usbcore]
Apr 11 13:58:32 buro kernel:  [device_release_driver+100/102] 
device_release_driver+0x64/0x66
Apr 11 13:58:32 buro kernel:  [bus_remove_device+85/150] 
bus_remove_device+0x55/0x96
Apr 11 13:58:32 buro kernel:  [device_del+93/155] device_del+0x5d/0x9b
Apr 11 13:58:32 buro kernel:  [device_unregister+19/35] 
device_unregister+0x13/0x23
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2933965/3188212] 
usb_disable_device+0xdb/0x116 [usbcore]
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2908775/3188212] 
usb_disconnect+0x9f/0x131 [usbcore]
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2919588/3188212] 
hub_port_connect_change+0x2ca/0x2cf [usbcore]
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2920598/3188212] 
hub_events+0x3ed/0x4b1 [usbcore]
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2920839/3188212] 
hub_thread+0x2d/0xe4 [usbcore]
Apr 11 13:58:32 buro kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Apr 11 13:58:32 buro kernel:  [default_wake_function+0/18] 
default_wake_function+0x0/0x12
Apr 11 13:58:32 buro kernel:  [__crc_sleep_on+2920794/3188212] 
hub_thread+0x0/0xe4 [usbcore]
Apr 11 13:58:32 buro kernel:  [kernel_thread_helper+5/11] 
kernel_thread_helper+0x5/0xb
Apr 11 13:58:32 buro kernel:
Apr 11 13:58:32 buro kernel: Code: 89 44 24 04 8d 44 24 08 89 04 24 e8 2a f1 
fd ff 83 c4 18 5b 5f c3 83 ec 10 89 74 24 0c 89 5c 24 08 8b 74 24 14 8b 46 08 
8
d 48 70 <ff> 48 70 78 63 89 34 24 8b 44 24 18 89 44 24 04 e8 66 ff ff ff


This happened when trying to use a usb bluetooth dongle on my system

0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 9
        Memory at e4520000 (32-bit, non-prefetchable)

0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 3
        Memory at e4521000 (32-bit, non-prefetchable)

0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f) (prog-if 10 [OHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at e4522000 (32-bit, non-prefetchable)

0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller (prog-if 20 [EHCI])
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 7010
        Flags: bus master, medium devsel, latency 32, IRQ 11
        Memory at e4523000 (32-bit, non-prefetchable)
        Capabilities: <available only to root>

