Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293151AbSCZIVy>; Tue, 26 Mar 2002 03:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293204AbSCZIVp>; Tue, 26 Mar 2002 03:21:45 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:11278 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S293151AbSCZIVe>; Tue, 26 Mar 2002 03:21:34 -0500
Date: Tue, 26 Mar 2002 00:21:28 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
Message-ID: <20020326002128.L6223@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203252316.g2PNGD011116@numbat.Os2.Ami.Com.Au> <01c501c1d487$14ce9180$7e0aa8c0@bridge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 09:28:21PM -0800, Jeremy Jackson wrote:
> At the interface level, there is some support.
> Look at hdparm's -b option to tristate the bus.
> But that's the whole bus.  If the controller implements
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

IDE isn't really meant to allow hot swap but it can be done.

As Jeremy says, electrically it is difficult to do it with a
master+slave on one cable because you really must power down
the interface (cable) and that would mean downing both devices.

As Alan and others have indicated the IDE drivers are a little
untested at doing this as well.

The big issue is powering down the interface.  You need a
card that can do so selectively.  I gather the 3Ware cards
can do this, i don't have one yet so don't go by me on this.
Perhaps someone else can confirm it.  They also have the
advantage here in that they present the drives (in JBOD
mode) as SCSI devices or luns and SCSI has handled hot
(un)plug pretty well since at least the 1.2 kernel.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
