Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268680AbUHTTHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268680AbUHTTHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268668AbUHTTER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:04:17 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:19089 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S268667AbUHTS77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:59:59 -0400
Date: Fri, 20 Aug 2004 12:59:56 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Theodore Ts'o" <tytso@mit.edu>,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
Message-ID: <20040820185956.GV8967@schnapps.adilger.int>
Mail-Followup-To: Jean-Luc Cooke <jlcooke@certainkey.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	"David S. Miller" <davem@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Theodore Ts'o <tytso@mit.edu>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net> <20040820175952.GI5806@certainkey.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o0y1lerN6xYE2ROn"
Content-Disposition: inline
In-Reply-To: <20040820175952.GI5806@certainkey.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o0y1lerN6xYE2ROn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Aug 20, 2004  13:59 -0400, Jean-Luc Cooke wrote:
> Is there a reason why get_random_bytes() is unsuitable?
>=20
> Keeping the number of PRNGs in the kernel to a minimum should a goal we c=
an
> all share.

For some uses a decent PRNG is enough, and the overhead of get_random_bytes=
()
is much too high.  We've needed something like this for a long time (someth=
ing
that gives decenly uniform numbers) and hacks to use useconds/cycles/etc do
not cut it.  I for one welcome a simple in-kernel interface to
e.g. get_urandom_bytes() (or net_random() as this is maybe inappropriately
called) that is only pseudo-random but fast and efficient.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--o0y1lerN6xYE2ROn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBJkospIg59Q01vtYRAl5VAKCVp4g4/om0QnxQyojGH+LNyAp7kgCfVgWa
f2ociyLHiIpWvcmGR1Lnb7Y=
=xfaR
-----END PGP SIGNATURE-----

--o0y1lerN6xYE2ROn--
