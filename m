Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315791AbSENPru>; Tue, 14 May 2002 11:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSENPru>; Tue, 14 May 2002 11:47:50 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:32385 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315790AbSENPrs>; Tue, 14 May 2002 11:47:48 -0400
Date: Tue, 14 May 2002 09:47:37 -0600
Message-Id: <200205141547.g4EFlbR09184@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove compat code for old devfs naming scheme
In-Reply-To: <20020514163347.A5474@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Tue, May 14, 2002 at 08:59:41AM -0600, Richard Gooch wrote:
> > The reason to support it is because lots of people are depending on
> > it. A lot of systems would break for no real gain. This code is in the
> > init section, so the memory will be freed before init(8) starts.
> > 
> > The code should stay. In 2.5, I can move it into the mini devfsd that
> > will go into the initial rootfs.
> 
> Exactly how many system exist which
> 
>   a) still use the two or three year old devfs naming scheme for
>      their root= command line
>   b) use current 2.5 kernels

Those names are not really "old", but convenient shorthand. And it's
more systems than you think.

> and
> 
>   c) have users not capable of translating that syntax to either
>      the new devfs or traditional Linux syntax?
> 
> I don't think there are more then about ten, and no I _absolutely_
> do not consider that a reason to bloat the kernel, even if it is just
> source and image bloat.

A lot more people are using devfs than you realise. Removing the code
would screw them over. Leave it alone.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
