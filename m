Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTHWSoI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 14:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTHWRAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 13:00:08 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:25574 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S263416AbTHWQVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 12:21:51 -0400
Date: Sat, 23 Aug 2003 09:21:45 -0700
From: Scott Lampert <scott@lampert.org>
To: linux-kernel@vger.kernel.org
Subject: USB 2.0 and USB Sony DRU-500A unreliable
Message-ID: <20030823162145.GA5229@cobalt.heavymetal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://www.lampert.org/public_key.asc
User-Agent: Mutt/1.5.4i
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [4.35.154.241] at Sat, 23 Aug 2003 11:21:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have problems getting my Sony DRU-500A on an external USB 2.0 enclosure
working reliably with my IOGear USB 2.0 card on any of the late
2.5.x/2.6.0-test kernels. The enclosure is a generic "Made in China"
brand (PPA, Inc?).  The drive seems to read data fine for a little while
and then just "shuts down" and stops reading, irregardless of what kind
of media I have in it. This same configuration (exact same hardware)
works fine under Windows. :(

Attached is all the data about the various components I thought might be
useful and the output of UMass debug right when it starts to fail.  If
there is some more data needed, or I'm sending to the wrong list, or
ideas for things to try please let me know.
	-Scott

-- 
Scott Lampert
<scott@lampert.org>
"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
-Benjamin Franklin, 1759

Public Key: http://www.lampert.org/pubkey/




kernel log:

Aug 23 08:59:05 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 131072/131072
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 08:59:05 [kernel] usb-storage: queuecommand called
Aug 23 08:59:05 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 131072/131072
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 08:59:05 [kernel] usb-storage: queuecommand called
Aug 23 08:59:05 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:05 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:05 [kernel] usb-storage: Status code -71; transferred 116736/131072
Aug 23 08:59:11 [kernel] usb-storage: Soft reset: clearing bulk-in endpoint halt
Aug 23 08:59:11 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:11 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:11 [kernel] usb-storage: queuecommand called
Aug 23 08:59:11 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:11 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:11 [kernel] usb-storage: Status code -32; transferred 0/131072
Aug 23 08:59:11 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:11 [kernel] usb-storage: Status code -75; transferred 0/13
Aug 23 08:59:17 [kernel] usb-storage: Soft reset: clearing bulk-in endpoint halt
Aug 23 08:59:17 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:17 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:17 [kernel] usb-storage: queuecommand called
Aug 23 08:59:17 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:17 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:17 [kernel] usb-storage: Status code 0; transferred 131072/131072
Aug 23 08:59:17 [kernel] usb-storage: Status code -75; transferred 0/13
Aug 23 08:59:23 [kernel] usb-storage: Soft reset: clearing bulk-in endpoint halt
Aug 23 08:59:23 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:23 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:23 [kernel] SCSI error : <1 0 0 0> return code = 0x70000
Aug 23 08:59:23 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:23 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:23 [kernel] usb-storage: Status code -32; transferred 0/129024
Aug 23 08:59:23 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:23 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 08:59:29 [kernel] usb-storage: Soft reset: clearing bulk-in endpoint halt
Aug 23 08:59:29 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:29 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:29 [kernel] SCSI error : <1 0 0 0> return code = 0x70000
Aug 23 08:59:29 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:29 [kernel] usb-storage: Status code -32; transferred 0/31
Aug 23 08:59:29 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:35 [kernel] usb-storage: Soft reset: clearing bulk-in endpoint halt
Aug 23 08:59:35 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:35 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:35 [kernel] SCSI error : <1 0 0 0> return code = 0x70000
Aug 23 08:59:35 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:35 [kernel] usb-storage: Status code -32; transferred 0/4096
Aug 23 08:59:35 [kernel] usb-storage: usb_stor_clear_halt: result = 0
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 18/18
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 08:59:35 [kernel] end_request: I/O error, dev sr1, sector 59800
Aug 23 08:59:35 [kernel] usb-storage: *** thread awakened.
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 124928/124928
Aug 23 08:59:35 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 20679
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 20679
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 45289
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 45289
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 53963
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 53963
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54057
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54057
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54060
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54060
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54061
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54061
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54132
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 54132
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68458
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68458
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68459
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68459
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68526
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68526
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68527
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68527
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68537
Aug 23 08:59:36 [kernel] Buffer I/O error on device sr1, logical block 68537
Aug 23 09:00:46 [kernel] usb-storage: queuecommand called
Aug 23 09:00:46 [kernel] usb-storage: *** thread awakened.
Aug 23 09:00:46 [kernel] usb-storage: Status code 0; transferred 31/31
Aug 23 09:00:46 [kernel] usb-storage: Status code 0; transferred 13/13
Aug 23 09:02:08 [kernel] usbfs: process 5350 (lsusb) did not claim interface 0 b
efore use
Aug 23 09:02:08 [kernel] usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 4 rqt 128 
rq 6 len 256 ret -32
Aug 23 09:02:08 [kernel] usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 4 rqt 128 
rq 6 len 256 ret -32
Aug 23 09:02:09 [kernel] usbfs: process 5350 (lsusb) did not claim interface 0 b
efore use
Aug 23 09:02:09 [kernel] usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 
rq 6 len 256 ret -32
Aug 23 09:02:09 [kernel] usbfs: USBDEVFS_CONTROL failed cmd lsusb dev 2 rqt 128 
rq 6 len 256 ret -32

lsusb:

Bus 001 Device 002: ID 0402:5621 ALi Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0402 ALi Corp.
  idProduct          0x5621 
  bcdDevice            1.03
  iManufacturer           0 
  iProduct                1 USB 2.0 Storage Device
  iSerial                 2 00042222200000019862
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
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
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         1 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0-test3 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:02:0d.3
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval              12
  Language IDs: (length=4)
     0409 English(US)


lspci:

02:0d.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: Acer Laboratories Inc. [ALi] USB 1.1 Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
        Memory at eb000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2

02:0d.3 USB Controller: Acer Laboratories Inc. [ALi] USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Acer Laboratories Inc. [ALi] USB 2.0 Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 9
        Memory at ea800000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2090]


/proc/scsi/usb-storage/1:

   Host scsi1: usb-storage
       Vendor: Unknown
      Product: USB 2.0 Storage Device
Serial Number: 00042222200000019862
     Protocol: Transparent SCSI
    Transport: Bulk
       Quirks:


/proc/scsi/sci:

Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: DVD RW DRU-500A  Rev: 1.0g
  Type:   CD-ROM                           ANSI SCSI revision: 02
