Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265565AbRFVXIY>; Fri, 22 Jun 2001 19:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265566AbRFVXIN>; Fri, 22 Jun 2001 19:08:13 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:49167 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S265565AbRFVXII>;
	Fri, 22 Jun 2001 19:08:08 -0400
Message-ID: <3B33CFE8.DB862308@bigfoot.com>
Date: Fri, 22 Jun 2001 17:08:24 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Still some problems with UHCI driver in 2.4.5 on VIA chipsets
In-Reply-To: <3B2D446A.5C2AEEAC@bigfoot.com> <20010617200855.R9465@sventech.com> <3B2FBF76.40993998@bigfoot.com> <20010622145553.W3715@sventech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:
> > I think this may be a problem in the dc2xx.o then, since uhci didn't reveal
> > any new messages.
> 
> It's possible. Many cameras are touchy wrt to the commands it receives.
> If one is slightly wrong, some of them will just stop talking.

Yeah, looks like I get to see if I can debug the camera driver..
 
> Did you try with the usb-uhci driver as well?
> 
> JE


Here's a transcript of a session with usb-uhci.o (vs uhci.o).  It locks in a
way that I can't turn off the camera (have to pop batteries), which is a bit
worse than just uhci.o.  On the plus side, it seemed a bit faster at a few
things.

usb.c: USB disconnect on device 1
usb.c: USB bus 1 deregistered
usb.c: USB disconnect on device 1
usb.c: USB bus 2 deregistered
usb-uhci.c: $Revision: 1.259 $ time 16:56:57 Jun 22 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:04.2
PCI: The same IRQ used for device 00:04.3
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:04.3
PCI: The same IRQ used for device 00:04.2
usb-uhci.c: USB UHCI at I/O 0xd000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer, Roman
Weissgaerber
usb-uhci.c: USB Universal Host Controller Interface driver
hub.c: USB new device connect on bus1/2, assigned device number 2
dc2xx.c: USB Camera #0 connected, major/minor 180/80
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb_control/bulk_msg: timeout
usb-uhci.c: interrupt, status 3, frame# 1004
usb.c: USB disconnect on device 2
usb-uhci.c: interrupt, status 3, frame# 1997
usb-uhci.c: interrupt, status 3, frame# 949
usb-uhci.c: interrupt, status 3, frame# 1949
usb-uhci.c: interrupt, status 3, frame# 901
usb-uhci.c: interrupt, status 3, frame# 1901
dc2xx.c: USB Camera #0 disconnected

--
    www.kuro5hin.org -- technology and culture, from the trenches.
