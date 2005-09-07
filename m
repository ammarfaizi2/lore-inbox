Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVIGXNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVIGXNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 19:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbVIGXNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 19:13:19 -0400
Received: from imap.gmx.net ([213.165.64.20]:17811 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932474AbVIGXNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 19:13:19 -0400
X-Authenticated: #26200865
Message-ID: <431F7432.2090004@gmx.net>
Date: Thu, 08 Sep 2005 01:13:54 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: scsi error "sense key: No Sense" with usb flash drive
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

upon insertion of my new 2048 MB usb flash drive, the kernel
(vanilla 2.6.13) spat out the following errors:

usb 4-2: new high speed USB device using ehci_hcd and address 7
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 7
usb-storage: waiting for device to settle before scanning
  Vendor: TinyDisk  Model: 2005-08-04        Rev: 0.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 4096000 512-byte hdwr sectors (2097 MB)
sda: Write Protect is on
sda: Mode Sense: 0b 00 80 00
sda: assuming drive cache: write through
ioctl_internal_command: <1 0 0 0> return code = 8000002
   : Current: sense key: No Sense
    Additional sense: No additional sense information
SCSI device sda: 4096000 512-byte hdwr sectors (2097 MB)
sda: Write Protect is on
sda: Mode Sense: 0b 00 80 00
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
ioctl_internal_command: <1 0 0 0> return code = 8000002
   : Current: sense key: No Sense
    Additional sense: No additional sense information
ioctl_internal_command: <1 0 0 0> return code = 8000002
   : Current: sense key: No Sense
    Additional sense: No additional sense information
ioctl_internal_command: <1 0 0 0> return code = 8000002
   : Current: sense key: No Sense
    Additional sense: No additional sense information
ioctl_internal_command: <1 0 0 0> return code = 8000002
   : Current: sense key: No Sense
    Additional sense: No additional sense information

This error only happens with this specific flash drive.
p35:~ # lsusb -v

Bus 004 Device 007: ID 0457:0151 Silicon Integrated Systems Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0457 Silicon Integrated Systems Corp.
  idProduct          0x0151
  bcdDevice            1.00
  iManufacturer           0
  iProduct                2 USB Mass Storage Device
  iSerial                 3 0000000000000F
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower               98mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  bytes 512 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  bytes 512 once
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  bytes 64 once
        bInterval               8


Is this just a quirky usb flash drive or do the errors indicate
a bigger problem?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
