Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUJSWS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUJSWS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269817AbUJSWSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:18:11 -0400
Received: from relay.snowman.net ([66.92.160.56]:43534 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S268745AbUJSWAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:00:33 -0400
Date: Tue, 19 Oct 2004 18:01:00 -0400
From: Stephen Frost <sfrost@snowman.net>
To: LKML <linux-kernel@vger.kernel.org>,
       Vserver <vserver@list.linux-vserver.org>
Subject: Re: [Vserver] PROBLEM: Oops in log_do_checkpoint, using vserver
Message-ID: <20041019220100.GB12780@ns.snowman.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Vserver <vserver@list.linux-vserver.org>
References: <20041018032511.GY21419@ns.snowman.net> <20041018115523.GA2352@mail.13thfloor.at> <20041018122025.GA28813@ns.snowman.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20041018122025.GA28813@ns.snowman.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 17:56:07 up 262 days, 16:55, 12 users,  load average: 0.13, 0.18, 0.17
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Frost (sfrost@snowman.net) wrote:
> * Herbert Poetzl (herbert@13thfloor.at) wrote:
> > have seen that too, once in a while, but there where
> > some changes in 2.6.9, so maybe trying 2.6.9-rc4
> > (or soon final) with vs1.9.3-rc3 (not much changed
> > here, see delta for details) would be a good check
>=20
> Ok.  I had been planning on moving to 2.6.9 and 1.9.3 as soon as both
> were final.  Guess I can try the RC releases though. :)

Alright, I got the same oops w/ 2.6.9 and vs1.9.3-rc3:

Assertion failure in log_do_checkpoint() at fs/jbd/checkpoint.c:361: "drop_=
count !=3D 0 || cleanup_ret !=3D 0"

I noticed someone else had this problem too:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D123137

I also followed up on that w/ my oops from 2.6.8.1.

I also upgraded to 0.30.195, though I don't think that (or vserver in
general, really) is related to this oops.

If there's anything else I can do to help get this resolved, please let
me know..  This is the only problem I'm having with this server now,
other than this it's behaving pretty nicely. :)

	Thanks,

		Stephen

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBdY6crzgMPqB3kigRAlzyAJ9NT/FzMJfq9ynD9ohgcZq/Xrcd/gCfTa6H
LonVHWL84D9jLcIDqAtePsc=
=SpMl
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
