Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUAGOTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 09:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUAGOTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 09:19:54 -0500
Received: from trinity.webmaking.ms ([213.131.251.60]:24782 "HELO
	trinity.webmaking.ms") by vger.kernel.org with SMTP id S266198AbUAGOTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 09:19:52 -0500
Date: Wed, 7 Jan 2004 15:19:48 +0100
From: Thomas Fischbach <webmaster@kennygno.net>
To: linux-kernel@vger.kernel.org
Subject: can't mount encrypted dvd with 2.6.0
Message-Id: <20040107151948.4376d881@kyp.intra>
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__7_Jan_2004_15_19_48_+0100_UU_WVzZfteNnYfSx"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__7_Jan_2004_15_19_48_+0100_UU_WVzZfteNnYfSx
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi,

if I create an encrypted iso image:
dd if=/dev/zero of=/files/image.iso bs=512 count=$((1024*4400))
losetup -e aes -k 256 /dev/loop1 /files/image.iso
mkisofs -r -o /dev/loop1 /files/stuff/*
losetup -d /dev/loop1 

I can mount the file:
mount /files/image.iso /mnt/cd -t iso9660 \
-o loop=/dev/loop1,encryption=aes,keybits=256

but when I burned the iso and tried to mount, it failed with:
mount: wrong fs type ...

and the logs says:
hdc: cdrom_read_intr: data underrun (2 blocks)
end_request: I/O error, dev hdc, sector 64
isofs_fill_super: bread failed, dev=loop0, iso_blknum=16, block=32

under 2.4.22 it works fine.
Hope someone can help.

Thanks,
Thomas

-- 
Thomas Fischbach
http://www.kennygno.net
webmaster@kennygno.net

--Signature=_Wed__7_Jan_2004_15_19_48_+0100_UU_WVzZfteNnYfSx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//BWEhty018ANwB4RAqbXAJ9qkmHhf18jcEyWS50Tls3Z5lR9/gCePi2G
7N2+AScX45pxWJlouVL8+AQ=
=I4ry
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Jan_2004_15_19_48_+0100_UU_WVzZfteNnYfSx--
