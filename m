Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262155AbSI1Qee>; Sat, 28 Sep 2002 12:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262157AbSI1Qee>; Sat, 28 Sep 2002 12:34:34 -0400
Received: from ulima.unil.ch ([130.223.144.143]:43988 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262155AbSI1Qed>;
	Sat, 28 Sep 2002 12:34:33 -0400
Date: Sat, 28 Sep 2002 18:39:53 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: usb-datafab not working?
Message-ID: <20020928163953.GA29803@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have tried with 2.5.39 and 2.4.20-pre7-ac3 and no success... With
2.4.20-pre7-ac3:

usb-uhci.c: $Revision: 1.275 $ time 18:56:01 Sep 21 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 16
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
PCI: Setting latency timer of device 00:1d.7 to 64
hcd.c: ehci-hcd @ 00:1d.7, Intel Corp. 82801DB USB EHCI Controller
hcd.c: irq 23, pci mem e3a49c00
usb.c: new USB bus registered, assigned bus number 3
hcd.c: remove: 00:1d.7, state 0
usb.c: USB bus 3 deregistered
usbdevfs: remount parameter error
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
hub.c: new USB device 00:1d.0-2, assigned address 2
scsi2 : SCSI emulation for USB Mass Storage devices
usb-uhci.c: interrupt, status 2, frame# 588
  Vendor:           Model:                   Rev:     
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sdc at scsi2, channel 0, id 0, lun 0
SCSI device sdc: 125185 512-byte hdwr sectors (64 MB)
sdc: Write Protect is off
 /dev/scsi/host2/bus0/target0/lun0: p1
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
SCSI error: host 2 id 0 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 0
VFS: Disk change detected on device 08:20
SCSI device sdc: 125185 512-byte hdwr sectors (64 MB)
sdc: Write Protect is off
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
SCSI error: host 2 id 0 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 0
VFS: Disk change detected on device 08:20
SCSI device sdc: 125185 512-byte hdwr sectors (64 MB)
sdc: Write Protect is off
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
SCSI error: host 2 id 0 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 0
VFS: Disk change detected on device 08:20
SCSI device sdc: 125185 512-byte hdwr sectors (64 MB)
sdc: Write Protect is off
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0
SCSI error: host 2 id 0 lun 0 return code = 8000002
        Sense class 7, sense error 0, extended sense 0
VFS: Disk change detected on device 08:20
SCSI device sdc: 125185 512-byte hdwr sectors (64 MB)
sdc: Write Protect is off
 /dev/scsi/host2/bus0/target0/lun0: I/O error: dev 08:20, sector 0
 I/O error: dev 08:20, sector 0

>From lsmod:

usb-storage            29424   0
usb-uhci               23052   0 (unused)

>From lspci -v:

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at dc00 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if 20 [EHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3981
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at dfffbc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: <available only to root>

I got a datafab usb compact flash reader that works pretty well from an
iMac under OSX and on the same machine under W98...

Is there something I should try?

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
