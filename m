Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263585AbUGKRQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUGKRQK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 13:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266624AbUGKRQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 13:16:10 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:45202 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263585AbUGKRQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 13:16:04 -0400
Date: Sun, 11 Jul 2004 11:16:01 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Michelle Konzack <linux4michelle@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Message-ID: <20040711171601.GX23346@schnapps.adilger.int>
Mail-Followup-To: Michelle Konzack <linux4michelle@freenet.de>,
	linux-kernel@vger.kernel.org
References: <070820041751.25643.40ED899E0006C76E0000642B2200748184970A059D0A0306@comcast.net> <20040708182143.GD23346@schnapps.adilger.int> <20040711145546.GF720@freenet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BlkQeOBdElZ1aiuH"
Content-Disposition: inline
In-Reply-To: <20040711145546.GF720@freenet.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BlkQeOBdElZ1aiuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 11, 2004  16:55 +0200, Michelle Konzack wrote:
> Hello Andreas,=20
>=20
> Am 2004-07-08 12:21:43, schrieb Andreas Dilger:
>=20
> >If you are actually running out of inodes, then you can use "-i" or "-N"
> >to mke2fs to increase the number of inodes in a new filesystem.  Since
> >this defaults to 1 inode per 8kB of space, it seems unlikely that you
> >would run out of inodes before blocks unless you have lots of small files
> >(maildir perhaps?  even then "modern" emails usually average > 8kB in si=
ze
> >because of HTML crap, lots of headers, attachments, etc).
>=20
> I have a courier-imap Server where I share all all mailinglists where=20
> I am subscribed... Curently I have 5,2 Millionen Messages in the ext3.
>=20
> I have already striped the messages with=20
>=20
> :0 fh
> | formail -f -I Received: -I Envelope-to: -I Delivered-To:  -I Return-pat=
h: \
> -I X-Spam-Checker-Version:   -I X-Spam-Status: -I X-Spam-Level:=20
>=20
> I have a mailsize of around 2,5 kBytes...
>=20
> So I habe used 'mkfs.ext3 -b 1024 -N 8000000 ... /dev/sda..'
>=20
> My question is, how many Inodes can I create on a ext3 filesystem  ?

Up to 4 billion inodes, but it depends on the size of the device.  You
can create your filesystem with e.g. "-b 1024 -i 2048" to create 1 inode
for each 2kb of space.

> Curently I am running a 3Ware Raid-5 Controller 75xx with 3 x 80 GByte.

This will give you 160GB of usable space, so 160 * 1024 * 1024 / (2 * 1024)
is 80 million, which is what you specified manually above, oh, you put
8 million unless that was a typo.

Yes, it would be good to have dynamic inode allocation for ext3, but it
hasn't been a top priority for anyone to implement it.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--BlkQeOBdElZ1aiuH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA8XXRpIg59Q01vtYRAvClAKC0+wWoLqI/2r3s/0KWXH9yCtG6vACg7Mv0
HQpPZfaT5vahrXv5v4Q/L7M=
=lyoK
-----END PGP SIGNATURE-----

--BlkQeOBdElZ1aiuH--
