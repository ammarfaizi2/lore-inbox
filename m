Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291074AbSB0A7l>; Tue, 26 Feb 2002 19:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290981AbSB0A7c>; Tue, 26 Feb 2002 19:59:32 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16521 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S290797AbSB0A7Q>; Tue, 26 Feb 2002 19:59:16 -0500
Date: Tue, 26 Feb 2002 17:59:03 -0700
Message-Id: <200202270059.g1R0x3132421@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver in userspace
In-Reply-To: <200202270052.g1R0qdK11879@devserv.devel.redhat.com>
In-Reply-To: <D8E12241B029D411A3A300805FE6A2B9025761AB@montreal.eicon.com>
	<mailman.1014747181.29305.linux-kernel2news@redhat.com>
	<200202270052.g1R0qdK11879@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev writes:
> >> I think this is a good example to start with. It has all the
> >> interresting features. I hope it also has interrupt handling
> >> to userspace (by generating SIGIO's). 
> > 
> > It hasn't, it just continually polls the I/O ports for 
> > completition.
> > 
> >> Although I dont know if this is a good idea in the first place.
> > 
> > I think it depends on the interrupt frequency, and other things.
> > 
> > Stelian.
> 
> PCI interrupts must be deactivated in the device before an
> interrupt driver returns and unmasks interrupt in the CPU.
> User processes run with interrupts open. This is why purely
> user level interrupts are IMPOSSIBLE (regardless of interrupt
> frequency).
> 
> Two natural ways to work around this problem are:
> 
> 1. Run user processes with interrupts closed (or at least one
> interrupt source disabled, if your architecture allows that).
> This is what RTOSes often do. I do not think it can be easily
> done on generic Linux.
> 
> 2. Write a small driver that deactivates interrupts and queues
> interrupt events (with SIGIO and some other means). Personally,
> I think that it is dumb in most cases, because once you wrote
> that driver stub, it takes very little work to move the rest
> of the driver into the kernel. The notable exception is XFree86,
> of course.
> 
> We must ask someone to add this to FAQ on tux.org.

Send me a patch to the HTML file.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
