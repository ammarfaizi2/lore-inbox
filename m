Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUJSODV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUJSODV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUJSODV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:03:21 -0400
Received: from lug-owl.de ([195.71.106.12]:52962 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S269417AbUJSODJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:03:09 -0400
Date: Tue, 19 Oct 2004 16:03:08 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Jeba Anandhan A <jeba_career@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Device Access
Message-ID: <20041019140308.GS5033@lug-owl.de>
Mail-Followup-To: Jeba Anandhan A <jeba_career@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20041019112347.93552.qmail@web50608.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OrW2+nom8o3MRLeV"
Content-Disposition: inline
In-Reply-To: <20041019112347.93552.qmail@web50608.mail.yahoo.com>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OrW2+nom8o3MRLeV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-10-19 04:23:46 -0700, Jeba Anandhan A <jeba_career@yahoo.com>
wrote in message <20041019112347.93552.qmail@web50608.mail.yahoo.com>:
> i have one USB Flash Disk.when i attached to it,linux
> 2.4.20-8 detected it as /dev/sda1.my question,i wish

No, it doesn't. It will detect it as /dev/sda and additionally create a
partition (/dev/sda1) for it).

> to write some raw data and read raw data.it consist
> fat filesystem.how to do it.[shall i need to mount the
> device in some directory].

Well, it depends on what you actually want:

- Raw data in a file inside a partition:
	Mount the filesystem of the partition somewhere and open() the file

- Raw data inside the partition:
	open() the partition (/dev/sda1 in your case); this'll probably
	destroy the filesystem that it contains.

- Raw data directly on the (unpartitioned) device:
	open() the device (/dev/sda) and write to it. That will probably
	kill the partition table as well as the filesystem in this
	partition.
 =20
By the way, this isn't really a kernel question, and if it's "urgent",
you'd probably ask your boss to send us some $$ for helping you...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--OrW2+nom8o3MRLeV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdR6cHb1edYOZ4bsRAsajAJ9OiWDESFK3Cw0dXqXXi7cyWV4xpACeOesd
ple2gtZ2kwnLBwpUyGVGZTg=
=gPwD
-----END PGP SIGNATURE-----

--OrW2+nom8o3MRLeV--
