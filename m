Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272231AbTHDUTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 16:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272232AbTHDUTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 16:19:32 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:64687 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S272231AbTHDUSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 16:18:50 -0400
Date: Mon, 04 Aug 2003 13:22:20 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1041] New: oops in scsi_device_get after inserting a USB camera (usb-storage)2.6.0-test2
Message-ID: <435120000.1060028540@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1041

           Summary: oops in scsi_device_get after inserting a USB camera
                    (usb-storage)2.6.0-test2:
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: santamarta@gmx.net


Distribution: Debian sid
Hardware Environment: Athlon 900, 640M ram
Software Environment: kernel 2.6.0-test2
Problem Description:

After using sucessfully my aiptek dv3100 camera to transfer files to the
computer, umounting, disconnecting and reconnecting the camera results in oops.

Related dmesg as follows:

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: VIA Technologies, In USB
uhci-hcd 0000:00:07.2: irq 9, io base 0000b400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
uhci-hcd 0000:00:07.3: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:07.3: irq 9, io base 0000b800
uhci-hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
hub 1-2:0: USB hub found
hub 1-2:0: 4 ports detected
hub 1-2:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-2:0: new USB device on port 2, assigned address 4
Initializing USB Mass Storage driver...
hub 1-2:0: debounce: port 4: delay 100ms stable 4 status 0x301
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: DV 3100   Model:                   Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
hub 1-2:0: new USB device on port 4, assigned address 5
SCSI device sda: 30720 512-byte hdwr sectors (16 MB)
sda: Write Protect is off
sda: cache data unavailable
 /dev/scsi/host0/bus0/target0/lun0: p1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb 1-2.2: USB disconnect, address 4
hub 1-2:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-2:0: new USB device on port 2, assigned address 6
t[1930]: ... no modules for USB product 8ca/106/100
t[1955]: ... no modules for USB product 8ca/106/100
t[1934]: ... no modules for USB product 8ca/106/100
usbaudio: device 6 audiocontrol interface 2 has 1 input and 0 output
AudioStreaming interfaces
usbaudio: valid input sample rate 0
usbaudio: device 6 interface 3 altsetting 1: format 0x00000010 sratelo 0 sratehi
0 attributes 0x00usbaudio: valid input sample rate 0
usbaudio: device 6 interface 3 altsetting 2: format 0x00000010 sratelo 0 sratehi
0 attributes 0x00usbaudio: valid input sample rate 0
usbaudio: device 6 interface 3 altsetting 3: format 0x00000010 sratelo 0 sratehi
0 attributes 0x00usbaudio: valid input sample rate 0
usbaudio: device 6 interface 3 altsetting 4: format 0x00000010 sratelo 0 sratehi
0 attributes 0x00usbaudio: valid input sample rate 0
usbaudio: device 6 interface 3 altsetting 5: format 0x00000010 sratelo 0 sratehi
0 attributes 0x00usbaudio: valid input sample rate 0
usbaudio: device 6 interface 3 altsetting 6: format 0x00000010 sratelo 0 sratehi
0 attributes 0x00usbaudio: valid input sample rate 48000
usbaudio: device 6 interface 3 altsetting 7: format 0x00000010 sratelo 48000
sratehi 48000 attributes 0x00
usbaudio: registered dsp 14,35
usbaudio: no mixer controls found for Terminal 4
drivers/usb/core/usb.c: registered new driver audio
drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
usb 1-2.2: USB disconnect, address 6
usbaudio: unregister dsp 14,35
hub 1-2:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-2:0: new USB device on port 2, assigned address 7
scsi1 : SCSI emulation for USB Mass Storage devices
  Vendor: DV 3100   Model:                   Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi.agent[2194]: how to add device type= at
/devices/pci0000:00/0000:00:07.2/usb1/1-2/1-2.2/1-2.2:0/host1/1:0:0:0 ??

SCSI device sda: 30720 512-byte hdwr sectors (16 MB)
sda: Write Protect is off
sda: cache data unavailable
 printing eip:
c0362873
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[scsi_device_get+19/112]    Not tainted
EFLAGS: 00010296
EIP is at scsi_device_get+0x13/0x70
eax: e7c8f180   ebx: 2d646c2f   ecx: e6f82680   edx: c173dc14
esi: 00000001   edi: e72bc480   ebp: e6f82680   esp: c173daac
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 5, threadinfo=c173c000 task=e7f8e080)
Stack: c173c000 2d646c2f c036a5de 2d646c2f e1a75800 c173c000 c036a5b0 e72cc500 
       00000000 c015dabc e6f82680 c173dc14 dc7e5d0c 00000001 c173dafc e72cc518 
       db96ed80 00000000 e72cc500 00000001 c173dc14 e1a75800 c015db9d e72cc500 
Call Trace:
 [sd_open+46/240] sd_open+0x2e/0xf0
 [sd_open+0/240] sd_open+0x0/0xf0
 [do_open+908/1008] do_open+0x38c/0x3f0
 [blkdev_get+125/160] blkdev_get+0x7d/0xa0
 [register_disk+203/368] register_disk+0xcb/0x170
 [add_disk+78/96] add_disk+0x4e/0x60
 [exact_match+0/16] exact_match+0x0/0x10
 [exact_lock+0/32] exact_lock+0x0/0x20
 [sd_probe+437/656] sd_probe+0x1b5/0x290
 [sprintf+31/48] sprintf+0x1f/0x30
 [bus_match+69/128] bus_match+0x45/0x80
 [device_attach+67/128] device_attach+0x43/0x80
 [bus_add_device+100/176] bus_add_device+0x64/0xb0
 [device_add+205/256] device_add+0xcd/0x100
 [scsi_device_register+213/464] scsi_device_register+0xd5/0x1d0
 [_end+741544296/1067966808] slave_configure+0x0/0x10 [usb_storage]
 [scsi_add_lun+675/896] scsi_add_lun+0x2a3/0x380
 [scsi_probe_and_add_lun+158/272] scsi_probe_and_add_lun+0x9e/0x110
 [scsi_scan_target+80/208] scsi_scan_target+0x50/0xd0
 [scsi_scan_host+57/96] scsi_scan_host+0x39/0x60
 [_end+741555044/1067966808] storage_probe+0x13c/0x1d0 [usb_storage]
 [usb_device_probe+118/160] usb_device_probe+0x76/0xa0
 [bus_match+69/128] bus_match+0x45/0x80
 [device_attach+67/128] device_attach+0x43/0x80
 [bus_add_device+100/176] bus_add_device+0x64/0xb0
 [device_add+205/256] device_add+0xcd/0x100
 [scsi_device_register+213/464] scsi_device_register+0xd5/0x1d0
 [_end+741544296/1067966808] slave_configure+0x0/0x10 [usb_storage]
 [scsi_add_lun+675/896] scsi_add_lun+0x2a3/0x380
 [scsi_probe_and_add_lun+158/272] scsi_probe_and_add_lun+0x9e/0x110
 [scsi_scan_target+80/208] scsi_scan_target+0x50/0xd0
 [scsi_scan_host+57/96] scsi_scan_host+0x39/0x60
 [_end+741555044/1067966808] storage_probe+0x13c/0x1d0 [usb_storage]
 [usb_device_probe+118/160] usb_device_probe+0x76/0xa0
 [bus_match+69/128] bus_match+0x45/0x80
 [device_attach+67/128] device_attach+0x43/0x80
 [bus_add_device+100/176] bus_add_device+0x64/0xb0
 [device_add+205/256] device_add+0xcd/0x100
 [usb_new_device+980/1312] usb_new_device+0x3d4/0x520
 [hub_port_connect_change+436/800] hub_port_connect_change+0x1b4/0x320
 [hub_events+720/848] hub_events+0x2d0/0x350
 [hub_thread+45/240] hub_thread+0x2d/0xf0
 [ret_from_fork+6/20] ret_from_fork+0x6/0x14
 [default_wake_function+0/48] default_wake_function+0x0/0x30
 [hub_thread+0/240] hub_thread+0x0/0xf0
 [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10

Code: 8b 43 10 8b 40 44 8b 10 85 d2 74 2f b8 00 e0 ff ff 21 e0 ff 

Steps to reproduce:

Plug in said USB camera; mount sda1; umount sda1; either disconnect the camera,
eject the CF card or change the camera mode to webcam. Reconnect camera / CF
card or change the mode to 'disk'. Instant and repeatable oops.

