Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTAILfi>; Thu, 9 Jan 2003 06:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTAILfi>; Thu, 9 Jan 2003 06:35:38 -0500
Received: from AVelizy-101-1-1-215.abo.wanadoo.fr ([193.251.75.215]:5504 "EHLO
	manta.jerryweb.org") by vger.kernel.org with ESMTP
	id <S265139AbTAILfh>; Thu, 9 Jan 2003 06:35:37 -0500
Date: Thu, 9 Jan 2003 12:44:16 +0100
From: Jeremy =?ISO-8859-1?B?TGFpbuk=?= <jeremy.laine@polytechnique.org>
To: linux-kernel@vger.kernel.org
Subject: hardsect for MP-F70 player driver?
Message-Id: <20030109124416.08fd1298.jeremy.laine@polytechnique.org>
X-Mailer: Sylpheed version 0.8.5claws56 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="_1eFb+=.grjdaz)A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--_1eFb+=.grjdaz)A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I hope this message is not off topic, as after reading the kernel FAQ
I could not figure out if it was or not!

I am currently writing a kernel module to support the MP-F70 mp3
player as a block device, as it does not work like 'standard'
usb-storage devices. using a hardsector size of 512 bytes works just
swell for reading works but I am running into problems when trying to
implement writing.

Indeed for the writing to work, one first has to issue a sort of
'erase' command but this wipes out a block of 16*512=8192 bytes.  I
tried to bump up the hardsect size to 8192 bytes but this then causes
problems with the FAT module which complains the hardsect size is over
the logical sector size (and anyway I also get a complaint from
buffer.c that the size is larger than PAGE_SIZE). I am developing on a
2.4 series kernel.

Does anyone have some pointers to a possible solution? 

Thanks in advance and thanks for the great work on the kernel!

Jeremy

--  
http://www.jerryweb.org/         : JerryWeb.org
http://sailcut.sourceforge.net/  : Sailcut CAD

--_1eFb+=.grjdaz)A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+HWCQ4mJJZqJp2ScRAjZ7AJwOAcksC9INCZF1cx+ejxe/V/JYuwCfZ4Ah
eZV44fsxd7EHD1+pZhq7zJs=
=JnRt
-----END PGP SIGNATURE-----

--_1eFb+=.grjdaz)A--
