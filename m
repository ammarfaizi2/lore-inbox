Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSJ2SvW>; Tue, 29 Oct 2002 13:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSJ2SvW>; Tue, 29 Oct 2002 13:51:22 -0500
Received: from winch-as3-47.win.org ([204.184.55.47]:11392 "EHLO
	SpacedOut.fries.net") by vger.kernel.org with ESMTP
	id <S261973AbSJ2SvV>; Tue, 29 Oct 2002 13:51:21 -0500
Date: Tue, 29 Oct 2002 13:00:29 -0600
From: David Fries <dfries@mail.win.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: ext3 dies without inodes
Message-ID: <20021029190029.GA27062@spacedout.fries.net>
References: <200209261355.g8QDtRg16986@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <200209261355.g8QDtRg16986@sisko.scot.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm runnig 2.4.19 and Debian (but I compile my own kernel from the
sources).  ext3 is forcing the block device to be read only when I run
out of inodes, and the only way out is reboot (that I could tell).
This is wrose than a good deal of kernel panics I've had.  Is
2.4.20prewhatever any better with reguard to this error?

My system is running low on inodes (my fault), and back when I was
using ext2 everything was fine, I would run out, the kernel would give
the message about no more space on disk for everything that needed an
inode until I freed up some.  With ext3 I get one message saying no
more space on disk and then everything else gives, readonly file
system.

After I hit the problem accidently, I verified running out of inodes
was the problem on purpose.  I would hate to think that I had to
reboot everytime I filled up my harddrive, and it is an equally bad
behavior to reboot when I run out of inodes.

Here is some dmesg output.
EXT3-fs error (device ide0(3,2)) in ext3_new_inode: error 28
Aborting journal on device ide0(3,2).
Remounting filesystem read-only
EXT3-fs error (device ide0(3,2)) in ext3_create: IO failure
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
ext3_abort called.
EXT3-fs abort (device ide0(3,2)): ext3_remount: Abort forced by user
ext3_abort called.
EXT3-fs abort (device ide0(3,2)): ext3_remount: Abort forced by user
ext3_abort called.
EXT3-fs abort (device ide0(3,2)): ext3_remount: Abort forced by user
ext3_abort called.
EXT3-fs abort (device ide0(3,2)): ext3_remount: Abort forced by user
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
EXT3-fs error (device ide0(3,2)) in start_transaction: Journal has aborted
ext3_abort called.
EXT3-fs abort (device ide0(3,2)): ext3_remount: Abort forced by user
ext3_abort called.
EXT3-fs abort (device ide0(3,2)): ext3_remount: Abort forced by user
SpacedOut:/mnt/david/tuxscreen/buildroot-tux/build$ df -i
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/hda2             362304  361710     594  100% /
/dev/hdb1            1664640  210988 1453652   13% /mnt/hdb1


--=20
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgpkey.txt

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9vtrNAI852cse6PARAmelAJ4kI9J/fhYc650GJFB1xr80VW/pUQCgsaPM
+DLIG3KGInHGtKCS7Yr9kOY=
=UQZe
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
