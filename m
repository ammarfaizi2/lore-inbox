Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315753AbSENO7r>; Tue, 14 May 2002 10:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315750AbSENO7q>; Tue, 14 May 2002 10:59:46 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:22657 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S315753AbSENO7o>; Tue, 14 May 2002 10:59:44 -0400
Date: Tue, 14 May 2002 08:59:41 -0600
Message-Id: <200205141459.g4EExfU07828@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove compat code for old devfs naming scheme
In-Reply-To: <20020514155508.A31292@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
> On Tue, May 14, 2002 at 08:35:03AM -0600, Richard Gooch wrote:
> > > As this was never present in official kernels there is really no need
> > > in keeping it - it just bloats the kernel.
> > > 
> > > Could you please forward this patch to Linus and maybe Marcelo with
> > > your next devfs update?
> > 
> > What on earth are you talking about? This code has been in the kernel
> > since 2.3.46. It's just lived in a different place: fs/devfs/util.c.
> 
> Of course this code was present, otherwise it would be rather hard
> to remove it..
> 
> But the old devfs naming scheme was obsolete before devfs was merged
> in 2.3.46 so there is no valid reason to support it for root=.

The reason to support it is because lots of people are depending on
it. A lot of systems would break for no real gain. This code is in the
init section, so the memory will be freed before init(8) starts.

The code should stay. In 2.5, I can move it into the mini devfsd that
will go into the initial rootfs.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
