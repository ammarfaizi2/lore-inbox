Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275247AbTHGIva (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 04:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275248AbTHGIva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 04:51:30 -0400
Received: from quark.net4u.it ([80.83.195.3]:1719 "HELO quark.net4u.it")
	by vger.kernel.org with SMTP id S275247AbTHGIvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 04:51:17 -0400
From: Alessandro Fiorino <fiorino@chibacity.it>
To: linux-kernel@vger.kernel.org
Subject: USB Mass storage problem in 2.6
Date: Thu, 7 Aug 2003 10:51:14 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CMhM/9LJGx8RQPA"
Message-Id: <200308071051.14700.fiorino@chibacity.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_CMhM/9LJGx8RQPA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I installed the 2.6 kernel to test it and I have some problems with the USB 
mass storage driver: my external HD enclousure doesn't work anymore (the 
device works perfectly with the 2.4.21 version).
My computer is an Acer TravelMate 521TE with an ALI USB 1.1 controller, the 
device is an USB2  2.5" HD enclousure.
When I plug it the kernel detects it, but it gives a lots of errors and I 
can't access the drive content.
I've tested it with the 2.6.0-test2 kernel version, attached there are the 
lsusb output (from 2.4.21) for the device and the kernel log (compiled with 
usb mass storage debug enabled).
I'm not subscribed to the list, please CC me any answer/comment.
Thank you in advance.
Alessandro Fiorino

Bus 001 Device 002: ID 05e3:0702 Genesys Logic, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0702
  bcdDevice            0.02
  iManufacturer           0
  iProduct                1 USB TO IDE
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           33
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xc0
      Self Powered
    MaxPower               96mA
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
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  junk at config descriptor end: 04
  Language IDs: (length=4)
     0409 English(US)


--Boundary-00=_CMhM/9LJGx8RQPA
Content-Type: text/x-log;
  charset="us-ascii";
  name="usb.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="usb.log"

drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:14.0: ALi Corporation USB 1.1 Controller
ohci-hcd 0000:00:14.0: irq 11, pci mem cc824000
ohci-hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 2
Initializing USB Mass Storage driver...
usb-storage: USB Mass Storage device detected
usb-storage: act_altsetting is 0, id_index is 96
usb-storage: -- associate_dev
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: Endpoints: In: 0xc8a492e0 Out: 0xc8a492f4 Int: 0x00000000 (Period 0)
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: *** thread sleeping.
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk command S 0x43425355 T 0x3 Trg 0 LUN 0 L 36 F 128 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x3 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 25 00
usb-storage: Bulk command S 0x43425355 T 0x4 Trg 0 LUN 0 L 37 F 128 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 37 bytes
usb-storage: Status code 0; transferred 36/37
usb-storage: -- short transfer
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x4 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: IBM-DARA  Model: -206000           Rev: 0811
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0x5 Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x5 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage:  25 00 00 00 00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0x6 Trg 0 LUN 0 L 8 F 128 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x6 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sda: 11733120 512-byte hdwr sectors (6007 MB)
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE_10 (10 bytes)
usb-storage:  5a 00 08 00 00 00 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0x7 Trg 0 LUN 0 L 8 F 128 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x7 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE_10 (10 bytes)
usb-storage:  5a 00 08 00 00 00 00 00 80 00
usb-storage: Bulk command S 0x43425355 T 0x8 Trg 0 LUN 0 L 128 F 128 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 128 bytes
usb-storage: Status code -75; transferred 64/128
usb-storage: -- babble
usb-storage: Bulk data transfer result 0x3
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 0/13
usb-storage: -- short transfer
usb-storage: Bulk status result = 1
usb-storage: -- transport indicates error, resetting
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Soft reset: clearing bulk-in endpoint halt
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=81 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Soft reset: clearing bulk-out endpoint halt
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=02 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Soft reset done
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command MODE_SENSE_10 (10 bytes)
usb-storage:  5a 00 08 00 00 00 00 00 80 00
usb-storage: Bulk command S 0x43425355 T 0x9 Trg 0 LUN 0 L 128 F 128 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 128 bytes
usb-storage: Status code -75; transferred 64/128
usb-storage: -- babble
usb-storage: Bulk data transfer result 0x3
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x9 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
sda: cache data unavailable
sda: assuming drive cache: write through
 sda:<7>usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 00 00 00 00 00 08 00
usb-storage: Bulk command S 0x43425355 T 0xa Trg 0 LUN 0 L 4096 F 128 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code -75; transferred 128/4096
usb-storage: -- babble
usb-storage: Bulk data transfer result 0x3
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 4
usb-storage: -- command was aborted
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Timeout -- cancelling URB
usb-storage: Soft reset failed: -104
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk command S 0x43425355 T 0xa Trg 0 LUN 0 L 0 F 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: command_abort called
usb-storage: usb_stor_stop_transport called
usb-storage: -- cancelling URB
usb-storage: Status code -104; transferred 0/13
usb-storage: -- transfer cancelled
usb-storage: Bulk status result = 4
usb-storage: -- command was aborted
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Timeout -- cancelling URB
usb-storage: Soft reset failed: -104
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: device_reset called
usb-storage: usb_stor_Bulk_reset called
usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
usb-storage: Timeout -- cancelling URB
usb-storage: Soft reset failed: -104
usb-storage: bus_reset called

--Boundary-00=_CMhM/9LJGx8RQPA--

