Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135944AbREJAwY>; Wed, 9 May 2001 20:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbREJAwP>; Wed, 9 May 2001 20:52:15 -0400
Received: from melchi.fuller.edu ([206.2.38.3]:20752 "EHLO melchi.fuller.edu")
	by vger.kernel.org with ESMTP id <S135944AbREJAwF>;
	Wed, 9 May 2001 20:52:05 -0400
Date: Wed, 9 May 2001 17:52:04 -0700 (PDT)
From: <clameter@lameter.com>
To: linux-kernel@vger.kernel.org
Subject: USB broken in 2.4.4? Serial Ricochet works, USB performance sucks.
Message-ID: <Pine.LNX.4.10.10105091739490.22715-100000@melchi.fuller.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got a ricochet 128k GS wireless modem and I am running it with
kernel 2.4.4 and ppp 2.4.1.

Using the USB connection (configured to operatate at 460kbit)  I get up to
2kbyte per second. With serial(at 115kbit) this goes up to 8kbyte per
second.

Why is this?

(Note to all prospective Ricochet/Earthlink buyers: Beware. It takes 10-20
successful connects before you can establish a connection that lets data
through. Tested on multiple OSe and my ricochet repeater is across the
street on a lamp).

May  9 10:42:55 piii syslogd 1.4.1#2: restart.
May  9 10:42:55 piii kernel: klogd 1.4.1#2, log source = /proc/kmsg started.
May  9 10:42:55 piii kernel: Inspecting /boot/System.map-2.4.4-ac4
May  9 10:42:55 piii kernel: Loaded 14111 symbols from /boot/System.map-2.4.4-ac4.
May  9 10:42:55 piii kernel: Symbols match kernel version 2.4.4.
May  9 10:42:55 piii kernel: Loaded 122 symbols from 8 modules.
May  9 10:42:55 piii kernel: port... done.
May  9 10:42:55 piii kernel: Checking 'hlt' instruction... OK.

May  9 10:42:55 piii kernel: Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
May  9 10:42:55 piii kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A

May  9 10:42:55 piii kernel: usb.c: registered new driver usbdevfs
May  9 10:42:55 piii kernel: usb.c: registered new driver hub
May  9 10:42:55 piii kernel: usb-ohci.c: USB OHCI at membase 0xd004a000, IRQ 3
May  9 10:42:55 piii kernel: usb-ohci.c: usb-00:01.2, Silicon Integrated  Systems [SiS] 7001
May  9 10:42:55 piii kernel: usb.c: new USB bus registered, assigned bus number 1
May  9 10:42:55 piii kernel: Product: USB OHCI Root Hub
May  9 10:42:55 piii kernel: SerialNumber: d004a000
May  9 10:42:55 piii kernel: hub.c: USB hub found
May  9 10:42:55 piii kernel: hub.c: 2 ports detected
May  9 10:42:55 piii kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
May  9 10:42:55 piii kernel: Manufacturer: Metricom, Inc.
May  9 10:42:55 piii kernel: Product: Metricom GS Modem
May  9 10:42:55 piii kernel: SerialNumber: SN00a079038f68
May  9 10:42:55 piii kernel: usb.c: USB device 2 (vend/prod 0x870/0x1) is not claimed by any active driver.

May  9 10:42:55 piii kernel: usb-uhci.c: $Revision: 1.259 $ time 12:14:15 May  4 2001
May  9 10:42:55 piii kernel: usb-uhci.c: High bandwidth mode enabled
May  9 10:42:55 piii kernel: usb.c: registered new driver acm
May  9 10:42:55 piii kernel: ttyACM0: USB ACM device
May  9 10:42:55 piii kernel: CDCEther.c: CDCEther.c: v0.98.2 28 March 2001 Brad Hards and another
May  9 10:42:55 piii kernel: usb.c: registered new driver CDCEther

May  9 17:39:29 piii pppd[4388]: pppd 2.4.1 started by root, uid 0
May  9 17:39:31 piii chat[4392]: abort on (BUSY)
May  9 17:39:31 piii chat[4392]: abort on (VOICE)
May  9 17:39:31 piii chat[4392]: abort on (NO DIALTONE)
May  9 17:39:31 piii chat[4392]: send (ATDT3333^M)
May  9 17:39:31 piii chat[4392]: expect (CONNECT)
May  9 17:39:31 piii chat[4392]: ATDT3333^M^M
May  9 17:39:31 piii chat[4392]: CONNECT
May  9 17:39:31 piii chat[4392]:  -- got it
May  9 17:39:31 piii pppd[4388]: Serial connection established.
May  9 17:39:31 piii pppd[4388]: Using interface ppp0
May  9 17:39:31 piii pppd[4388]: Connect: ppp0 <--> /dev/ttyS0
May  9 17:39:46 piii pppd[4388]: Remote message: CHAP authentication success, unit 713
May  9 17:39:47 piii pppd[4388]: local  IP address 63.13.222.189
May  9 17:39:47 piii pppd[4388]: remote IP address 63.13.222.1
May  9 17:39:47 piii pppd[4388]: primary   DNS address 198.6.1.195
May  9 17:39:47 piii pppd[4388]: secondary DNS address 198.6.1.5


