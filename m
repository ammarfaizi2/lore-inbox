Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUCEPeW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUCEPeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:34:22 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:53830 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S262626AbUCEPeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:34:20 -0500
Subject: Re: NFS problems with 2.6.4-rc1-mm2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1078430862.3793.5.camel@twins>
References: <1078430862.3793.5.camel@twins>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uamYV0suLpltGn550AQk"
Message-Id: <1078500855.3809.12.camel@twins>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 16:34:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uamYV0suLpltGn550AQk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm amazed at the total lack of information I managed to put into it ;-)

Its a dual athlon machine, nfs v3 over tcp. nfsd is run on vanilla
2.4.22 and reports no problems. (yes I know I should upgrade that
machine but its not exposed to the outside world).

anyway,. I played about a bit and it's in one of these patches:

#nfs-remove-XID-spinlock.patch
#nfs-misc-rpc-fixes.patch
#nfs-improved-writeback-strategy.patch
#nfs-simplify-config-options.patch
#nfs-fix-msync.patch
#nfs-mount-return-useful-errors.patch
#nfs-misc-minor-fixes.patch
#nfs-lockd-sync-01.patch
#nfs-lockd-sync-02.patch
#nfs-lockd-sync-03.patch
#nfs-lockd-sync-04.patch
#nfs-rpc-remove-redundant-memset.patch
#nfs-tunable-rpc-slot-table.patch
#nfs-short-read-fix.patch

I'll do a binary search through these patches and report those that seem
to cause the problem.

Peter Zijlstra


On Thu, 2004-03-04 at 21:07, Peter Zijlstra wrote:
> Hi,
>=20
> I've just build and booted 2.6.4-rc1-mm2, and mounting my NFS exports
> works. however when I try to unzip a file over those mount the process
> freezes over and any other IO to that mount results in more stuck
> processes. SIGKILL will not remove the processes, only reboot will
> manage.
>=20
> dmesg reports like:
>=20
> nfs: server 192.168.0.1 not responding, timed out
>=20
> which is total nonsense, because all other hosts on the network can
> access the exports just fine.
>=20
> I'm about to back out all nfs patches from the broken-out patch set to
> see what that does for me.
>=20
> Peter Zijlstra

--=-uamYV0suLpltGn550AQk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBASJ33tCb2m4B45HIRAjc4AJ0TMN3glXR5EHNca5vddZip//yANACfecuv
15BXV1r99mc0ny72gC9gvLU=
=5Z8y
-----END PGP SIGNATURE-----

--=-uamYV0suLpltGn550AQk--

