Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTHZRdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTHZRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:33:46 -0400
Received: from gate.in-addr.de ([212.8.193.158]:20889 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S261249AbTHZRcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:32:54 -0400
Date: Tue, 26 Aug 2003 19:30:14 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Neil Brown <neilb@cse.unsw.edu.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: md: bug in file raid5.c, line 540 was: Re: Linux 2.4.22-rc1
Message-ID: <20030826173014.GA12071@marowsky-bree.de>
References: <Pine.LNX.4.44.0308051543130.12501-100000@logos.cnet> <20030819202629.GA4083@matchmail.com> <20030819210913.GC4083@matchmail.com> <16197.43294.828878.586018@gargle.gargle.HOWL> <20030822155039.GA6980@marowsky-bree.de> <20030822212659.GK1040@matchmail.com> <20030823152826.GB9239@marowsky-bree.de> <20030826172257.GE16831@matchmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20030826172257.GE16831@matchmail.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2003-08-26T10:22:57,
   Mike Fedyk <mfedyk@matchmail.com> said:

> Is there any way to get it working on one partition, or does it require at
> least two backing store block (an actual physical disk) devices that a bu=
nch
> of loop devices point to?  (I'm thinking of the raid[15] case).

md will work just fine - although with much reduced performance - if
setup on top of partitions on the same disk. If all you have is a single
physical disk, you can create the loop devices accordingly. For
multipath testing, I have used LVM logical volumes + loop devices to
simulate such, or used UML and fed it with a bunch of block devices (LVs
or loop devices) from the host.

(The mp-test.sh script actually knows how to create arbitary numbers of
loop devices for multipath testing, which in turn uncovered a bug in our
loop handling, which axboe took care of...)


Sincerely,
    Lars Marowsky-Br=E9e <lmb@suse.de>

--=20
High Availability & Clustering		ever tried. ever failed. no matter.
SuSE Labs				try again. fail again. fail better.
Research & Development, SuSE Linux AG		-- Samuel Beckett


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/S5kmudf3XQV4S2cRAv9HAJ93OcIt03+TCW4vsctr/taQkutKAgCgg0ox
5XjEVcaKhBTAxsqNQi+kVgw=
=zirE
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
