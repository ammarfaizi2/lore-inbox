Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWAaSIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWAaSIL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWAaSIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:08:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55454 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751310AbWAaSIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:08:09 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: chris perkins <cperkins@OCF.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
	 <1138653235.26657.7.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601310946000.8770@conquest.OCF.Berkeley.EDU>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tQG+lNT3VAPYv5xYOwjt"
Date: Tue, 31 Jan 2006 12:07:15 -0600
Message-Id: <1138730835.5959.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tQG+lNT3VAPYv5xYOwjt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-31 at 09:52 -0800, chris perkins wrote:
> > <snip>
> >
> >> CONFIG_LATENCY_TIMING=3Dy
> >
> > I'm betting this is the same thing I'm seeing. Are you running on a
> > uniprocessor x86_64? And if so are you seeing messages similar to the
> > following?
> >
> > init[1]: segfault at ffffffff8010fadc rip ffffffff8010fadc rsp
> > 00007fffffdacfc8
> >
> > If so, then I suspect that you're getting a segfault in ld.so (at least
> > that's the furthest I've gotten so far). Something about how the kernel
> > sets up the memory map is upsetting dynamically loaded executables. I
> > can boot with init=3D/sbin/sash, but when I try and run a dynamically
> > linked program, I get segfaults.
> >
> > You might try turning off LATENCY_TRACING and see if that allows you to
> > boot and run (works for me).
> >
> > Meanwhile, I'm going to try and pin this down to something better than
> > "somewhere in ld.so..."
> >
> > Clark
> > -
> > Clark Williams <williams@redhat.com>
>=20
> hi,
>    actually i'm running on a dual processor x86_64. with the problem i wa=
s=20
> having, i never got far enough to see the message you asked about. Steven=
=20
> Rostedt's suggestion to turn off NUMA worked and i am now able to boot.=20
> However, if I turn LATENCY_TRACING on, i get an immediate reboot after th=
e=20
> kernel is uncompressed. this doesn't sound like the same problem you're=20
> having, though.

Man, I saw that LATENCY_TRACING and completely missed the NUMA
parameter. Sorry about that...

I must be the only person running a uniprocessor x86_64 that's working
with the -rt patches and trying to trace latencies. If I turn off
LATENCY_TRACING, I boot just fine.=20

Are you getting any output from the kernel before the reboot?

Clark

--=20
Clark Williams <williams@redhat.com>

--=-tQG+lNT3VAPYv5xYOwjt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD36dTHyuj/+TTEp0RAg1fAJ9Z6yVXInYhzZdUWGGoYXh2Dm8LWwCggcFw
O96mVKdp4ySd5l89smM8KEs=
=IpGj
-----END PGP SIGNATURE-----

--=-tQG+lNT3VAPYv5xYOwjt--

