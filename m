Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbSLSGm6>; Thu, 19 Dec 2002 01:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbSLSGm6>; Thu, 19 Dec 2002 01:42:58 -0500
Received: from [212.209.10.215] ([212.209.10.215]:12699 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S267568AbSLSGm5>;
	Thu, 19 Dec 2002 01:42:57 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE565@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Christoph Hellwig'" <hch@infradead.org>
Cc: "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'starvik@axis.com'" <mikael.starvik@axis.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.21-pre2
Date: Thu, 19 Dec 2002 07:49:32 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It reverts the s/extern __inline__/static __inline__/g changes

We have replaced all static inline with extern inline to keep
the size of the image down when compiling with GCC 3.2 
(because the maximum size to inline has changed in 3.2 I think,
I can get a clarification from the gcc-cris guy if necessary).
Is this a non preferred way to do it?

>a junk file in arch/cris/drivers/bluetooth/bt.patch

Why is it junk? The bluetooth options should only be visible
if you have an OpenBT source tree available. The Makefile 
in arch/cris/drivers/bluetooth/ checks your tree and then
runs the patch. This was previously done with a perl 
script instead. In the long run we should probably switch
to the official Bluetooth stack in Linux (i.e. Bluez).

>although if Axis would glance over and fixup the ide bits
>that would be great as its not a platform I have access too

Yes, I will take a look at it

/Mikael
