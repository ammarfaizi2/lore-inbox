Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWARAT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWARAT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWARAT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:19:57 -0500
Received: from ozlabs.org ([203.10.76.45]:59858 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932519AbWARAT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:19:56 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-mm4 failure on power5
Date: Wed, 18 Jan 2006 11:19:36 +1100
User-Agent: KMail/1.8.3
Cc: Dave C Boutcher <sleddog@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu>
In-Reply-To: <20060117140050.GA13188@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2115656.CDpOnf0t70";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601181119.39872.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2115656.CDpOnf0t70
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 18 Jan 2006 01:00, Ingo Molnar wrote:
> * Michael Ellerman <michael@ellerman.id.au> wrote:
> > On Tue, 17 Jan 2006 08:52, Dave C Boutcher wrote:
> > > 2.6.15-mm4 won't boot on my power5 either.  I tracked it down to the
> > > following mutex patch from Ingo: kernel-kernel-cpuc-to-mutexes.patch
> > >
> > > If I revert just that patch, mm4 boots fine.  Its really not obvious =
to
> > > me at all why that patch is breaking things though...
> >
> > My POWER5 (gr) LPAR seems to boot ok (3 times so far) with that patch,
> > guess it's something subtle. That's with CONFIG_DEBUG_MUTEXES=3Dy. And
> > it's just booted once with CONFIG_DEBUG_MUTEXES=3Dn.
> >
> > And now it's booted the full mm4 patch set without blinking.
>
> so it booted fine with CONFIG_DEBUG_MUTEXES=3Dn but with that patch not
> applied?
>
> the patch will likely work around the bug, so DEBUG_MUTEXES=3Dy/n should
> make no difference with that patch applied.

It booted fine _with_ the patch applied, with DEBUG_MUTEXES=3Dy and n.

Boutcher, to be clear, you can't boot with kernel-kernel-cpuc-to-mutexes.pa=
tch=20
applied and DEBUG_MUTEXES=3Dy ?

But if you revert kernel-kernel-cpuc-to-mutexes.patch it boots ok?

This is looking quite similar to another hang we're seeing on Power4 iSerie=
s=20
on mainline git:
http://ozlabs.org/pipermail/linuxppc64-dev/2006-January/007679.html

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart2115656.CDpOnf0t70
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDzYmbdSjSd0sB4dIRAu/HAJ9C+xoWbCC820f+kWfgNRDET+AaHwCgpA/9
gPuuFFvUqz9N+ALgBjv2gxE=
=peic
-----END PGP SIGNATURE-----

--nextPart2115656.CDpOnf0t70--
