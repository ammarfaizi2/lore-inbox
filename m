Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263193AbRFRAJW>; Sun, 17 Jun 2001 20:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbRFRAJM>; Sun, 17 Jun 2001 20:09:12 -0400
Received: from quattro.sventech.com ([205.252.248.110]:7439 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S263193AbRFRAJB>; Sun, 17 Jun 2001 20:09:01 -0400
Date: Sun, 17 Jun 2001 20:08:56 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Dylan Griffiths <Dylan_G@bigfoot.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Still some problems with UHCI driver in 2.4.5 on VIA chipsets
Message-ID: <20010617200855.R9465@sventech.com>
In-Reply-To: <3B2D446A.5C2AEEAC@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3B2D446A.5C2AEEAC@bigfoot.com>; from Dylan_G@bigfoot.com on Sun, Jun 17, 2001 at 05:59:38PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2001, Dylan Griffiths <Dylan_G@bigfoot.com> wrote:
> dmesg log:
> usb.c: registered new driver dc2xx
> dc2xx.c: v1.0.0 David Brownell, <dbrownell@users.sourceforge.net>
> dc2xx.c: USB Camera Driver for Kodak DC-2xx series cameras
> PCI: Found IRQ 5 for device 00:04.2
> PCI: The same IRQ used for device 00:04.3
> uhci.c: USB UHCI at I/O 0xd400, IRQ 5
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> PCI: Found IRQ 5 for device 00:04.3
> PCI: The same IRQ used for device 00:04.2
> uhci.c: USB UHCI at I/O 0xd000, IRQ 5
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 2 ports detected
> uhci.c:  Linus Torvalds, Johannes Erdfelt, Randy Dunlap, Georg Acher, Deti
> Fliegl, Thomas Sailer, Roman Weissgaerber
> uhci.c: USB Universal Host Controller Interface driver
> hub.c: USB new device connect on bus1/2, assigned device number 2
> dc2xx.c: USB Camera #0 connected, major/minor 180/80
> ** here is where it froze **
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb.c: USB disconnect on device 2
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> usb_control/bulk_msg: timeout
> ** rmmod the drivers **
> dc2xx.c: USB Camera #0 disconnected
> usb.c: USB disconnect on device 1
> usb.c: USB bus 1 deregistered
> usb.c: USB disconnect on device 1
> usb.c: USB bus 2 deregistered
> usb.c: deregistering driver dc2xx
> ** usbcore refuses to rmmod because its ref cnt won't decrement, this also
> affected it before I had the usb_control/bulk_msg timeout/loop issues **

Could you load uhci with the debug=1 option?

JE

