Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWF0QqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWF0QqG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbWF0QqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:46:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:64491 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161199AbWF0QqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:46:03 -0400
Date: Tue, 27 Jun 2006 09:42:44 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org, klibc@zytor.com,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060627164244.GA7758@kroah.com>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <44A13512.3010505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A13512.3010505@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 09:39:30AM -0400, Jeff Garzik wrote:
> Roman Zippel wrote:
> > What I'm more interested in is basically answering the question and where 
> > I hope to provoke a bit broader discussion: "What's next?"
> > 
> > Until recently for most developers klibc was not much more than a cool 
> > idea, but now we have the first incarnation and now we have to do a 
> > reality check of how it solves our problems. To say it drastically the 
> > current patch set as it is does not solve a single real problem yet, it 
> > only moves them from the kernel to kinit, which may be the first step but 
> > where to?
> > 
> > So what problems are we going to solve now and how? The amount of 
> > discussion so far is not exactly encouraging. If nobody cares, then there 
> > don't seem to be any real problems, so why should it be merged at all? Are 
> > shiny new features more important than functionality?
> 
> Well, at least for me...  at boot time we run into various limitations 
> from the current kernel approach of coding purely userspace activities 
> in the kernel, simply because a vehicle for implementing early-boot 
> userland operations did not exist.
> 
> This klibc patchkit removes stuff that does not need to be in the 
> kernel, and provides a platform for improving IP autoconfig, NFS root, 
> MD/DM root setup, and various other early-boot activities.
> 
> A lot of the larger distros have been moving in this direction anyway, 
> by necessity.  They have been stuffing more and more [needed] logic into 
> initrd [which is often really initramfs these days], to deal with 
> complex boot and root-mounting scenarios like iSCSI and multi-path.

I second this statement, having a method of implementing early boot
userspace options is a very good thing to have, and one that the distros
really want (as they have already been doing it on their own in
different ways, some using klibc already, others using uclibc, and still
others using glibc.)  Standardizing on a method to implement this is
very much needed.

thanks,

greg k-h
