Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136391AbRD2WT3>; Sun, 29 Apr 2001 18:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136392AbRD2WTT>; Sun, 29 Apr 2001 18:19:19 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:12519 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S136391AbRD2WTJ>; Sun, 29 Apr 2001 18:19:09 -0400
Date: Sun, 29 Apr 2001 16:18:59 -0600
Message-Id: <200104292218.f3TMIxi22611@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010429221159.U706@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
	<200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
	<9cg7t7$gbt$1@cesium.transmeta.com>
	<3AEBF782.1911EDD2@mandrakesoft.com>
	<15083.64180.314190.500961@pizda.ninka.net>
	<20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
	<200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
	<20010429221159.U706@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
> On Sun, Apr 29, 2001 at 12:48:06PM -0600, Richard Gooch wrote:
> > Ingo Oeser writes:
> > > There we have 10x faster memmove/memcpy/bzero for 1K blocks
> > > granularity (== alignment is 1K and size is multiple of 1K), that
> > > is done by the memory controller.
> > This sounds different to me. Using the memory controller is (should
> > be!) a privileged operation, thus it requires a system call. This is
> > quite different from code in a magic page, which is excuted entirely
> > in user-space. The point of the magic page is to avoid the syscall
> > overhead.
> 
> Yes, but we currently have more than 10K cycles for doing
> memset of a page. If we do an syscall, we have around 600-900
> (don't know exactly), which is still less.
> 
> The point is: The code in that "magic page" that considers the
> tradeoff is KERNEL code, which is designed to care about such
> trade-offs for that machine.

Um, yes. I don't disagree with that. I'm just saying the two issues
are conceptually separate, and should be considered independently.

> Glibc never knows this stuff and shouldn't, because it is already
> bloated.

True, true and true.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
