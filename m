Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285340AbRLGAWT>; Thu, 6 Dec 2001 19:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285341AbRLGAWD>; Thu, 6 Dec 2001 19:22:03 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:11144 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S285340AbRLGAVu>; Thu, 6 Dec 2001 19:21:50 -0500
Date: Thu, 6 Dec 2001 17:21:44 -0700
Message-Id: <200112070021.fB70Lik02148@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Rene Rebe <rene.rebe@gmx.net>, greg@kroah.com, jonathan@daria.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
In-Reply-To: <Pine.GSO.4.21.0112061903230.29985-100000@binet.math.psu.edu>
In-Reply-To: <20011207005707.6a09706a.rene.rebe@gmx.net>
	<Pine.GSO.4.21.0112061903230.29985-100000@binet.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Fri, 7 Dec 2001, Rene Rebe wrote:
> 
> > > > usbdevfs does not require devfs, which enables the majority of Linux
> > > > users to actually use it.
> > > 
> > > s/majority of/& sane/
> > 
> > Writing bash scripts is easier than adding two lines to devfsd.conf?? Btw.
> > sane users do not use such a mahor/messy distro ...
> 
> Sane users don't run stuff with known unfixable security holes.  The
> only variant that has any promise to get that crap fixed got no
> testing to speak about.

I gave it as much testing as I could, but there comes a point where
you don't get any more test reports (because people are lazy) where
you have to throw it out for a pre-patch which *will* get testing.
I got tired of begging for people to test it.

Basic chicken and egg problem. It's the same reason Linus released
2.4.0-test* when it was really 2.3.99++.

> Ask Richard if you don't believe me - or grep the l-k archives.
> Again, all variants of devfs up to and including 2.4.16 are
> unfixable according to devfs author.

It's a matter of degree. I did fix it, by putting locking and
refcounting in. Is that a re-write or a fix? It's a grey area. I've
been calling it a re-write, but you could also argue that it's "fix".

My main claim is that the old core wasn't amenable to fixing with a
few tweaks here and there.

Anyway, this is all semantics and history. All that matters is that
the latest code is much better, and I'm working on getting the last
wrinkles out. We're still in a pre-patch, so no need to panic yet.
I've been diligent about fixing things (mostly battling with
incomplete bug reports).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
