Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272931AbTG3O1E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTG3O0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:26:52 -0400
Received: from halon.barra.com ([144.203.11.1]:17131 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id S272931AbTG3OZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:25:51 -0400
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: linux-kernel@vger.kernel.org
Subject: 2.60-test2 oops on unloading ohci-hcd
Date: Wed, 30 Jul 2003 07:12:00 -0700
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307300712.00815.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with 2.6.0-test2 I am getting this oops every time I shut down, is 
this a known problem?


Jul 29 17:03:09 bologoe kernel: ohci-hcd 0000:00:02.0: remove, state 3
Jul 29 17:03:09 bologoe kernel: ohci-hcd 0000:00:02.0: roothub 
graceful disconnect
Jul 29 17:03:09 bologoe kernel: usb usb1: USB disconnect, address 1
Jul 29 17:03:09 bologoe kernel: drivers/usb/core/usb.c: nuking urbs 
assigned to usb1
Jul 29 17:03:09 bologoe kernel: Debug: sleeping function called from 
invalid context at drivers/usb/core/hcd.c:1350
Jul 29 17:03:09 bologoe kernel: Call Trace:
Jul 29 17:03:09 bologoe kernel:  [__might_sleep+95/112] 
__might_sleep+0x5f/0x70
Jul 29 17:03:09 bologoe kernel:  
[__crc_bdev_read_only+1405263/2058957] 
hcd_endpoint_disable+0x18c/0x530 [usbcore]
Jul 29 17:03:09 bologoe kernel:  
[__crc_bdev_read_only+1404867/2058957] hcd_endpoint_disable+0x0/0x530 
[usbcore]
Jul 29 17:03:09 bologoe kernel:  
[__crc_bdev_read_only+1374202/2058957] nuke_urbs+0x87/0x90 [usbcore]
Jul 29 17:03:09 bologoe kernel:  
[__crc_bdev_read_only+1377800/2058957] usb_disconnect+0x95/0x180 
[usbcore]
Jul 29 17:03:09 bologoe kernel:  
[__crc_bdev_read_only+1424199/2058957] usb_hcd_pci_remove+0xb4/0x1b0 
[usbcore]
Jul 29 17:03:09 bologoe kernel:  [pci_device_remove+59/64] 
pci_device_remove+0x3b/0x40
Jul 29 17:03:09 bologoe kernel:  [device_release_driver+98/112] 
device_release_driver+0x62/0x70
Jul 29 17:03:09 bologoe kernel:  [driver_detach+32/48] 
driver_detach+0x20/0x30
Jul 29 17:03:09 bologoe kernel:  [bus_remove_driver+91/160] 
bus_remove_driver+0x5b/0xa0
Jul 29 17:03:09 bologoe kernel:  [driver_unregister+26/70] 
driver_unregister+0x1a/0x46
Jul 29 17:03:09 bologoe kernel:  [unmap_vma_list+31/48] 
unmap_vma_list+0x1f/0x30
Jul 29 17:03:09 bologoe kernel:  [pci_unregister_driver+22/48] 
pci_unregister_driver+0x16/0x30
Jul 29 17:03:09 bologoe kernel:  
[__crc_bdev_read_only+1278082/2058957] ohci_hcd_pci_cleanup+0xf/0x13 
[ohci_hcd]
Jul 29 17:03:09 bologoe kernel:  [sys_delete_module+303/336] 
sys_delete_module+0x12f/0x150
Jul 29 17:03:09 bologoe kernel:  [sys_munmap+88/128] 
sys_munmap+0x58/0x80
Jul 29 17:03:09 bologoe kernel:  [syscall_call+7/11] 
syscall_call+0x7/0xb
Jul 29 17:03:09 bologoe kernel: 
