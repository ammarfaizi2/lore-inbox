Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSHAMXZ>; Thu, 1 Aug 2002 08:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318865AbSHAMXZ>; Thu, 1 Aug 2002 08:23:25 -0400
Received: from [213.69.232.58] ([213.69.232.58]:15626 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318762AbSHAMXS>;
	Thu, 1 Aug 2002 08:23:18 -0400
Date: Thu, 1 Aug 2002 13:50:47 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Message-ID: <20020801115047.GB1577@schottelius.org>
References: <20020731175743.GB1249@schottelius.org> <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020730172158.02014160@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Anton Altaparmakov [Tue, Jul 30, 2002 at 05:28:05PM +0100]:
> At 18:57 31/07/02, Nico Schottelius wrote:
> >Just wanted to report of the following problems:
> >
> >Other bugs:
> >- ntfs sometimes crashes the system: working on a loopback file caused
> >  ntfs to report corruptions in the file system and this hangs system
> >  completly.
> >
> >If you need more informations, just tell me. Currently I've some time
> >to debug parts of the kernel.
>=20
> I am interested in this ntfs report. Which way round was the loopback fil=
e?=20
> I.e. did you mount: mount -t ntfs -o loop somefile_on_a_non_ntfs_partitio=
n=20
> or did you mount: mount -t some_file_system -o loop=20
> somefile_on_an_ntfs_partion?

mount -t ntfs -o loop file.sav-on-ext2-or-on-xfs[when using 2.4.18] /mnt

> Can you send me the errors produced? If there is an oops, please decode a=
nd=20
> send it, too.

The test I did was the following [may I call that test ?]:

cd /mnt; mkdir /ntfs_on_ext3; cp -r * /ntfs_on_ext3
While copying, with or without debug, the system hangs, but top only reports
7 % cpu load.

Copying the files results in a input / output error.

It has never been an oops and actually 2.5.29 does _not_ hangup anymore!
Still it stops to copy the files and aborts.
I am currently retrying with debug enabled...

> Also it may be useful to have the debug output from ntfs (depending on wh=
at=20
> the errors/oops say - they may be sufficient to pinpoint the problem), i.=
e.=20
> enable debugging when configuring the kernel, and then as root do: echo 1=
 >=20
> /proc/sys/fs/ntfs-debug. Note this will absolutely flood you with debug=
=20
> output so the system will run slow as hell... So it is best to only enabl=
e=20
> debug messages just before the error occurs if that is possible.

oops. forget that above. Oh yes, ntfs is really reporting much.
You can find the output at ftp.schottelius.org:/pub/tmp, it's about
600k compressed.

I am really happy that this time the cp did not hald my system!

Nico

p.s.: what was the maximal file size on ext3 ? I just gunzipped a 4gb
      file (the ntfs image the whole story is about), which could not
      be transfered through scp/ftp in this size...

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SSCXtnlUggLJsX0RAkwFAJ0TpHpWjYh18zJnfNg+//7UglVDiACfa91T
SicmcgxmIld3dD+/zZRf548=
=jJka
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
