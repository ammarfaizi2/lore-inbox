Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265033AbUFRHn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbUFRHn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 03:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUFRHn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 03:43:59 -0400
Received: from smtpin.eastlink.ca ([24.222.0.18]:36379 "EHLO
	smtpin.eastlink.ca") by vger.kernel.org with ESMTP id S265033AbUFRHn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 03:43:56 -0400
Date: Fri, 18 Jun 2004 04:41:32 -0300
From: Peter Cordes <peter@cordes.ca>
Subject: Re: x86-64: double timer interrupts in recent 2.4.x
In-reply-to: <20040617122645.5d1b5ec1.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com
Message-id: <20040618074132.GA17508@cordes.ca>
MIME-version: 1.0
Content-type: multipart/signed; boundary=h31gzZEtNLTqOjlF;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.6+20040523i
References: <200406170854.i5H8s0v5012548@alkaid.it.uu.se>
 <20040617122645.5d1b5ec1.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 17, 2004 at 12:26:45PM +0200, Andi Kleen wrote:
> On Thu, 17 Jun 2004 10:54:00 +0200 (MEST)
> Mikael Pettersson <mikpe@csd.uu.se> wrote:
>=20
> > On Wed, 16 Jun 2004 16:28:26 -0300, Peter Cordes wrote:
> > > I just noticed that on my Opteron cluster, the nodes that are running=
 64bit
> > >kernels have their clocks ticking at double speed.  This happens with
> > >Linux 2.4.26, and 2.4.27-pre2
> >=20
> > I had the same problem: 2.4 x86-64 kernels ticking the clock
> > twice its normal speed, unless I booted with pci=3Dnoacpi.
> >=20
> > This got fixed very recently I believe, in a 2.4.27-pre kernel.
>=20
> In which one exactly? Most likely it was an ACPI problem/fix.
> Len, do you remember fixing such an issue?

 It's fixed in 2.4.27-pre3 and later.  Coincidentally or not, it was
released only 4 days after I mentioned the bug on debian-amd64 and
discuss@x86-64.  I'd narrow it down further, but kernel.org doesn't have -bk
patches for 2.4, and I don't know where to download more fine-grained patch
versions.

 (BTW, 2.4.27-pre6 doesn't compile without declaring=20
struct task_struct *tsk;  in rwsem-spinlock.c:__rwsem_wake_one_writer.)

 Thanks for the help.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQC1AwUBQNKcrAWkmhLkWuRTAQLwmwUAjgrUtlcEpLjmtm0GjpGs/ow/Of3OcsaG
p92n5rXI7MxmCLqVYqz1wvT9krrxAg66h7kq311Rr5P9emfpw7l0Eym+AbQCLRMS
U89u8p+wArkzjYGHS+4K/+JQqgOi0pXiCs6OAmWaCIK9xDAPREP+oChmlARUFbsh
oiGdg5YCeyHucNPfMm8x7mMqtDr6DQVF5VH7rX6Gb8LsUUejvkB/ZQ==
=ddcf
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
