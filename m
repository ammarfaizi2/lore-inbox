Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270183AbUJTMVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270183AbUJTMVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 08:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270125AbUJTMVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 08:21:41 -0400
Received: from relay.snowman.net ([66.92.160.56]:31760 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S269880AbUJTMUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:20:40 -0400
Date: Wed, 20 Oct 2004 08:21:08 -0400
From: Stephen Frost <sfrost@snowman.net>
To: LKML <linux-kernel@vger.kernel.org>,
       Vserver <vserver@list.linux-vserver.org>
Subject: Re: [Vserver] PROBLEM: Oops in log_do_checkpoint, using vserver
Message-ID: <20041020122108.GC12780@ns.snowman.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Vserver <vserver@list.linux-vserver.org>
References: <20041018032511.GY21419@ns.snowman.net> <20041018115523.GA2352@mail.13thfloor.at> <20041018122025.GA28813@ns.snowman.net> <20041019220100.GB12780@ns.snowman.net> <20041020024342.GA9260@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline
In-Reply-To: <20041020024342.GA9260@mail.13thfloor.at>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 08:16:42 up 263 days,  7:15, 12 users,  load average: 0.06, 0.27, 0.26
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Herbert Poetzl (herbert@13thfloor.at) wrote:
> On Tue, Oct 19, 2004 at 06:01:00PM -0400, Stephen Frost wrote:
> > Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:361:=20
> > "drop_count !=3D 0 || cleanup_ret !=3D 0"
>=20
> you can split up this assertion into
>=20
>  - drop_count !=3D 0
>  - cleanup_ret !=3D 0
>=20
> and fail on that (or just output those values
> before you panic) ... this might give some
> deeper insight into the issue ...

Hmm, that's a good thought, though I have to say I'd really like to get
a comment from the ext3 folks.  This is also a production server, so I'd
kind of like to minimize the downtime. :)

> > If there's anything else I can do to help get this resolved, please let
> > me know..  This is the only problem I'm having with this server now,
> > other than this it's behaving pretty nicely. :)
>=20
> maybe until it gets fixed, mounting the ext3
> without journal might help here?

Yeah, I've mounted it as ext2 for now.  It's been working fine so far.

	Stephen

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBdlgzrzgMPqB3kigRApfOAKCPv6q4ds/sCLBw4B1UI4X8tsGnOwCffJWO
nnqQRQeA6+ZO02mNz4DI1PE=
=muVl
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--
