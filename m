Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbTCFQLx>; Thu, 6 Mar 2003 11:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268039AbTCFQLx>; Thu, 6 Mar 2003 11:11:53 -0500
Received: from nef.ens.fr ([129.199.96.32]:12808 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S268033AbTCFQLw>;
	Thu, 6 Mar 2003 11:11:52 -0500
Date: Thu, 6 Mar 2003 17:22:08 +0100
From: Nicolas George <nicolas.george@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/mem and highmem
Message-ID: <20030306162208.GA14596@clipper.ens.fr>
Mail-Followup-To: Nicolas George <nicolas.george@ens.fr>,
	linux-kernel@vger.kernel.org
References: <20030303160050.GA17182@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20030303160050.GA17182@clipper.ens.fr>
User-Agent: Mutt/1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le tridi 13 vent=F4se, an CCXI, Nicolas George a =E9crit=A0:
> Is there any hope to have access to the highmem through /dev/mem, or a
> similar device? Or did I miss an already existing method?

Since nobody answered, I suppose that at least I did not miss something
obvious. Si I tried to write it.

What I understoud is that the way to access the byte at physical address
a is to kmap(mem_map[o >> PAGE_SHIFT]), and access at offet
o % PAGE_SHIFT (and then kunmap it). Perharps it is very ix86-centered.
Since it did not crash my PC, and it gave the same data as /dev/mem, I
think I was not totally wrong.

The code is available at <URL:
http://www.eleves.ens.fr/home/george/info/prg/highmem.c >. The write
part is not yet done, but since it is very similar to read, it should be
really straightforward. Nevertheless I will wait a bit before trying it.

Regards,

--=20
  Nicolas George

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (SunOS)

iD8DBQE+Z3WwsGPZlzblTJMRAnNqAKCPjh+RoXF0LyVLyatdiQkGs4LGOQCeIH40
PYEYkencocbLZDRCEG+pFaM=
=HxGI
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
