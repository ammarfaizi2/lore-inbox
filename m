Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262748AbTJYRmC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 13:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTJYRmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 13:42:02 -0400
Received: from komoseva.globalnet.hr ([213.149.32.250]:8463 "EHLO
	komoseva.globalnet.hr") by vger.kernel.org with ESMTP
	id S262748AbTJYRl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 13:41:58 -0400
Date: Sat, 25 Oct 2003 19:41:02 +0200
From: Vid Strpic <vms@bofhlet.net>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: *FAT problem in 2.6.0-test8
Message-ID: <20031025174102.GE1143@home.bofhlet.net>
Mail-Followup-To: Vid Strpic <vms@bofhlet.net>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org
References: <20031024103225.GC1046@home.bofhlet.net> <20031024185953.GA9265@win.tue.nl> <87ismdoc2s.fsf@devron.myhome.or.jp> <20031025105559.GD1143@home.bofhlet.net> <87wuatmfnk.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <87wuatmfnk.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux 2.6.0-test8
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled Sep 18 2003 13:09:52)
X-I-came-from: scary devil monastery
X-Politics: UNIX fundamentalist
X-Face: -|!t[0Pql@=P`A=@?]]hx(Oh!2jK='NQO#A$ir7jYOC*/4DA~eH7XpA/:vM>M@GLqAYUg9$ n|mt)QK1=LZBL3sp?mL=lFuw3V./Q&XotFmCH<Rr(ugDuDx,mM*If&mJvqtb3BF7~~Guczc0!G0C`2 _A.v7)%SGk:.dgpOc1Ra^A$1wgMrW=66X|Lyk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2003 at 01:43:43AM +0900, OGAWA Hirofumi wrote:
> Vid Strpic <vms@bofhlet.net> writes:
> > > It looks like it doesn't conform to Microsoft's or SmartMedia's
> > > specifications.
> > > Yes. It will be important to know how it was formated.=20
> > Well, I really don't know if it was formatted when I bought it, 2 years
> > ago.  What puzzles me, is that 2.4 mounts it normally...
> Yes, 2.4 doesn't check it field.

Obviously.  I compared the drivers 2.4.22 -> test8, and diff -u is about
1000 lines, a lot.

> > This is the hex dump of begginning (problematic no-name 64Mb card):
> > 0000000: e900 002a 6453 777c 4948 4300 0220 0100  ...*dSw|IHC.. ..
> > 0000010: 0200 0100 00f8 0c00 2000 0800 3700 0000  ........ ...7...
> > 0000020: c9f3 0100 0000 0000 0000 0000 0000 0000  ................
> > 0000030: 0000 0000 0000 4641 5431 3220 2020 0000  ......FAT12   ..
> > 0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> > And this is the SanDisk 32Mb card which mounts normally under 2.6:
> > 0000000: e900 0020 2020 2020 2020 2000 0220 0100  ...        .. ..
> > 0000010: 0200 01dd f9f8 0600 1000 0800 2300 0000  ............#...
> > 0000020: 0000 0000 0000 2900 0000 004e 4f20 4e41  ......)....NO NA
> > 0000030: 4d45 2020 2020 4641 5431 3220 2020 0000  ME    FAT12   ..
> > 0000040: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> On these FAT formats, the target field should be offset 512.=20

Hm.

> > Maybe I should try to reformat the card in the reader?  My camera has
> > 'delete all images' but no 'format card' I'm sorry...
> Um.. Could you please test to reformat? Of course, do it after backup
> the your disk image.

Backups were done yesterday, I'm on the backup-freak side ;)

Just reformatted, it works - used mkdosfs -F 12 -v /dev/sda1, camera
reads the card and can write picture on it...

Reformatted card now can be mounted by standard fat.ko ...

--=20
           vms@bofhlet.net, IRC:*@Martin, /bin/zsh. C|N>K
Linux moria 2.6.0-test8 #1 Mon Oct 20 16:19:20 CEST 2003 i686
 19:30:50 up 1 day,  2:14,  1 user,  load average: 0.97, 1.51, 0.87
Najkraci C program se sastoji od osam znakova: main(){} (C)Hrv, 2002.

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/mrWuq1AzG0/iPGMRAp3MAKChC5/gBUDirLw7KdNP6SReUchimQCeMsoU
NWW+Fequpnz1vVi+z8Pj54w=
=jtk+
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
