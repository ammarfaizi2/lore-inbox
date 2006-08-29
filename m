Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWH2JMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWH2JMV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWH2JMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:12:20 -0400
Received: from natgw.netstream.ch ([62.65.128.28]:42463 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932167AbWH2JMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:12:19 -0400
Date: Tue, 29 Aug 2006 11:12:05 +0200
From: Nico Schottelius <nico-kernel20060829@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Problem with md: Not rebuilding rai5
Message-ID: <20060829091205.GB21160@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel20060829@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.17.6-hydrogenium
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I created a degrated raid5 on top of md1 and hde1. Then moved the data
=66rom /dev/hdk to the mounted raid5, and then added hdk1 (repartitoned)
to the array. The sync began, but after that hde1 was faulty.

I removed it, readded it, but now I've a raid5 with only one active
disk (which should not be possible imho, a raid5 always needs 2 disks)
AND what's even stranger for me, I've two spare disks.

Is there a way to force rebuilding the array?

I am a bit confused, because I thought Linux would rebuilt the array
automaticly, when having spare disks.

The output of mdadm and some debug can be found at

http://home.schottelius.org/~nico/linux/debug/raid/raid5.strange

I am happy for any hint, because I did not find documentation, which
refers to having two spare disks with raid5. And as much as I know from the
Software-Raid howto, Linux should rebuilt it automaticly, shouldn't it?

I am happy for any hint, I am currently not rebooting the system or
umounting the path, because I do not know whether the array will come up
again.

Nico

P.S.: Please CC, I am not subscribed.

--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQIVAwUBRPQE5LOTBMvCUbrlAQLhEg//aD1CPs8ksIAzFXGj4tbGPXfpilE5y1XQ
HN8illJERb7lGPrd6E/VkxotsUV2CkWHySk2brzTX8nLCGySJSlVQZpVylTfX74H
RWArDvzCiVAz8yPoIHYhWbOWCOVEsYcaXuqKEGfIMGF1LdXekCKuS3ZMonTt+93d
eyg0LSYe8bho0WtZUxTdnKk3F8FfgVVQeL+r6KjZ+B3TXhMSTqEQcvTCiY5Ry4vU
aM8RXyx1QEGTkG3cNN5X83GhkJ3n8aztVzBJO0mwVFJSpjFd6U7kHWSFZXDzILwe
rMeVugkLbclqwhPO657+kbOA3fFfDeBTyH0rqNzBg1ESV+D0NdHL1G1Slsud0G58
41zPjc2DvF8FMYGlrx9YTjxQIm3wVeUMse3cbdyDJXfrfAFUWnOrx9al7+2Mlvhy
yHbzAf75X1jLsG0XY7pDZJUBXyYYu1XGalg1oBchsauekgFZzbR4Gg3DVTQiycyj
B/u0CZ+jBoBOEenBri93U6SW2AEyTCFg603YOvXQtyxKVFvxgfx5UoKcyQGLdTNK
fm6+x5q9rq3u48vXVC3Z19U7kBwkzia4rGsnl6EhXV+XthmskdIFKPofPhXxlQ5N
6JM9DdWWbLWBXQjOE5Chvy/rlbkY5jJGXurn7LsomwYTbUcd3oZRJceIwe3cxP0K
5S3RlBG3JKY=
=wbyj
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
