Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTEZSCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTEZSCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:02:36 -0400
Received: from pointblue.com.pl ([62.89.73.6]:28178 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262028AbTEZSB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:01:58 -0400
Subject: 2.5.69-bk13 USB storage ,few errors
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053972173.1968.18.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 19:02:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dmesg log:
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4
uhci-hcd 00:07.2: irq 9, io base 00001060
Please use the 'usbfs' filetype instead, the 'usbdevfs' name is
deprecated.
uhci-hcd 00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 2
usb-storage: act_altsetting is 0
usb-storage: id_index calculated to be: 34
usb-storage: Array length appears to be: 108
usb-storage: Vendor: Sony
usb-storage: Product: Memorystick MSC-U01N
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xc5ce6dc0 Out: 0xc5ce6dd4 Int: 0xc5ce6de8
(Period 255)
usb-storage: Transport: Control/Bulk
usb-storage: Protocol: Uniform Floppy Interface (UFI)
usb-storage: Allocating usb_ctrlrequest
usb-storage: Allocating URB
usb-storage: Allocating scatter-gather request block
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: usb_stor_ctrl_transfer(): rq=00 rqtype=21 value=0000
index=00 len=12
usb-storage: Status code 0; transferred 12/12
usb-storage: -- transfer complete
usb-storage: Call to usb_stor_ctrl_transfer() returned 0
usb-storage: usb_stor_bulk_transfer_buf(): xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: CB data stage result is 0x0
usb-storage: -- CB transport device requiring auto-sense
usb-storage: ** no auto-sense for a special command
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 Vendor: Sony      Model: MSC-U01N          Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad LUN (0:1)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: queuecommand() called
usb-storage: *** thread sleeping.
usb-storage: *** thread awakened.
usb-storage: Bad target number (5/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7/0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
Disabled Privacy Extensions on device c0609560(lo)


lsusb:
nalesnik:~/Projects# lsusb -vvv

Bus 001 Device 002: ID 054c:0032 Sony Corp. MemoryStick MSC-U01 Reader
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x054c Sony Corp.
  idProduct          0x0032 MemoryStick MSC-U01 Reader
  bcdDevice            1.31
  iManufacturer           1 Sony
  iProduct                2 USB Memory Stick Slot
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      4 Floppy (UFI)
      bInterfaceProtocol      0 Control/Bulk/Interrupt
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
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000
  idProduct          0x0000
  bcdDevice            2.05
  iManufacturer           3 Linux 2.5.69-bk19 uhci-hcd
  iProduct                2 Intel Corp. 82371AB/EB/MB PIIX4
  iSerial                 1 00:07.2
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
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

this is sony vaio pcg-c1ve notebook
USB storage on 2.4.21-rc3 does not say anything in dmesg, and works just
perfect.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

