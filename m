Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbUKSAUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUKSAUY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 19:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUKSASr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 19:18:47 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:31874 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261205AbUKSAPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 19:15:50 -0500
Date: Thu, 18 Nov 2004 17:15:46 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: 7eggert@nurfuerspam.de
Cc: Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041119001546.GK1974@schnapps.adilger.int>
Mail-Followup-To: 7eggert@nurfuerspam.de,
	Werner Almesberger <wa@almesberger.net>, linux-kernel@vger.kernel.org
References: <fa.ev73q5c.ejcnom@ifi.uio.no> <fa.es1mdq5.76ib8j@ifi.uio.no> <E1CUtCE-0000us-00@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline
In-Reply-To: <E1CUtCE-0000us-00@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 18, 2004  21:48 +0100, Bodo Eggert wrote:
> You'll have some precompiled binaries causing trouble, while other
> precompiled binaries will be killed while you want them to stay alife.
> Sometimes you'll have the same binary (e.g. perl or java) running a
> "notme"-task like watching the log for intrusion while at the same time
> processing a very large image.
>=20
> The best solution I can think of is attaching a kill priority (similar to
> the nice value). Before killing, this value would be added to lg_2(memsiz=
e),
> and the least desirable process would "win", even if it's sshd running wi=
ld.
>=20
> For the trashing problem: I like the idea of sending a signal to stop the
> process, but it should rather be a request to stop that can be caught by
> the process. A SETI-like task could save its workset and free the memory
> instead, a browser would discard it's memory cache and pause loading
> Images for the sites etc.

Sounds familiar.  AIX has had this for years.  "SIGDANGER" can be
caught by applications which care to register a handler, but is
otherwise fatal.  Usage scenarios are exactly as proposed above.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBnTsxpIg59Q01vtYRAsqxAKCkfg+DzCoYQbU8XdELPLHwQ6rzhwCfVIwk
MyJrkqh1CBgk5JpmsNkxxFM=
=l4fx
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--
