Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTAEPVe>; Sun, 5 Jan 2003 10:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTAEPVd>; Sun, 5 Jan 2003 10:21:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54281
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264788AbTAEPVc>; Sun, 5 Jan 2003 10:21:32 -0500
Date: Sun, 5 Jan 2003 07:29:03 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew McGregor <andrew@indranet.co.nz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
In-Reply-To: <2043540000.1041763678@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10301050714420.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Already drafted the model for secure supporting such a beast.
Additional the day will come when there is mobile internet radio
everywhere with good data rates.  The age of corporate security as it
relates to content on laptops is just over the hill.

No longer will people/corporations need to worry about security of laptops
and that which is stored on them.  Using iSCSI with ACLs, one can shutdown
data access in an instant.  Now this requires or suggests the need for
Diskless Bootable iSCSI without suffering the extra cost associated with,
what is known as "iBOOT" from IBM.  This is another issue, but we (the 
community) have LinBIOS, and I have a full working version of DBiSCSI
today.

Well I will follow up on this later, and yes what you are asking about can
be done.

Cheers,

On Sun, 5 Jan 2003, Andrew McGregor wrote:

> Oh, that's nice!
> 
> Presumably you could substitute DCCP or whatever for TCP.  I like it.
> 
> So how about this, the result of a corridor conversation at an IETF:
> 
> It is perfectly doable, using HIP and some (admittedly expensive) hardware 
> crypto gear to run iSCSI encrypted at Gigabit Ethernet rates and faster, 
> while being able to attach endpoints more or less at random in IP space and 
> move them around freely while connected.  Mobile hotplug IP storage :-)
> 
> 
> HIP is the Host Identity Payload, which can be seen as different things 
> depending on which features you like.  The idea starts from distinguishing 
> the IP address, which basically represents a location in the net, from the 
> Host Identity, which is a public key that identifies an endpoint.
> 
> By some machinations, you end up being IP numbering and version agnostic, 
> while having an extremely lightweight opportunistic key exchange protocol.
> 
> There are several implementations and all the specs linked to at 
> http://www.hip4inter.net/, not presently including my own, which is purely 
> userspace (everything I have so far needed is provided by standard kernels, 
> except ESP and that is now in too), BSD licensed and written in Python and 
> which will be released soon, for some value of soon.
> 
> This is a less mature protocol than iSCSI at this point, but I think there 
> are some very interesting possibilities by combining the two.
> 
> Andrew
> 
> --On Saturday, January 04, 2003 21:31:39 -0800 Andre Hedrick 
> <andre@linux-ide.org> wrote:
> 
> > On Sun, 5 Jan 2003, Andrew McGregor wrote:
> >
> >> By the way, I'm principally a developer of communications standards and
> >> hardware, not so much software.
> >
> > I forgot to mention the template model on each side of the iSCSI protocol
> > state machine we have developed is agnostic?
> >
> > Initiator --- Transport --- Target --- Spindle
> >
> > 		TCP			SCSI
> > 		Quads			ATA
> > 		SCI			SATA
> > 		Myrinet			MD
> > 		InfiniBand		LVM
> > 		TELCO			USB
> > 		CARRIER			1394
> > 					SAS
> > 					Fibre Channel
> >
> > 					FLOPPY, for emergencies.
> >
> > 	Create Your Own		Create Your Own
> >
> > Yeah, I am nutter than a fruitcake, but it works!
> >
> > This is for Larry McVoy, it is the closest thing you will ever see today
> > which looks like a disk with an RJ-45 port.
> >
> > Cheers,
> >
> > Andre Hedrick
> > LAD Storage Consulting Group
> >
> >
> 

Andre Hedrick
LAD Storage Consulting Group

