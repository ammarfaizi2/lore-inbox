Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262963AbSJGJEo>; Mon, 7 Oct 2002 05:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262964AbSJGJEo>; Mon, 7 Oct 2002 05:04:44 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:31493 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S262963AbSJGJEn>;
	Mon, 7 Oct 2002 05:04:43 -0400
Date: Mon, 7 Oct 2002 11:10:21 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: The end of embedded Linux?
Message-ID: <20021007091020.GU17934@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Content-Disposition: inline
In-Reply-To: <20021005193650.17795.qmail@web13202.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2002-10-05 12:36:50 -0700, Gigi Duru <giduru@yahoo.com>
wrote in message <20021005193650.17795.qmail@web13202.mail.yahoo.com>:
> Trivial experiment: configure out _ALL_ the options on
> 2.5.38 and build bzImage. My result? A totally useless
> 270KB kernel (compressed).=20

Well, from time to time, there are patches/suggestions on how to get the
footprint smaller. If you do embedded work, you're oftenly not
interestes in all the kernel's printk() messages. I have sent around
some patch some time ago which (in kernel.h) simply #define's a printk
to do nothing. Then, rename original printk() to your_real_printk() and
convert _really_ important printk() calls to your_real_printk(), eg.
Oops messages:-)

On a small kernel, you can save 50..100 KB (in the bzImage)! That's a
lot; think about uncompressed size!

And - there are other options as well. Just _look_ at the code, _think_
about it and (possibly) _change_ it if needed (and publish the changes
so that they're available to others).

MfG, JBG

--=20
   - Eine Freie Meinung in einem Freien Kopf f=FCr
   - einen Freien Staat voll Freier B=FCrger
   						Gegen Zensur im Internet
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9oU98Hb1edYOZ4bsRAngIAJ977LOOwtru3KdahD1bZaIZe5Me4gCggxlX
k63Tif2+4e66JVDqjNBAvqs=
=NbXl
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
