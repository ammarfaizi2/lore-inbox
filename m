Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWDROJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDROJo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 10:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbWDROJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 10:09:44 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:20373 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932099AbWDROJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 10:09:42 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       Mingming Cao <cmm@us.ibm.com>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1145345407.2976.13.camel@laptopd505.fenrus.org>
References: <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <20060410012431.716d1000.akpm@osdl.org>
	 <1144941999.2914.1.camel@openx2.frec.bull.fr>
	 <20060417210746.GB3945@localhost.localdomain>
	 <1145308176.2847.90.camel@laptopd505.fenrus.org>
	 <20060417213201.GC3945@localhost.localdomain>
	 <1145344481.17767.1.camel@openx2.frec.bull.fr>
	 <1145345407.2976.13.camel@laptopd505.fenrus.org>
Message-Id: <1145369368.17767.15.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Tue, 18 Apr 2006 16:09:28 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/04/2006 16:12:10,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/04/2006 16:12:11,
	Serialize complete at 18/04/2006 16:12:11
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6YxwhXvQ+NfvN+n4OTzs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6YxwhXvQ+NfvN+n4OTzs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mar 18/04/2006 =C3=A0 09:30, Arjan van de Ven a =C3=A9crit :
> On Tue, 2006-04-18 at 09:14 +0200, Laurent Vivier wrote:
> > Le lun 17/04/2006 =C3=A0 23:32, Ravikiran G Thirumalai a =C3=A9crit :
> > > On Mon, Apr 17, 2006 at 11:09:36PM +0200, Arjan van de Ven wrote:
> > > > On Mon, 2006-04-17 at 14:07 -0700, Ravikiran G Thirumalai wrote:
> > > > >=20
> > > > >=20
> > > > > I ran the same tests on a 16 core EM64T box very similar to the o=
ne
> > > > > you ran
> > > > > dbench on :). Dbench results on ext3 varies quite a bit.  I could=
n't
> > > > > get=20
> > > > > to a statistically significant conclusion  For eg,
> > > >=20
> > > >=20
> > > > dbench is not a good performance benchmark. At all. Don't use it fo=
r
> > > > that ;)
> > >=20
> > > Agreed. (I did not mean to use it in the first place :).  I was just =
trying=20
> > > to verify the benchmark results posted earlier)
> > >=20
> > > Thanks,
> > > Kiran
> >=20
> > What is the good performance benchmark to know if we should use atomic_=
t
> > instead of percpu_counter ?
>=20
> you probably want something like postal/postmark instead or so (although
> that's not ideal either), at least that's reproducable

I made some tests with kernbench too:

***** With percpu_counter:

16 cpus found
Cleaning source tree...
Caching kernel source in ram...
No old config found, using defconfig
Making mrproper
Making defconfig...
Kernel 2.6.16
Performing 5 runs of
make -j 8
make -j 64
make -j

All data logged to kernbench.log
Warmup run...
Half load -j 8 run number 1...
Half load -j 8 run number 2...
Half load -j 8 run number 3...
Half load -j 8 run number 4...
Half load -j 8 run number 5...
Average Half load -j 8 Run (std deviation):
Elapsed Time 120.68 (0.425558)
User Time 583.488 (0.54099)
System Time 84.716 (0.345948)
Percent CPU 553 (2)
Context Switches 13146.4 (66.3272)
Sleeps 26998.2 (297.078)

Optimal load -j 64 run number 1...
Optimal load -j 64 run number 2...
Optimal load -j 64 run number 3...
Optimal load -j 64 run number 4...
Optimal load -j 64 run number 5...
Average Optimal load -j 64 Run (std deviation):
Elapsed Time 86.496 (0.335827)
User Time 809.699 (238.449)
System Time 103.137 (19.423)
Percent CPU 945.3 (413.544)
Context Switches 32549.5 (20471.2)
Sleeps 34308 (7795.17)

Maximal load -j run number 1...
Maximal load -j run number 2...
Maximal load -j run number 3...
Maximal load -j run number 4...
Maximal load -j run number 5...
Average Maximal load -j Run (std deviation):
Elapsed Time 86.47 (0.321636)
User Time 883.568 (219.647)
System Time 108.728 (17.597)
Percent CPU 1073.8 (381.226)
Context Switches 31920.4 (16443.3)
Sleeps 30472.5 (8402.01)

***** With atomic_long_t

16 cpus found
Cleaning source tree...
Caching kernel source in ram...
No old config found, using defconfig
Making mrproper
Making defconfig...
Kernel 2.6.16
Performing 5 runs of
make -j 8
make -j 64
make -j

All data logged to kernbench.log
Warmup run...
Half load -j 8 run number 1...
Half load -j 8 run number 2...
Half load -j 8 run number 3...
Half load -j 8 run number 4...
Half load -j 8 run number 5...
Average Half load -j 8 Run (std deviation):
Elapsed Time 120.468 (0.724134)
User Time 581.226 (0.497624)
System Time 84.358 (0.45417)
Percent CPU 551.8 (3.19374)
Context Switches 13085.6 (108.579)
Sleeps 26965.8 (189.384)

Optimal load -j 64 run number 1...
Optimal load -j 64 run number 2...
Optimal load -j 64 run number 3...
Optimal load -j 64 run number 4...
Optimal load -j 64 run number 5...
Average Optimal load -j 64 Run (std deviation):
Elapsed Time 86.25 (0.263439)
User Time 805.828 (236.752)
System Time 102.262 (18.8792)
Percent CPU 942.7 (412.059)
Context Switches 32339.7 (20299.6)
Sleeps 34301.9 (7741.15)

Maximal load -j run number 1...
Maximal load -j run number 2...
Maximal load -j run number 3...
Maximal load -j run number 4...
Maximal load -j run number 5...
Average Maximal load -j Run (std deviation):
Elapsed Time 85.868 (0.757905)
User Time 879.129 (218.053)
System Time 107.847 (17.2136)
Percent CPU 1072.73 (381.349)
Context Switches 31854.5 (16297.1)
Sleeps 30436.2 (8399.98)


Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-6YxwhXvQ+NfvN+n4OTzs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBERPMY9Kffa9pFVzwRAhOFAKCC9YynnulfK5F8deBhKLSZtqredQCfbyqI
8LlLDJReIQ6WLMvsgip5wGw=
=u+3s
-----END PGP SIGNATURE-----

--=-6YxwhXvQ+NfvN+n4OTzs--

