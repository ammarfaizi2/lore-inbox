Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030553AbVKPWwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030553AbVKPWwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbVKPWwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:52:42 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:14732 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1030553AbVKPWwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:52:41 -0500
Date: Wed, 16 Nov 2005 23:52:32 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: USB key generates ioctl_internal_command errors
Message-ID: <20051116225231.GA28302@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whenever I insert my Iomega Mini 1Gb USB key, I get a stream of 
ioctl_internal_command errors. The device works just fine (mounting, 
copying files, unmounting, etc), but the messages are annoying...

usb 1-4: new high speed USB device using ehci_hcd and address 4
scsi8 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
austin:/home/david# dmesg 
usb 1-4: new high speed USB device using ehci_hcd and address 4
scsi8 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
  Vendor: I0MEGA    Model: UMni1GB*IOM2K4    Rev: 1.01
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
ioctl_internal_command: <8 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
SCSI device sda: 2048000 512-byte hdwr sectors (1049 MB)
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi8, channel 0, id 0, lun 0
usb-storage: device scan complete
ioctl_internal_command: <8 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ioctl_internal_command: <8 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ioctl_internal_command: <8 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ioctl_internal_command: <8 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ioctl_internal_command: <8 0 0 0> return code = 8000002
   : Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
[...]

And this goes on and on...approx one message per second if hal is 
running, otherwise only the first two ioctl_internal_command messages 
are shown. I assume that hal is doing some kind of polling on the device 
which triggers the error message. What does the error mean and how do I 
fix it? I've seen some other posts on the list with similar error 
messages but found no answers...

//David

PS
Please CC me on any replies
