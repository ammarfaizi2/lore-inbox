Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbQLaTbx>; Sun, 31 Dec 2000 14:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130642AbQLaTbn>; Sun, 31 Dec 2000 14:31:43 -0500
Received: from waste.org ([209.173.204.2]:33296 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130352AbQLaTbi>;
	Sun, 31 Dec 2000 14:31:38 -0500
Date: Sun, 31 Dec 2000 13:01:06 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
cc: <jerdfelt@valinux.com>, linux-kernel <linux-kernel@vger.kernel.org>,
        Linux USB Storage List <usb-storage@one-eyed-alien.net>
Subject: Re: [patchlet] enable HP 8200e USB CDRW
In-Reply-To: <20001231104358.B6652@one-eyed-alien.net>
Message-ID: <Pine.LNX.4.30.0012311255470.29214-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2000, Matthew Dharm wrote:

> Um, I'm not sure that this driver is even ready for the EXPERIMENTAL label.
> What does the driver's author say?

He was unresponsive to my message of about a month ago. Nonetheless, it
works for me - I've ripped about a hundred CDs and burned a few as well.
Considering that the rest of the code is already in the standard kernel
and appears to work, there's no reason not to make it available.

> On Sun, Dec 31, 2000 at 11:50:14AM -0600, Oliver Xymoron wrote:
> > This patchlet lets me use my HP CDRW.
> >
> > --- linux/drivers/usb/Config.in~	Mon Nov 27 20:10:35 2000
> > +++ linux/drivers/usb/Config.in	Tue Dec 19 12:21:56 2000
> > @@ -32,6 +32,9 @@
> >     if [ "$CONFIG_USB_STORAGE" != "n" ]; then
> >        bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
> >        bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM
> > +      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
> > +          bool '    HP8200e support (EXPERIMENTAL)' CONFIG_USB_STORAGE_HP8200e
> > +      fi
> >     fi
> >     dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
> >     dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
