Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUD3SV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUD3SV1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265185AbUD3SV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:21:26 -0400
Received: from mailgate5.web.de ([217.72.192.165]:23942 "EHLO mailgate5.web.de")
	by vger.kernel.org with ESMTP id S265195AbUD3SVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:21:00 -0400
Date: Fri, 30 Apr 2004 20:20:56 +0200
Message-Id: <1222847847@web.de>
MIME-Version: 1.0
From: "Andreas Weber" <and_weber_and@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: usb_storage flash drive (NOKIA 5510) not working anymore in Linux 2.6
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004, Greg KH wrote:
> Should be fixed now in the latest -bk tree.  Can you verify this?
Problem is still present. (pulled today from
bk://kernel.bkbits.net/gregkh/linux/usb-2.6)

Here is my latest syslog:
Apr 30 19:59:16 mobilin kernel: usb 1-1: new full speed USB device using address
3
Apr 30 19:59:17 mobilin kernel: SCSI subsystem initialized
Apr 30 19:59:17 mobilin kernel: Initializing USB Mass Storage driver...
Apr 30 19:59:17 mobilin kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Apr 30 19:59:17 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 30 19:59:17 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 30 19:59:17 mobilin usb.agent[2852]:      usb-storage: loaded sucessfully
Apr 30 19:59:17 mobilin kernel: USB Mass Storage device found at 3
Apr 30 19:59:17 mobilin kernel: usbcore: registered new driver usb-storage
Apr 30 19:59:17 mobilin kernel: USB Mass Storage support registered.
Apr 30 19:59:18 mobilin scsi.agent[2886]: disk at
/devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0/host0/0:0:0:0
Apr 30 19:59:18 mobilin kernel: SCSI device sda: 124896 512-byte hdwr sectors
(64 MB)
Apr 30 19:59:18 mobilin kernel: sda: assuming Write Enabled
Apr 30 19:59:18 mobilin kernel: sda: assuming drive cache: write through
Apr 30 19:59:18 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 19:59:18 mobilin kernel:  sda: sda1
Apr 30 19:59:18 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 19:59:18 mobilin kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Apr 30 19:59:18 mobilin udev[2928]: creating device node '/dev/sda'
Apr 30 19:59:18 mobilin udev[2929]: creating device node '/dev/sda1'
Apr 30 19:59:23 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 19:59:23 mobilin last message repeated 2 times
Apr 30 20:00:04 mobilin kernel: usb 1-1: USB disconnect, address 3
Apr 30 20:00:04 mobilin udev[2992]: removing device node '/dev/sda1'
Apr 30 20:00:04 mobilin udev[3000]: removing device node '/dev/sda'
Apr 30 20:00:58 mobilin kernel: scsi0 (0:0): rejecting I/O to dead device
Apr 30 20:00:58 mobilin kernel: SCSI error: host 0 id 0 lun 0 return code =
4000000
Apr 30 20:00:58 mobilin kernel: ^ISense class 0, sense error 0, extended sense 0
Apr 30 20:01:06 mobilin kernel: usb 1-1: new full speed USB device using address
4
Apr 30 20:01:07 mobilin kernel: scsi1 : SCSI emulation for USB Mass Storage
devices
Apr 30 20:01:07 mobilin usb.agent[3064]:      usb-storage: already loaded
Apr 30 20:01:07 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 30 20:01:07 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 30 20:01:07 mobilin kernel: SCSI device sda: 124896 512-byte hdwr sectors
(64 MB)
Apr 30 20:01:07 mobilin kernel: sda: assuming Write Enabled
Apr 30 20:01:07 mobilin kernel: sda: assuming drive cache: write through
Apr 30 20:01:07 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 20:01:07 mobilin kernel:  sda: sda1
Apr 30 20:01:07 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 20:01:07 mobilin kernel: Attached scsi removable disk sda at scsi1,
channel 0, id 0, lun 0
Apr 30 20:01:07 mobilin kernel: USB Mass Storage device found at 4
Apr 30 20:01:08 mobilin scsi.agent[3102]: disk at
/devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0/host1/1:0:0:0
Apr 30 20:01:08 mobilin udev[3138]: creating device node '/dev/sda'
Apr 30 20:01:08 mobilin udev[3139]: creating device node '/dev/sda1'
Apr 30 20:01:16 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 20:01:35 mobilin last message repeated 6 times
Apr 30 20:09:05 mobilin kernel: usb 1-1: USB disconnect, address 4
Apr 30 20:09:05 mobilin kernel: drivers/usb/core/hub.c: USB device not accepting
new address (error=-90)
Apr 30 20:09:05 mobilin kernel: scsi: Device offlined - not ready after error
recovery: host 1 channel 0 id 0 lun 0
Apr 30 20:09:05 mobilin kernel: SCSI error : <1 0 0 0> return code = 0x50000
Apr 30 20:09:05 mobilin kernel: end_request: I/O error, dev sda, sector 575
Apr 30 20:09:05 mobilin kernel: Buffer I/O error on device sda1, logical block
544
Apr 30 20:09:05 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:05 mobilin kernel: scsi1 (0:0): rejecting I/O to offline device
Apr 30 20:09:05 mobilin kernel: Buffer I/O error on device sda1, logical block
545
Apr 30 20:09:05 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:05 mobilin kernel: Buffer I/O error on device sda1, logical block
546
Apr 30 20:09:05 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:05 mobilin kernel: Buffer I/O error on device sda1, logical block
547
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: Buffer I/O error on device sda1, logical block
548
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: Buffer I/O error on device sda1, logical block
549
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: Buffer I/O error on device sda1, logical block
550
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: Buffer I/O error on device sda1, logical block
551
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: Buffer I/O error on device sda1, logical block
552
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: Buffer I/O error on device sda1, logical block
553
Apr 30 20:09:06 mobilin kernel: lost page write due to I/O error on sda1
Apr 30 20:09:06 mobilin kernel: scsi1 (0:0): rejecting I/O to offline device
Apr 30 20:09:06 mobilin last message repeated 53 times
Apr 30 20:09:06 mobilin kernel: sd 1:0:0:0: Illegal state transition
offline->cancel
Apr 30 20:09:06 mobilin kernel: Badness in scsi_device_set_state at
drivers/scsi/scsi_lib.c:1640
Apr 30 20:09:06 mobilin kernel: Call Trace:
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1086822/1296361]
scsi_device_set_state+0xbe/0x110 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1067514/1296361]
scsi_device_cancel+0x22/0x118 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1067832/1296361]
scsi_device_cancel_cb+0x0/0x10 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [device_for_each_child+55/96]
device_for_each_child+0x37/0x60
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1067886/1296361]
scsi_host_cancel+0x26/0xa0 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+666912/1296361]
usb_buffer_free+0x48/0x50 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1068018/1296361]
scsi_remove_host+0xa/0x40 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1193857/1296361]
storage_disconnect+0x29/0x31 [usb_storage]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+663004/1296361]
usb_unbind_interface+0x64/0x70 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [device_release_driver+86/96]
device_release_driver+0x56/0x60
Apr 30 20:09:06 mobilin kernel:  [bus_remove_device+74/144]
bus_remove_device+0x4a/0x90
Apr 30 20:09:06 mobilin kernel:  [device_del+90/160] device_del+0x5a/0xa0
Apr 30 20:09:06 mobilin kernel:  [device_unregister+8/16]
device_unregister+0x8/0x10
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+687783/1296361]
usb_disable_device+0x5f/0xb0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+665815/1296361]
usb_disconnect+0x8f/0xe0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+674885/1296361]
hub_port_connect_change+0x23d/0x270 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+671986/1296361]
hub_port_status+0x3a/0xb0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [schedule+804/1456] schedule+0x324/0x5b0
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+675581/1296361]
hub_events+0x285/0x300 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+675757/1296361]
hub_thread+0x35/0xf0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [default_wake_function+0/16]
default_wake_function+0x0/0x10
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+675704/1296361]
hub_thread+0x0/0xf0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Apr 30 20:09:06 mobilin kernel: 
Apr 30 20:09:06 mobilin kernel: sd 1:0:0:0: Illegal state transition
offline->cancel
Apr 30 20:09:06 mobilin kernel: Badness in scsi_device_set_state at
drivers/scsi/scsi_lib.c:1640
Apr 30 20:09:06 mobilin kernel: Call Trace:
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1086822/1296361]
scsi_device_set_state+0xbe/0x110 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1094126/1296361]
scsi_remove_device+0x16/0xa0 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1091499/1296361]
scsi_forget_host+0x43/0x80 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1068032/1296361]
scsi_remove_host+0x18/0x40 [scsi_mod]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+1193857/1296361]
storage_disconnect+0x29/0x31 [usb_storage]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+663004/1296361]
usb_unbind_interface+0x64/0x70 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [device_release_driver+86/96]
device_release_driver+0x56/0x60
Apr 30 20:09:06 mobilin kernel:  [bus_remove_device+74/144]
bus_remove_device+0x4a/0x90
Apr 30 20:09:06 mobilin kernel:  [device_del+90/160] device_del+0x5a/0xa0
Apr 30 20:09:06 mobilin kernel:  [device_unregister+8/16]
device_unregister+0x8/0x10
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+687783/1296361]
usb_disable_device+0x5f/0xb0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+665815/1296361]
usb_disconnect+0x8f/0xe0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+674885/1296361]
hub_port_connect_change+0x23d/0x270 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+671986/1296361]
hub_port_status+0x3a/0xb0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [schedule+804/1456] schedule+0x324/0x5b0
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+675581/1296361]
hub_events+0x285/0x300 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+675757/1296361]
hub_thread+0x35/0xf0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [default_wake_function+0/16]
default_wake_function+0x0/0x10
Apr 30 20:09:06 mobilin kernel:  [__crc_probe_hwif_init+675704/1296361]
hub_thread+0x0/0xf0 [usbcore]
Apr 30 20:09:06 mobilin kernel:  [kernel_thread_helper+5/24]
kernel_thread_helper+0x5/0x18
Apr 30 20:09:06 mobilin kernel: 
Apr 30 20:09:06 mobilin kernel: scsi1 (0:0): rejecting I/O to offline device
Apr 30 20:09:06 mobilin last message repeated 2 times
Apr 30 20:09:06 mobilin kernel: usb 1-1: new full speed USB device using address
5
Apr 30 20:09:06 mobilin kernel: scsi2 : SCSI emulation for USB Mass Storage
devices
Apr 30 20:09:06 mobilin usb.agent[3293]:      usb-storage: already loaded
Apr 30 20:09:07 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 30 20:09:07 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 30 20:09:07 mobilin kernel: SCSI device sdb: 124896 512-byte hdwr sectors
(64 MB)
Apr 30 20:09:07 mobilin kernel: sdb: assuming Write Enabled
Apr 30 20:09:07 mobilin kernel: sdb: assuming drive cache: write through
Apr 30 20:09:07 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 20:09:07 mobilin kernel:  sdb: sdb1
Apr 30 20:09:07 mobilin kernel: Device not ready.  Make sure there is a disc in
the drive.
Apr 30 20:09:07 mobilin kernel: Attached scsi removable disk sdb at scsi2,
channel 0, id 0, lun 0
Apr 30 20:09:07 mobilin kernel: USB Mass Storage device found at 5
Apr 30 20:09:08 mobilin scsi.agent[3331]: disk at
/devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0/host2/2:0:0:0
Apr 30 20:09:08 mobilin udev[3367]: creating device node '/dev/sdb'
Apr 30 20:09:08 mobilin udev[3368]: creating device node '/dev/sdb1'

Regards
Andreas
_____________________________________________________________________
Der WEB.DE Virenschutz schuetzt Ihr Postfach vor dem Wurm Netsky.A-P!
Kostenfrei fuer alle FreeMail Nutzer. http://f.web.de/?mc=021157

