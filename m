Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269370AbUIIIXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269370AbUIIIXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269371AbUIIIXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:23:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48266 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269370AbUIIIXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:23:15 -0400
Subject: Re: bug in md write barrier support?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
       Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040909080612.GJ1737@suse.de>
References: <20040903172414.GA6771@lst.de>
	 <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de>
	 <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de>
	 <1094650500.11723.32.camel@localhost.localdomain>
	 <20040908154608.GN2258@suse.de>
	 <1094682098.12280.19.camel@localhost.localdomain>
	 <20040909080612.GJ1737@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LmWSUEbwzbhuqgD06Qnz"
Organization: Red Hat UK
Message-Id: <1094718179.2801.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 10:22:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LmWSUEbwzbhuqgD06Qnz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Precisely, it's always possible to just drop queueing depth to zero at
> that point. If I2O really does reorder around the cache flush (this
> seems broken...),

why does this seem broken? semantics of "cache flush guarantees that all
io submitted prior to it hits the spindle" are quite sane imo; no
guarantee of later submitted IO.. compare the unix "sync" command; same
level of semantics.


--=-LmWSUEbwzbhuqgD06Qnz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBQBLjxULwo51rQBIRAtksAJ4wbVgaGhejqHdqqiiWbi3pfVftpQCgiSGl
St9goKvy9wfWFXEKNTxyfD0=
=XbEa
-----END PGP SIGNATURE-----

--=-LmWSUEbwzbhuqgD06Qnz--

