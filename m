Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277472AbRJJWCZ>; Wed, 10 Oct 2001 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277440AbRJJWCP>; Wed, 10 Oct 2001 18:02:15 -0400
Received: from tunnel-46-36.vpn.uib.no ([129.177.46.36]:10880 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S277435AbRJJWCB>; Wed, 10 Oct 2001 18:02:01 -0400
Message-ID: <3BC4C6A8.5020209@fi.uib.no>
Date: Thu, 11 Oct 2001 00:07:36 +0200
From: Igor Bukanov <boukanov@fi.uib.no>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.11 : long delay in USB during boot
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I updated my Dell Inspiron 7500 notebook (Celeron 466/512 MB) to 2.4.11 
and during boot got the following:

uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Found IRQ 5 for device 00:07.2
PCI: Sharing IRQ 5 with 00:08.0
uhci.c: USB UHCI at I/O 0x1060, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
usb: raced timeout, pipe 0x80000000 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
hub.c: USB hub found
usb: raced timeout, pipe 0x80000180 status 0 time left 0
hub.c: 2 ports detected
usb: raced timeout, pipe 0x80000180 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0
usb: raced timeout, pipe 0x80000100 status 0 time left 0

It took about 8s to proceed farther. Are these messages/very long delay 
normal? I did not get them prior 2.4.11.

Here are uncommented lines with USB substring from my .config"

CONFIG_INPUT_IFORCE_USB=m
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_UHCI_ALT=y
CONFIG_USB_BLUETOOTH=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_OMNINET=m

Regards, Igor


