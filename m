Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSGECOY>; Thu, 4 Jul 2002 22:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSGECOX>; Thu, 4 Jul 2002 22:14:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39689
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315182AbSGECOW>; Thu, 4 Jul 2002 22:14:22 -0400
Date: Thu, 4 Jul 2002 19:15:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: Re: [BUG-2.5.24-BK] DriverFS panics on boot! 
In-Reply-To: <200207042259.g64MxdH03605@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10207041900080.19028-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2002, James Bottomley wrote:

> andre@linux-ide.org said:
> > The whole reason for my replacement was to add driverfs to IDE and
> > remove devfs and ultimately "de-gooch" the kernel.  So we are nearly
> > 100 patches in and the primary reason for ousting is still a failure,
> > NICE! 
> 
> Well, perhaps we have slightly different agendas.  I think driverfs will solve 
> a whole series of enumeration and mapping problems that occur in the SCSI 
> mid-layer and which get especially tortuous with Fibre Channel.  I also think 
> it will help us bring the SCSI and IDE views closer together.

Well there was this model I started before I got booted to unify the
transport layer to operate under the classic/standard CDB model.  However
this would require fixing the FS's (which are bit-buckets for data
archives, and no more than a filing cabinet with cool features),
exteneding block to do nothing but translate between FS <> STORAGE.
Next was to have asymetric transfer because disk drives reorder to their
desire, regardless what the meatballs in Linux think.  Linux could vastly
impove its position in storage if it did two simple things.

	1) 8K writes and 64K (or larger) reads.
	2) ONE maybe TWO passes on elevator operations.

Since this is falling on deaf ears in general, oh well.
Maybe you can carry the banner of sanity.

> I persuaded Linus to put the SCSI driverfs patches in the kernel even though I 
> knew they touched more than SCSI (the partitions code) and were not as modular 
> as I would have liked.  The reason is that we need to get as much visibility 
> on this as possible before the code freeze.  I'm fully prepared to sort out 
> any problems with this as they arise (and indeed the panic is already fixed).

Great!

I have no problems with "driverfs".

> I believe it's a variation of a principle attributable to a wise Australian:  
> get the right solution in, even if not quite the right implementation.  That 
> way, everyone will be extrememly motivated to help produce the right 
> implementation.

I prefer what Col. Medberry told to be "Perfectly Lazy!"
"Son, DO IT ONCE and ONLY ONCE, as not to REPEAT THE SAME ERROR!!!!"

This comes after taking his course for the second time, and being ripped
out of the class rooom and being addressed in a very stern manner.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

