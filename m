Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTJXLJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 07:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTJXLJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 07:09:21 -0400
Received: from [161.53.89.100] ([161.53.89.100]:54407 "EHLO www3.purger.com")
	by vger.kernel.org with ESMTP id S262139AbTJXLJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 07:09:18 -0400
Date: Fri, 24 Oct 2003 12:32:26 +0200
From: Vid Strpic <vms@bofhlet.net>
To: linux-kernel@vger.kernel.org
Subject: *FAT problem in 2.6.0-test8
Message-ID: <20031024103225.GC1046@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test8
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Aug 28 2003 11:57:19)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi...


Yesterday, I just wanted to download some pics from a Smartmedia card
from my camera.  I put the card into the reader (USB Mass Storage Flash
Card Reader, Manufacturer: EZ, Serial Number: 9876543210ABCDEF, driver
is usb-storage and working well now, I had problems earlier), but the
kernel doesn't recognize FAT filesystem on the card...

Oct 23 17:19:45 moria kernel: VFS: Can't find a valid FAT filesystem on dev=
 sda1.
Oct 23 17:28:20 moria kernel: VFS: Can't find a valid FAT filesystem on dev=
 loop0.

The second line was, I dd-ed the card onto a disk file and tried to
mount that... no luck.

More messages:

Oct 23 17:19:01 moria kernel: FAT: invalid first entry of FAT (0xff8 !=3D 0=
x0)


Luckily, I have a 2.4 machine around, I tried to mount the resulting
disk image (NFS) on that machine (-o loop ofcourse), and it worked
perfectly... kernel is 2.4.22.

On 2.6 machine, modules loaded were fat and vfat... fstab entry in
question is:

/dev/sda1          /mnt/sm      vfat        user,noauto,owner,rw   1 1


And yes, I tried mounting the filesystem in question as fat _and_
vfat... nothing works.

Not that I need FAT filesystems so very much, but I need them here and
there, and it would be a very NOT nice thing not to have drivers working
:(

Any ideas what's wrong?

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test8 #1 Mon Oct 20 16:19:20 CEST 2003 i686
 12:24:38 up 11:10,  1 user,  load average: 0.74, 0.33, 0.25

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mP+5q1AzG0/iPGMRAncmAJ0QcLbr8TfM/zq8Ge5hX+NTE0jy6ACeO3/A
wB+arCNNW6GsD23iYQRyoTc=
=HwZm
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
