Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUCFLLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 06:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbUCFLLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 06:11:08 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:29007 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261651AbUCFLK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 06:10:56 -0500
Subject: Re: NFS problems with 2.6.4-rc1-mm2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040305143727.5397d76e.akpm@osdl.org>
References: <1078430862.3793.5.camel@twins> <1078500855.3809.12.camel@twins>
	 <20040305143727.5397d76e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fAs5IOJGQ+tiq81UY66k"
Message-Id: <1078571454.3811.3.camel@twins>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 12:10:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fAs5IOJGQ+tiq81UY66k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The bad guy is:=20
	nfs-tunable-rpc-slot-table.patch
without that patch nfs works fine for me.

As said I use NFSv3 over TCP, and its a SMP machine
that has the problem, I haven't tried any UP box.

Peter

On Fri, 2004-03-05 at 23:37, Andrew Morton wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> >
> > I played about a bit and it's in one of these patches:
> >=20
> > #nfs-remove-XID-spinlock.patch
> > #nfs-misc-rpc-fixes.patch
> > #nfs-improved-writeback-strategy.patch
> > #nfs-simplify-config-options.patch
> > #nfs-fix-msync.patch
> > #nfs-mount-return-useful-errors.patch
> > #nfs-misc-minor-fixes.patch
> > #nfs-lockd-sync-01.patch
> > #nfs-lockd-sync-02.patch
> > #nfs-lockd-sync-03.patch
> > #nfs-lockd-sync-04.patch
> > #nfs-rpc-remove-redundant-memset.patch
> > #nfs-tunable-rpc-slot-table.patch
> > #nfs-short-read-fix.patch
> >=20
> > I'll do a binary search through these patches and report those that see=
m
> > to cause the problem.
>=20
> Thanks, that would be muchly appreciated.

--=-fAs5IOJGQ+tiq81UY66k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBASbG+tCb2m4B45HIRAhzqAJ44EHXClVxw1G7BUdd2u0/CII9qqQCff+/v
Dk16abB5fqq5Cyzn0fmjiM4=
=f3n0
-----END PGP SIGNATURE-----

--=-fAs5IOJGQ+tiq81UY66k--

