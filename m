Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269052AbRHBPrl>; Thu, 2 Aug 2001 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbRHBPrb>; Thu, 2 Aug 2001 11:47:31 -0400
Received: from h-207-228-73-44.gen.cadvision.com ([207.228.73.44]:20751 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269041AbRHBPrP>; Thu, 2 Aug 2001 11:47:15 -0400
Date: Thu, 2 Aug 2001 09:47:18 -0600
Message-Id: <200108021547.f72FlI619086@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: adilger@turbolinux.com (Andreas Dilger), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFT] #2 Support for ~2144 SCSI discs
In-Reply-To: <E15SKWg-0000uC-00@the-village.bc.nu>
In-Reply-To: <no.id>
	<E15SKWg-0000uC-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> > So, yes, you can already patch other subsystems to dynamically assign
> > major numbers in 2.4.7. I'd like to see people do that. My patch for
> > sd.c can also serve as a demonstration on how to use the new API.
> 
> Its a bit of an ugly hack but I guess its the best anyone can put
> together for a 2.4 kernel tree. Going to a 32bit dev_t is going to
> make life so much simpler do all of this without ugly hacks

My patch is definately 2.4 material. I see it as a temporary solution
until the whole block I/O subsystem is ripped out and replaced in 2.5.
Since 2.4 will be the latest production kernel for about two years, we
need to find ways of working around current limitations.

That said, in 2.5 I want to see us move away from using device numbers
as the fundamental device handle and move to device instance
structures. That's a lot cleaner, and BTW is devfs-neutral
(i.e. doesn't need devfs to work). Exposing a 32 bit dev_t to
user-space is acceptable, but internally it should be shunned.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
