Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313014AbSC0OBv>; Wed, 27 Mar 2002 09:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSC0OBm>; Wed, 27 Mar 2002 09:01:42 -0500
Received: from c0s29.ami.com.au ([203.55.31.94]:29965 "EHLO
	dugite.os2.ami.com.au") by vger.kernel.org with ESMTP
	id <S313014AbSC0OBa>; Wed, 27 Mar 2002 09:01:30 -0500
Message-Id: <200203262253.g2QMrlS15084@numbat.Os2.Ami.Com.Au>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Jeremy Jackson" <jerj@coplanar.net>
cc: "John Summerfield" <summer@os2.ami.com.au>, linux-kernel@vger.kernel.org,
        summer@numbat.Os2.Ami.Com.Au, Mark Lord <mlord@pobox.com>
Subject: Re: IDE and hot-swap disk caddies 
In-Reply-To: Message from "Jeremy Jackson" <jerj@coplanar.net> 
   of "Mon, 25 Mar 2002 21:28:21 PST." <01c501c1d487$14ce9180$7e0aa8c0@bridge> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 27 Mar 2002 06:53:47 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At the interface level, there is some support.
> Look at hdparm's -b option to tristate the bus.

There is no mention of -b in hdparm's help screen, and in the man page 
it's only mentioned in the description of -L.

Is there a newer version of hdparm I need?


> But that's the whole bus.  If the controller implements

IDE1? That's okay for me, I can control the hardware configuration to 
that extent. If the other device is a CD reader, I'm not going to 
corrupt anything. If necessary, I'll make sure it's unmounted.

> master/slave on one cable, you're hosed, electrically.
> It's the whole interface.  95% of controlers are like this.
> 
> Intel's PIIX can do master/slave on separate ports, but
> then you loose one bus.  Laptops with bays also do things
> like this, but that's special hardware, hard to get programming
> specs for.
> 
> I think if you add the drive *after* boot, it doesn't
> have the benefit of the BIOS setting up PIO/UDMA modes,
> so I would try the hdparm -X speed settings also.

At present the system hangs if I add a master when the primary's 
present, before I get to do anything.

I've not tried adding a slave to an existing master.

As to the BIOS settings, I only configure drives required for booting. 
I've been doing that for years, before I ever used Linux, when I 
discovered that OS/2 wasn't paying attention to them. (A good thing in 
the case of OS/2 as the instructions for one of my drives gave the 
wrong geometry;-().



> 
> Jeremy
> 
> ----- Original Message ----- 
> From: "John Summerfield" <summer@os2.ami.com.au>
> Sent: Monday, March 25, 2002 3:16 PM
> Subject: Re: IDE and hot-swap disk caddies 
>  
> > > > The device is hot-swap capable and has a switch (others have a key) 
> > > > that locks the drive in and powers it up; in the other position the 
> > > > drive is powered down and can be removed.
> > > 
> > > Linux doesn't support IDE hot swap at the drive level. Its basically
> > > waiting people to want it enough to either fund it or go write the code
> > > 
> > 
> > What needs to be done? How extensive is the surgery needed?
> 

-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my 
disposition.

==============================
If you don't like being told you're wrong,
	be right!



