Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTENQWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTENQWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:22:39 -0400
Received: from mbi-00.mbi.ufl.edu ([159.178.51.20]:60319 "EHLO mbi.ufl.edu")
	by vger.kernel.org with ESMTP id S262584AbTENQWh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:22:37 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: RE: 2.5.69-mm5
Date: Wed, 14 May 2003 12:35:26 -0400
Message-ID: <CDD2FA891602624BB024E1662BC678ED843F9B@mbi-00.mbi.ufl.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.5.69-mm5
Thread-Index: AcMaNgDzIVYJaD/qQ0Gmz6K7hltc3gAAIMQA
From: "Jon K. Akers" <jka@mbi.ufl.edu>
To: "Greg KH" <greg@kroah.com>
Cc: "Andrew Morton" <akpm@digeo.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently I do not use the -bk patches from Linus's tree, although I
suppose I could give it a shot. 

My .config for that section follows:

#
# USB support
#
# CONFIG_USB is not set
CONFIG_USB_GADGET=y

#
# USB Peripheral Controller Support
#
CONFIG_USB_NET2280=y

#
# USB Gadget Drivers
#
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_NET2280=y
CONFIG_USB_ETH=y
CONFIG_USB_ETH_NET2280=y


I also had the USB_ETH series set for modules and got the same result.

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, May 14, 2003 12:31 PM
> To: Jon K. Akers
> Cc: Andrew Morton; linux-kernel@vger.kernel.org; linux-mm@kvack.org
> 
> On Wed, May 14, 2003 at 10:33:43AM -0400, Jon K. Akers wrote:
> > I like to at least build the new stuff that comes out with Andrew's
> > patches, and building the new gadget code that came out in -mm4 I
got
> > this when building as a module:
> >
> > make -f scripts/Makefile.build obj=drivers/serial
> > make -f scripts/Makefile.build obj=drivers/usb/gadget
> >   gcc -Wp,-MD,drivers/usb/gadget/.net2280.o.d -D__KERNEL__ -Iinclude
> > -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
> > -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686
> > -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
> > -iwithprefix include -DMODULE   -DKBUILD_BASENAME=net2280
> > -DKBUILD_MODNAME=net2280 -c -o drivers/usb/gadget/net2280.o
> > drivers/usb/gadget/net2280.c
> > drivers/usb/gadget/net2280.c:2623: pci_ids causes a section type
> > conflict
> 
> Do you get the same error on the latest -bk patch from Linus's tree?
> 
> And what CONFIG_USB_GADGET_* .config options do you have enabled?
> 
> thanks,
> 
> greg k-h
