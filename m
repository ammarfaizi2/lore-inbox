Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTAGD2K>; Mon, 6 Jan 2003 22:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267282AbTAGD2K>; Mon, 6 Jan 2003 22:28:10 -0500
Received: from spider.morgul.net ([18.24.4.35]:21263 "EHLO spider.morgul.net")
	by vger.kernel.org with ESMTP id <S267281AbTAGD2J>;
	Mon, 6 Jan 2003 22:28:09 -0500
Date: Mon, 6 Jan 2003 22:36:47 -0500
To: linux-kernel@vger.kernel.org
Subject: ext3 related oops in 2.4.{18,20} on sparc
Message-ID: <20030107033647.GD25227@morgul.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HtRZva1Vzv8iP5ye"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: "Noah L. Meyerhans" <frodo@morgul.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HtRZva1Vzv8iP5ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I consistantly get a kernel oops in 2.4.18 and 2.4.20 on my SPARC Ultra
1 when copying lots of data between two filesystems on the same disk.
The latest command I've been using is: "cd /mnt && rsync -var /usr/ ."
The command runs for a while, copying data, but then, before it
completes, rsync dies with the following error:
rsync: error writing 25 unbuffered bytes - exiting: Broken pipe
rsync error: error in rsync protocol data stream (code 12) at io.c(463)
rsync: error writing 69 unbuffered bytes - exiting: Broken pipe
rsync error: error in rsync protocol data stream (code 12) at io.c(463)

and an oops is generated.  The machine still seems to run OK, though I
can't unmount the destination filesystem.

The oops message is attached, having been decoded with ksymoops.  I
don't have any reason to believe there are hardware issues with this
machine.  It has been very reliable for quite some time, and there are
no signs of problems up to the very instant that the oops is generated,
which seems to happen at a different point in the copying process each
time.

Thanks for any help you can offer.  Let me know if you need more info.

noah

--=20
 _______________________________________________________
| Web: http://web.morgul.net/~frodo/
| PGP Public Key: http://web.morgul.net/~frodo/mail.html=20

--HtRZva1Vzv8iP5ye
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+GktPYrVLjBFATsMRAq9YAJ97PpTVTmGsDCAJECLGG9RXyLralwCeNVFh
yMX5h6lGPB1lAYfNABepi3A=
=s9oH
-----END PGP SIGNATURE-----

--HtRZva1Vzv8iP5ye--
