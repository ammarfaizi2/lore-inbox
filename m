Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272448AbTGZKaD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 06:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272449AbTGZKaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 06:30:03 -0400
Received: from mx02.qsc.de ([213.148.130.14]:45018 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S272448AbTGZK37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 06:29:59 -0400
Date: Sat, 26 Jul 2003 12:45:06 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-ID: <20030726104506.GA663@gmx.de>
References: <20030725185325.GA3944@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20030725185325.GA3944@localhost.localdomain>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm2-O8 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2003 at 12:23:25AM +0530, Balram Adlakha wrote:
> >Hello,
>=20
> >I'm currently running at 2.6.0-test1-mm2-O8 and I wanted to give devfs a
> >shot. I recompiled the kernel with the following settings:
> >CONFIG_DEVFS_FS=3Dy
> >CONFIG_DEVFS_MOUNT=3Dy
> ># CONFIG_DEVFS_DEBUG is not set
>=20
> >As I read through the documentation (btw, devfs=3Dnomount is mentioned in
> >configure help but not in Documentation/filesystems/devfs/boot-options)
> >I got the understanding that this shouldn't make any difference to the
> >system right? After booting with this kernel there were lots of proper
> >devfs devices in my dmesg (host0/ide0... scsi0/...) however, the system
> >didn't came up (couldn't mount rootfs). It didn't even work when I
> >enabled CONFIG_DEVFS_MOUNT.
>=20
> >I'm not sure whether this is a bug in mount/nomount of devfs or if it's
> >somewhere my fault/setup (root on raid1, various lvm2 devices on raid1/0
> >devices)
>=20
> >Any help would be greatly appreciated.
>=20
>=20
> You need to change your /etc/fstab to reflect the new devfs device names,
> ex: "/dev/discs/disc0/part1" instead of "/dev/hda1". You can also use dev=
fsd (or some alternative) to make synlinks to the older devices and retain =
permissions etc... Also, without devfsd you cannot expect module autoloadin=
g as modules can't be automatically loaded when theres no device requesting=
 them (in this case the device simply doesn't exist until module is loaded)

wait a second, this is a dumb thing to do. I do not want to migrate over
to devfs yet. I wanted to give it a shot and look around a bit. What I
haad in mind was mounting it on /dev2 or similar. Enabling this option
and converting my whole system is not a migration path. That's just
plain luck (might be easy for plain ide/scsi disks, but whatabout
metadevices like lvm and raid?). It is written in the documentation that
devfs comes with most backwards compatibility. I expected there to be
things like /dev/md0 and such for compatibility.
OTOH what's CONFIG_DEVFS_MOUNT for then? If devices get named the other
way round I *have* to mount it anyway, haven't I? I think improvements
must happen here in order to make devfs usable.

--=20
Regards,

Wiktor Wodecki

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Iluy6SNaNRgsl4MRAkmtAJ9Sbmg9lFm+uJ2TKC9vbuX9tovI4wCeK8C0
dylxsigbLtsmEU+4+QVoONc=
=b6ck
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
