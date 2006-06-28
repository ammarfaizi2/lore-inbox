Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWF1Xr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWF1Xr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWF1XrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:47:25 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28309 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751793AbWF1XrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:47:22 -0400
Date: Thu, 29 Jun 2006 01:46:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jeff@garzik.org>, torvalds@osdl.org, klibc@zytor.com,
       linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc] klibc and what's the next step?
In-Reply-To: <20060627164244.GA7758@kroah.com>
Message-ID: <Pine.LNX.4.64.0606281845470.17704@scrub.home>
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
 <Pine.LNX.4.64.0606271316220.17704@scrub.home> <44A13512.3010505@garzik.org>
 <20060627164244.GA7758@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Jun 2006, Greg KH wrote:

> On Tue, Jun 27, 2006 at 09:39:30AM -0400, Jeff Garzik wrote:
> > Roman Zippel wrote:
> > > What I'm more interested in is basically answering the question and where 
> > > I hope to provoke a bit broader discussion: "What's next?"
> > > 
> > > Until recently for most developers klibc was not much more than a cool 
> > > idea, but now we have the first incarnation and now we have to do a 
> > > reality check of how it solves our problems. To say it drastically the 
> > > current patch set as it is does not solve a single real problem yet, it 
> > > only moves them from the kernel to kinit, which may be the first step but 
> > > where to?
> > > 
> > > So what problems are we going to solve now and how? The amount of 
> > > discussion so far is not exactly encouraging. If nobody cares, then there 
> > > don't seem to be any real problems, so why should it be merged at all? Are 
> > > shiny new features more important than functionality?
> > 
> > Well, at least for me...  at boot time we run into various limitations 
> > from the current kernel approach of coding purely userspace activities 
> > in the kernel, simply because a vehicle for implementing early-boot 
> > userland operations did not exist.
> > 
> > This klibc patchkit removes stuff that does not need to be in the 
> > kernel, and provides a platform for improving IP autoconfig, NFS root, 
> > MD/DM root setup, and various other early-boot activities.
> > 
> > A lot of the larger distros have been moving in this direction anyway, 
> > by necessity.  They have been stuffing more and more [needed] logic into 
> > initrd [which is often really initramfs these days], to deal with 
> > complex boot and root-mounting scenarios like iSCSI and multi-path.
> 
> I second this statement, having a method of implementing early boot
> userspace options is a very good thing to have, and one that the distros
> really want (as they have already been doing it on their own in
> different ways, some using klibc already, others using uclibc, and still
> others using glibc.)  Standardizing on a method to implement this is
> very much needed.

I guess this describes pretty much describes the goal and I don't think 
anyone really disagrees.
The question is now how do we get there? The current klibc patches give no 
answer to that, there is no documentation or any prototype, which would 
give a good idea how to get this stuff into initramfs in a manageable way.
The current responses indicate that the primary (or at least initial) 
users would be distributions, but there is no hint how the current klibc 
stuff can be used by them, which IMO is a serious problem.
The problem here is that we are about to create a new kernel-userspace 
interface and considering our track record here, I think it's a really bad 
idea to go into this practically blind. How will distributions put their 
stuff into initramfs?

bye, Roman
