Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRDPWnK>; Mon, 16 Apr 2001 18:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDPWm7>; Mon, 16 Apr 2001 18:42:59 -0400
Received: from ulima.unil.ch ([130.223.144.143]:26128 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id <S132385AbRDPWmv>;
	Mon, 16 Apr 2001 18:42:51 -0400
Date: Tue, 17 Apr 2001 00:42:48 +0200
From: FAVRE Gregoire <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: USB with 2.4.3-ac{1,3,7} without devfs
Message-ID: <20010417004248.A19914@ulima.unil.ch>
Mail-Followup-To: FAVRE Gregoire <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Under 2.4.3 I manage uploading photo from my Digital IXUS using USB_UHCI
with s10h, but under ac series, I don't manage, only other things I have
changed is removing devfs which I don't need in fact...

from dmesg (2.4.3):
...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 01:30:35 Mar 31 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 7 for device 00:04.2
PCI: The same IRQ used for device 00:06.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 7
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
...

And as I power on my camera:
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x4a9/0x3047) is not claimed by any
active driver.


from dmesg (2.4.3-ac7):
...
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 22:57:47 Apr 16 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 7 for device 00:04.2
PCI: The same IRQ used for device 00:06.0
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 7
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
...

And as I power on my camera:

hub.c: USB new device connect on bus1/1, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)

Do I need some special dev, here are those I have under /dev/usb:
dabusb0   dabusb3  dc2xx10  dc2xx5  lp12  lp7       mdc80014  mdc8009
scanner15  ttyUSB0   ttyUSB3
dabusb1   dabusb4  dc2xx11  dc2xx6  lp13  lp8       mdc80015  rio500
scanner2   ttyUSB1   ttyUSB4
dabusb10  dabusb5  dc2xx12  dc2xx7  lp14  lp9       mdc8002   scanner0
scanner3   ttyUSB10  ttyUSB5
dabusb11  dabusb6  dc2xx13  dc2xx8  lp15  mdc8000   mdc8003   scanner1
scanner4   ttyUSB11  ttyUSB6
dabusb12  dabusb7  dc2xx14  dc2xx9  lp2   mdc8001   mdc8004   scanner10
scanner5   ttyUSB12  ttyUSB7
dabusb13  dabusb8  dc2xx15  lp0     lp3   mdc80010  mdc8005   scanner11
scanner6   ttyUSB13  ttyUSB8
dabusb14  dabusb9  dc2xx2   lp1     lp4   mdc80011  mdc8006   scanner12
scanner7   ttyUSB14  ttyUSB9
dabusb15  dc2xx0   dc2xx3   lp10    lp5   mdc80012  mdc8007   scanner13
scanner8   ttyUSB15
dabusb2   dc2xx1   dc2xx4   lp11    lp6   mdc80013  mdc8008   scanner14
scanner9   ttyUSB2

I don't think, because under 2.4.3 with devfs, /dev/usb is empty...

Thanks you in advance for your help,

	Greg
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
