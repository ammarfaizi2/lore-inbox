Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSCGAEv>; Wed, 6 Mar 2002 19:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSCGAEm>; Wed, 6 Mar 2002 19:04:42 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:30630 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S287858AbSCGAE2>; Wed, 6 Mar 2002 19:04:28 -0500
Date: Wed, 6 Mar 2002 17:04:13 -0700
Message-Id: <200203070004.g2704Dm19478@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Dike <jdike@karaya.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        hpa@zytor.com (H. Peter Anvin), bcrl@redhat.com (Benjamin LaHaise),
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: <6920.1015450061@redhat.com>
In-Reply-To: <200203062025.PAA03727@ccure.karaya.com>
	<6920.1015450061@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
> 
> jdike@karaya.com said:
> >  Yeah, MADV_DONTNEED looks right.  UML and Linux/s390 (assuming VM has
> > the equivalent of MADV_DONTNEED) would need a hook in free_pages to
> > make that happen. 
> 
>        MADV_DONTNEED
>               Do  not expect access in the near future.  (For the
>               time being, the application is  finished  with  the
>               given range, so the kernel can free resources asso­
>               ciated with it.)
> 
> It's not clear from that that the host kernel is actually permitted to
> discard the data.
> 
> alan@lxorguk.ukuu.org.uk said:
> >  VM allows you to give it back a page and if you use it again you get
> > a clean copy. What it seems to lack is the more ideal "here have this
> > page and if I reuse it trap if you did throw it out" semantic. 
> 
> I've wittered on occasion about other situations where such
> semantics might be useful -- essentially 'drop these pages if you
> need to as if they were clean, and tell me when I next touch them so
> I can recreate their data'.

Indeed. I'd love such a feature. It's got applications in
numerical/scientific code, not just UML.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
