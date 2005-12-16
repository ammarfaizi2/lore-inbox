Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVLPTaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVLPTaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 14:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVLPTaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 14:30:08 -0500
Received: from mxout02.versatel.de ([212.7.152.119]:6606 "EHLO
	mxout02.versatel.de") by vger.kernel.org with ESMTP id S932384AbVLPTaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 14:30:07 -0500
Date: Fri, 16 Dec 2005 20:29:52 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT] swsusp: image size tunable (was: Re: [PATCH][mm] swsusp: limit image size)
Message-ID: <20051216192952.GA7212@zeus.uziel.local>
References: <200512072246.06222.rjw@sisk.pl> <20051216101623.GA7878@suse.de> <20051216142543.GA20069@zeus.uziel.local> <200512161908.56635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <200512161908.56635.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2005 at 07:08:56PM +0100, Rafael J. Wysocki wrote:
> Hi,
>=20
> On Friday, 16 December 2005 15:26, Christian Trefzer wrote:
> > The problem is the free swap space is not constant as long as you are
> > trying to free more RAM, because some pages can get swapped out in the
> > process at any time.
>=20
> To handle this properly we would have to count the amount of free swap in
> every iteration of the loop in swsusp_shrink_memory(), but I wouldn't like
> to make this function swap-dependent.

Well, I did not quite see that. Renders the problem a lot less trivial.
More on that later.


> We are going to move the image-writing and reading functionality of swsusp
> to the user space anyway and the userspace process controlling the suspend
> will solve this problem.  For now, please use workarounds like the Stefan=
's
> one.

In the long term, if I am correctly informed, everything should be
controlled by userspace, so it seems to me that some current problems
will be solved along the way. I am not looking for a workaround, though.
Instead I wanted to ask if there was no simple way to keep swsusp from
failing in a self-contained manner, i.e. without sneaky workarounds.
What occured to me while writing my first mail was that maybe it is not
trivial at all to determine the remaining swap space, as you already
confirmed.

My point is, that the generic algorithm to determine the maximum image
size desired by the user will, as a whole, remain the same, whether
implemented in kernel or user space. Unfortunately, I am very unfamiliar
with swsusp code and all of its implications wrt. drivers etc. - this
still holds true after looking at swsusp_shrink_memory().

But generally speaking: at some point, memory is freed for the image
creation process. Recent efforts towards tunable max_image_size make it
seem to me that we likely know beforehand, how much we are going to
free. Now say we have max_image_size of 500MB, but we know that active
swaps will hold 400MB at max. So we start out freeing enough memory for
a 400MB image, and once we're done, we notice we can only save 350MB.
Does anything keep us from reducing the image size to 350MB right now?=20

Apologies for wasting your time, I am trying to get rid of my ignorance.

Yours,
Chris

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ6MVsF2m8MprmeOlAQKWFQ//fv4VneRuwjR8vIhJakKOeIbsVZG+FA50
TIKwtcjdrerjpDich6ZfPSYp4nwelhbJURy+kJ6RLHdRqXXWj9UvluvPN1pG6CXr
5rFPbOAyGsdECdhXaXN0SbH2vUG+gJk2OXwDZlAOBfIDssL+61ZOujDckC0gOchI
8y8L9JsWTzNkqGcxcd5fkRVKXIrp4pMJHJqHMy61OK1rXB3jo5p4NMEmv3k4pU84
XPeU6NnNgGt1XY8E+EuIR2ABI27Ne/qd5P+aB/1hNsYpXvVkDAMxTeJnjiZ9JlH7
1VoUnGbFN8AqqumYTDuj6eVrw1lDGTLnlzIMYWZhEUTsL6HMELs5b4PdUKVv1Xgi
6CO4ez8nkjwQoIZoCbfet8Gz7ZpRDj83dkOUCh4j+YIDkLJTrbpIEkgyPP+jNNUi
nYc8fi1eXLJ7hvTes4g0XgkZTAw7CmLFN1fpE+biJ6H1OYK1v+x4J5plFxEbiCd5
fGHUHbxYvF2GjFp4A6rkOZjFzQotzJNG21MymD1sGjc+HYyw+rQSQaR62AWoDfet
ySGWKSS4abSlV/vgpdzX17GFtoEKmxWtqNsWs0og/8yVBm0Rw8Ke4H2pAUDve8rl
h7VkvGdhCUHhoro28eBK5NJzOqTS7zUBMdLORy1gZUVODY89Q3xSONVeOYz8CZaL
9Wybp1D2qQ4=
=EbSr
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

