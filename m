Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312954AbSCZF3e>; Tue, 26 Mar 2002 00:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312957AbSCZF3Y>; Tue, 26 Mar 2002 00:29:24 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:9235 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S312956AbSCZF3R>; Tue, 26 Mar 2002 00:29:17 -0500
Message-ID: <01c501c1d487$14ce9180$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "John Summerfield" <summer@os2.ami.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200203252316.g2PNGD011116@numbat.Os2.Ami.Com.Au>
Subject: Re: IDE and hot-swap disk caddies 
Date: Mon, 25 Mar 2002 21:28:21 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the interface level, there is some support.
Look at hdparm's -b option to tristate the bus.
But that's the whole bus.  If the controller implements
master/slave on one cable, you're hosed, electrically.
It's the whole interface.  95% of controlers are like this.

Intel's PIIX can do master/slave on separate ports, but
then you loose one bus.  Laptops with bays also do things
like this, but that's special hardware, hard to get programming
specs for.

I think if you add the drive *after* boot, it doesn't
have the benefit of the BIOS setting up PIO/UDMA modes,
so I would try the hdparm -X speed settings also.

Jeremy

----- Original Message ----- 
From: "John Summerfield" <summer@os2.ami.com.au>
Sent: Monday, March 25, 2002 3:16 PM
Subject: Re: IDE and hot-swap disk caddies 
 
> > > The device is hot-swap capable and has a switch (others have a key) 
> > > that locks the drive in and powers it up; in the other position the 
> > > drive is powered down and can be removed.
> > 
> > Linux doesn't support IDE hot swap at the drive level. Its basically
> > waiting people to want it enough to either fund it or go write the code
> > 
> 
> What needs to be done? How extensive is the surgery needed?

