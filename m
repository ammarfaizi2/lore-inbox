Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135882AbRD2Ssa>; Sun, 29 Apr 2001 14:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135881AbRD2SsU>; Sun, 29 Apr 2001 14:48:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57062 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S130532AbRD2SsM>; Sun, 29 Apr 2001 14:48:12 -0400
Date: Sun, 29 Apr 2001 12:48:06 -0600
Message-Id: <200104291848.f3TIm6821037@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain>
	<20010428215301.A1052@gruyere.muc.suse.de>
	<200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
	<9cg7t7$gbt$1@cesium.transmeta.com>
	<3AEBF782.1911EDD2@mandrakesoft.com>
	<15083.64180.314190.500961@pizda.ninka.net>
	<20010429153229.L679@nightmaster.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser writes:
> On Sun, Apr 29, 2001 at 04:27:48AM -0700, David S. Miller wrote:
> > The idea is that the one thing one tends to optimize for new cpus
> > is the memcpy/memset implementation.  What better way to shield
> > libc from having to be updated for new cpus but to put it into
> > the kernel in this magic page?
> 
> Hehe, you have read this MXT patch on linux-mm, too? ;-)
> 
> There we have 10x faster memmove/memcpy/bzero for 1K blocks
> granularity (== alignment is 1K and size is multiple of 1K), that
> is done by the memory controller.

This sounds different to me. Using the memory controller is (should
be!) a privileged operation, thus it requires a system call. This is
quite different from code in a magic page, which is excuted entirely
in user-space. The point of the magic page is to avoid the syscall
overhead.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
