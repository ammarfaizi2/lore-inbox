Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSEQWpK>; Fri, 17 May 2002 18:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316725AbSEQWpJ>; Fri, 17 May 2002 18:45:09 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:44300 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316705AbSEQWpI>;
	Fri, 17 May 2002 18:45:08 -0400
Date: Fri, 17 May 2002 15:44:55 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.15-gregkh-1  (USB stuff)
Message-ID: <20020517224455.GJ7711@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 19 Apr 2002 21:24:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a lot of different USB patches that have gone into my
tree since 2.5.15 came out, so here's a big patch with all of them for
people to play with, and resync against.  Of special note is that there
is now 4 different drivers for the UHCI controller, and I have disabled
support for the usb-ohci.o driver in the Config.in file (use ohci-hcd.o
instead.)

I will be removing 3 of the UHCI drivers soon, but will post more about
that later, after 2.5.16 appears (hopefully with all of these changes.)

It's available at:
    http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/linux-2.5.15-gregkh-1.patch.bz2

and the changelog is:

o USB-UHCI-HCD                                                   Georg Acher
o -- ehci misc FIXMEs                                         David Brownell
o -- hub/tt error recovery                                    David Brownell
o USB storage sync with cvs and -dj trees                            Greg KH
o USB storage fixups due to sync                                     Greg KH
o Change to the USB core to retry failed devices on startup.         Greg KH
o USB sddr55 minor to enable a MDSM-B reader                         Greg KH
o usb_submit_urb fix for broken usb devices                          Greg KH
o USB device reference counting api cleanup changes                  Greg KH
o USB Config.in and Makefile fixups                                  Greg KH
o USB - fix a compiler warning in the core code                      Greg KH
o USB - Host controller Config.in changes                            Greg KH
o uhci.c FSBR timeout                                       Johannes Erdfelt
o 2.4.19-pre8 uhci.c incorrect bit operations               Johannes Erdfelt
o USB device reference counting fix for uhci.c and usb core Johannes Erdfelt
o 2.4.19-pre8 uhci.c incorrect bit operations               Johannes Erdfelt
o uhci-hcd for 2.5.15                                       Johannes Erdfelt
o usb-storage locking fixes                                   Manfred Spraul

If anyone has any problems with this patch, please let me know.

thanks,

greg k-h
