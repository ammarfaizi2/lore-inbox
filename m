Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTDQD42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTDQD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:56:28 -0400
Received: from fmr01.intel.com ([192.55.52.18]:59607 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262884AbTDQD41 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:56:27 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C262E57@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'ranty@debian.org'" <ranty@debian.org>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: firmware separation filesystem (fwfs)
Date: Wed, 16 Apr 2003 21:07:30 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Manuel Estrada Sainz [mailto:ranty@debian.org]
>
> > With the risk of repeating myself (again) and being a PITA,
> > I really think it'd be easier to copy the firmware file to a
> > /sysfs binary file registered by the device driver during
> > initialization; then the driver can wait for the file to be
> > written with a valid firmware before finishing the init
> > sequence. The infrastructure is already there (or isn't ...
> > is it?).
> 
>  I don't know that much about sysfs, after a little investigation, it
>  seams like sysfs entries are restricted in size to PAGE_SIZE, which on
>  i386 is 4K, and ezusb firmware is already 6.9K in size.

You are right, at least that in 2.5.66 (the only tree I have handy now),
it is still limited to PAGE_SIZE; however, there were some
changes recently to the bin file interface, so it might have
been removed.

But this thing (firmware uploading) seems like a good reason
to remove that limit. 

If you [or somebody else :)] did the necessary modifications 
to fs/sysfs/bin.c and submit them to Patrick Mochel, with 
the reasoning on why and usage, I'd say he would mostly
accept them - it does not seem to be too hard.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
