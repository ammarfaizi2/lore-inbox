Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbUBXVEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbUBXVEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:04:09 -0500
Received: from mail0.lsil.com ([147.145.40.20]:43448 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262458AbUBXVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:03:57 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC3DE@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug 
	 fix)
Date: Tue, 24 Feb 2004 16:02:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > controllers and also a single code base, with a very small 
> footprint patch -
> > if at all required, to support various kernels.
> 
> I didn't say "no".  I'm just warning you that you've chosen a 
> hard road
> to hoe, particularly with the limited life of 2.4.

In my opinion, maintaining support for 2.4 drivers and adding new
controllers to it would be crucial for a considerable time to come even
while lk 2.6 becomes mainstream. As support, we would want to provide
support for as many kernels and controllers as possible.

>From a developer standpoint, It is very difficult to maintain two drivers. I
am willing to fork iff the code is too hairy - but right now it seems very
manageable.

> "An important MegaRAID feature is to be able to boot from any logical
> drive on
> If you require this functionality in 2.6, you should look at plugging
> into the udev infrastructure.

Now, this is some new information for me. I am not sure what is Dell's stand
on this option. Matt, Arjan?

Do we want to discover controllers and devices directed solely by kernel and
should driver interfere a little bit.

> This is unacceptable:
> 
> #if defined (__x86_64__)
> 		/*
> 		 * Register the 32-bit ioctl conversion
> 		 */
> 		register_ioctl32_conversion(MEGAIOCCMD, sys_ioctl)
> #endif
Ok.. Let us find a better solution. 
