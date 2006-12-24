Return-Path: <linux-kernel-owner+w=401wt.eu-S1752118AbWLXQS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbWLXQS7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbWLXQS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 11:18:59 -0500
Received: from mta-1.ms.rz.RWTH-Aachen.DE ([134.130.7.72]:55147 "EHLO
	mta-1.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118AbWLXQS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 11:18:58 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 11:18:57 EST
Date: Sun, 24 Dec 2006 16:18:45 +0100
From: markus reichelt <ml@mareichelt.de>
Subject: Re: 2.6.19.1: kobject_add failed for audio with -EEXIST
In-reply-to: <s5hmz5kdm8j.wl%tiwai@suse.de>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20061224151845.GW3723@tatooine.rebelbase.local>
Organization: still stuck in reorganization mode
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=AbQceqfdZEv+FvjW
Content-disposition: inline
X-PGP-Key: 0xC2A3FEE4
X-PGP-Fingerprint: FFB8 E22F D2BC 0488 3D56  F672 2CCC 933B C2A3 FEE4
X-Request-PGP: http://mareichelt.de/keys/c2a3fee4.asc
References: <20061212160135.GA3723@tatooine.rebelbase.local>
 <s5hmz5kdm8j.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 12 Dec 2006 17:01:35 +0100,
> markus reichelt wrote:
> >=20
> > Hi,
> >=20
> > I'm still having this prob at boot. please advise.
>=20
> It's the place trying to create OSS audio entry.
> What points /sys/class/sound/audio/device ?


sorry for the late answer, I totally missed your mail....

I'm not sure I get what you are saying but this is what's there under
2.6.19.1

 ls -al /sys/class/sound/audio/
insgesamt 0
drwxr-xr-x  2 root root    0 2006-12-24 16:12 .
drwxr-xr-x 22 root root    0 2006-12-12 17:53 ..
-r--r--r--  1 root root 4096 2006-12-24 16:12 dev
lrwxrwxrwx  1 root root    0 2006-12-24 16:12 subsystem ->
=2E./../../class/sound
--w-------  1 root root 4096 2006-12-24 16:12 uevent

ls -al /sys/class/sound/audio1/
insgesamt 0
drwxr-xr-x  2 root root    0 2006-12-24 16:12 .
drwxr-xr-x 22 root root    0 2006-12-12 17:53 ..
-r--r--r--  1 root root 4096 2006-12-24 16:12 dev
lrwxrwxrwx  1 root root    0 2006-12-24 16:12 device ->
=2E./../../devices/pci0000:00/0000:00:0e.0/0000:02:0a.1
lrwxrwxrwx  1 root root    0 2006-12-24 16:12 subsystem ->
=2E./../../class/sound
--w-------  1 root root 4096 2006-12-24 16:12 uevent

these are the two entries /sys/class/sound/audio*


the only difference between the kernels before my last mail about the
issue is that with .19.1 i can use the sound hardware which was not
possible beforehand; it was simply dead after the borked dmesg.

if you need anything else, please dont heasitate to mail. thanks.

--=20
left blank, right bald

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFjppVLMyTO8Kj/uQRAv5AAJ453v1Bcl0U5ErEs7fi8fEgxpkPHACdFH1v
96bK0BSG6I1tjDf8p1YJ+NA=
=N1M5
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--

