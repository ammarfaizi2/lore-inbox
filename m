Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWDMP0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWDMP0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 11:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWDMP0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 11:26:54 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:19328 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750845AbWDMP0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 11:26:53 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20060410012431.716d1000.akpm@osdl.org>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
Message-Id: <1144941999.2914.1.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Thu, 13 Apr 2006 17:26:39 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/04/2006 17:29:14,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/04/2006 17:29:17,
	Serialize complete at 13/04/2006 17:29:17
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TxvS0rl0C1noIiRDeY9d"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TxvS0rl0C1noIiRDeY9d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le lun 10/04/2006 =C3=A0 10:24, Andrew Morton a =C3=A9crit :
> Laurent Vivier <Laurent.Vivier@bull.net> wrote:
> >
> > Does the attached patch look like the thing you though about ?
>=20
> I guess so.  But it'll need a lot of performance testing on big SMP
> to work out what the impact is.

I made some tests with dbench:

IBM x440: 8 CPUs hyperthreaded =3D 16 CPUs (Xeon at 1.4 Ghz)

with percpu_counter:

        Throughput 188.365 MB/sec 16 procs
        Throughput 226.164 MB/sec 32 procs
        Throughput 142.913 MB/sec 64 procs

with atomic_long_t:

        Throughput 194.385 MB/sec 16 procs
        Throughput 237.273 MB/sec 32 procs
        Throughput 160.751 MB/sec 64 procs

Regards,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-TxvS0rl0C1noIiRDeY9d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBEPm2v9Kffa9pFVzwRAmofAKCu4OhsqN+i5CbHP/40ZUZqGnIyQgCfZDJJ
HZvqmeBsfRWbC8n8jz9mOUo=
=Hd4R
-----END PGP SIGNATURE-----

--=-TxvS0rl0C1noIiRDeY9d--

