Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265437AbUABJHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 04:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbUABJHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 04:07:15 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:55936 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265437AbUABJHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 04:07:13 -0500
Subject: Re: ext2 on a CD-RW
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, axboe@suse.de, packet-writing@suse.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <m2llorkuhn.fsf@telia.com>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com>
	 <20040101162427.4c6c020b.akpm@osdl.org>  <m2llorkuhn.fsf@telia.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aSMuloVyP2kmDoPUHlE8"
Organization: Red Hat, Inc.
Message-Id: <1073034412.4429.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Jan 2004 10:06:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aSMuloVyP2kmDoPUHlE8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-02 at 02:30, Peter Osterlund wrote:

> The packet writing code has the restriction that a bio must not span a
> packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
> to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
> returns 2048, which is less than len, which is 4096 if the whole page
> is mapped, so the bio_add_page() call fails.

devicemapper has similar restrictions for raid0 format; in that case
it's device-mappers job to split the page/bio. Just as it is UDF's task
to do the same I suspect...


--=-aSMuloVyP2kmDoPUHlE8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/9TSsxULwo51rQBIRAh2qAJ9xWevQsSBzVVq/hcv2FrH6OQkLlwCfa8+i
o7gh8z7PRbUxO/v3xs8tyes=
=152j
-----END PGP SIGNATURE-----

--=-aSMuloVyP2kmDoPUHlE8--
