Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbUBYXxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbUBYXuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:50:37 -0500
Received: from ns.schottelius.org ([213.146.113.242]:3968 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S262274AbUBYXtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:49:02 -0500
Date: Thu, 26 Feb 2004 00:49:44 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: another hard disk broken or xfs problems?
Message-ID: <20040225234944.GD187@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Nathan Scott <nathans@sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040225220051.GA187@schottelius.org> <20040225223428.GD640@frodo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <20040225223428.GD640@frodo>
X-MSMail-Priority: (u_int) -1
X-Mailer: echo $message | gpg -e $sender  -s | netcat mailhost 25
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nathan Scott [Thu, Feb 26, 2004 at 09:34:28AM +1100]:
> > I am now using a brand new 40GB Hitachi hard disk for my notebook and
> > today I got the first problems:
> >=20
> >=20
> > Starting XFS recovery on filesystem: hda3 (dev: hda3)
> > Ending XFS recovery on filesystem: hda3 (dev: hda3)
> > VFS: Mounted root (xfs filesystem) readonly.
> > Mounted devfs on /dev
> > Freeing unused kernel memory: 156k freed
> > XFS mounting filesystem hda1
> > Starting XFS recovery on filesystem: hda1 (dev: hda1)
> > Ending XFS recovery on filesystem: hda1 (dev: hda1)
> > XFS mounting filesystem loop0
> > Starting XFS recovery on filesystem: loop0 (dev: loop0)
> > XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1589 of file fs/xfs/=
xfs_alloc.c.  Caller 0xc0198272
> > Call Trace: [<c0197151>]  [<c0198272>]  [<c0198272>]  [<c01c7fff>]  [<c=
01ee628>]  [<c01e5286>]  [<c01e5355>]  [<c01e6b04>]  [<c01d24fa>]  [<c01dd2=
cc>]  [<c01e83bd>]  [<c0203c60>]  [<c01d908f>]  [<c01f02c6>]  [<c02048e3>] =
 [<c02046c8>]  [<c0215517>]  [<c0185764>]  [<c015c835>]  [<c015c268>]  [<c0=
204890>]  [<c0204630>]  [<c015c4af>]  [<c0171ee8>]  [<c01721f4>]  [<c017204=
4>]  [<c01725ef>]  [<c010b34b>]=20
> > Ending XFS recovery on filesystem: loop0 (dev: loop0)
> > Adding 192772k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
> >=20
> >=20
> > I got this after a clean shutdown. Just tell me it's an xfs error and my
> > harddisk is fine...
>=20
> Filesystem recovery doesn't run after a clean shutdown...

That's what I assume(d), too.

> the "Starting/Ending XFS recovery" messages indicate that
> all of your filesystems were not unmounted by the look of
> it.

That's true and interesting, as I did a shutdown -o (poweroff) from minit, =
which
should have unmounted the partions. I'll retry this with -h (halt only)
this evening.

> [...]=20
> So, doesn't look like a hard disk error to me, and nor does it
> look like an XFS problem.  You should be able to run xfs_repair
> on your loopback file to fix the problem.

Will reboot in half an hour, but I think as the recovery was done, it
won't have any problems anymore.

There are still some questions open for me:

1. why is it an internal xfs error?
2. why does it print a call trace?
3. how can I find out what's wrong / what should I do when seeing call
   traces? And what should I've done before (adding debugging somewhere?)

Have a nice night,

Nico

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPTSXzGnTqo0OJ6QRAsFvAJ0c+aPavYe7XF4wTYq/AriUhL1OpgCeMoOg
JlykhKIznbXrEUF6aLjQLyo=
=JZIx
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
