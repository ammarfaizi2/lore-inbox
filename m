Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUFIUrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUFIUrZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUFIUrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:47:25 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:16320 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S265970AbUFIUrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:47:05 -0400
Date: Wed, 9 Jun 2004 22:42:35 +0200
From: linux-kernel-owner@vger.kernel.org
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.6.X File locking on NFS stil broken
Message-ID: <20040609204235.GC29969@puettmann.net>
References: <20040609191758.GA29969@puettmann.net> <1086813672.4078.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ATYltwmfWCpDp8Ax"
Content-Disposition: inline
In-Reply-To: <1086813672.4078.24.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Scanner: exiscan *1BY9v7-00049i-00*rIEJL3GpktQ* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ATYltwmfWCpDp8Ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2004 at 04:41:12PM -0400, Trond Myklebust wrote:
=20
> That script works fine for me: I haven't seen any hangs on locking in
> any of the 2.6 series kernels so far.

If I mount it with nolock it runs fine too ;-). I have not enough C
knowledge to see whree the bug is.

>=20
> What does 'rpcinfo -p' show on the client and server?
>=20

Server :


sslnfs:~# rpcinfo -p=20
   Program Vers Proto   Port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp    759  status
    100024    1   tcp    762  status
    100003    2   udp   2049  nfs
    100003    3   udp   2049  nfs
    100021    1   udp  32779  nlockmgr
    100021    3   udp  32779  nlockmgr
    100021    4   udp  32779  nlockmgr
    100005    1   udp    901  mountd
    100005    1   tcp    904  mountd
    100005    2   udp    901  mountd
    100005    2   tcp    904  mountd
    100005    3   udp    901  mountd
    100005    3   tcp    904  mountd

Client:

root@www10:[~] > rpcinfo -p
   Program Vers Proto   Port
    100000    2   tcp    111  portmapper
    100000    2   udp    111  portmapper
    100021    1   udp  32768  nlockmgr
    100021    3   udp  32768  nlockmgr
    100021    4   udp  32768  nlockmgr
    100024    1   udp    938  status
    100024    1   tcp    941  status


                Ruben


--=20
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net

--ATYltwmfWCpDp8Ax
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAx3Y7gHHssbUmOEIRAtG6AJ4wZcbrg9YltYW/v7ZvLIooEhmtzwCgiaLO
yywpLLOYaM+OvkAxBSQ0UPo=
=GeVV
-----END PGP SIGNATURE-----

--ATYltwmfWCpDp8Ax--
