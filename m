Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTKFStg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTKFStg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:49:36 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:22155 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263715AbTKFStd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:49:33 -0500
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3FAA5CCB.5030902@gmx.de>
References: <20031106130030.GC1145@suse.de>
	 <3FAA4737.3060906@cyberone.com.au> <20031106130553.GD1145@suse.de>
	 <3FAA4880.8090600@cyberone.com.au> <20031106131141.GE1145@suse.de>
	 <3FAA4D48.6040709@gmx.de> <20031106133136.GA477@suse.de>
	 <3FAA5043.8060907@gmx.de> <20031106134713.GA798@suse.de>
	 <3FAA5397.6010702@gmx.de> <20031106135134.GA1194@suse.de>
	 <3FAA5CCB.5030902@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6xzSgViLUZg+I9T7tocU"
Message-Id: <1068144567.5499.96.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 19:49:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6xzSgViLUZg+I9T7tocU
Content-Type: multipart/mixed; boundary="=-v98Cm3vCKGnJ6dSFlH93"


--=-v98Cm3vCKGnJ6dSFlH93
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 15:38, Prakash K. Cheemplavam wrote:
> Ok, I found the bugger: It *IS* the sheduler. I tried elevator=3Ddeadline=
=20
> and all stuttering went away. Before I was using as. mm1 used default=20
> sheduler (as I think) and ther eno probs. So the (updated?) as sheduler=20
> in mm2 has a problem...

Can you run the attached script when you repeat the test?
With both elevator=3Ddeadline and without.

./diskstat.sh hdc

Your problem sounds a little like the one I'm seeing, only I'm seeing it
with both deadline and as. I can't really see if I'm loosing
timer-interrupts or not since the only way I've found to reproduce it is
to recieve a file via network and write it to disk, and that generates
lots of interrupts...

--=20
/Martin

--=-v98Cm3vCKGnJ6dSFlH93
Content-Disposition: attachment; filename=diskstat.sh
Content-Type: text/x-sh; name=diskstat.sh; charset=iso-8859-15
Content-Transfer-Encoding: base64

Iy9iaW4vYmFzaA0KDQpudW09MA0KZm9yIGxvb3AgaW4gYSBiIGMgZCBlIGYgZyBoIGkgaiBrDQpk
bw0KCW9sZFskbnVtXT0wDQoJbnVtPSQoKCRudW0gKyAxKSkNCmRvbmUNCg0Kcm93PTANCg0Kd2hp
bGUgdHJ1ZTsgZG8gZ3JlcCAiJDEgIiAvcHJvYy9kaXNrc3RhdHMgfCBhd2sgJ3twcmludCAkNCwk
NSwkNiwkNywkOCwkOSwkMTAsJDExLCQxMiwkMTMsJDE0fSc7IHNsZWVwIDE7IGRvbmUgfCB3aGls
ZSByZWFkIGEgYiBjIGQgZSBmIGcgaCBpIGogaw0KZG8NCglpZiBbICQoKCRyb3cgJSAzMCkpID09
IDAgXTsgdGhlbg0KCQkjZWNobyAtZSAicm93XHRyZWFkc1x0cm1lcmdlXHRyc2VjdFx0cm1zXHRc
dHdyaXRlc1x0d21lcmdlXHR3c2VjdFx0d21zXHRcdGlvXHRtc1x0bXMyIg0KCQllY2hvIC1lICJy
b3dcdHJlYWRzXHRybWVyZ2VcdHJzZWN0XHRybXNcdHdyaXRlc1x0d21lcmdlXHR3c2VjdFx0d21z
XHRpb1x0bXNcdG1zMiINCglmaQ0KCXJvdz0kKCgkcm93ICsgMSkpDQoNCgludW09MA0KCWZvciBs
b29wIGluIGEgYiBjIGQgZSBmIGcgaCBpIGogaw0KCWRvDQoJCWlmIFsgJHtvbGRbJG51bV19ID09
IDAgXTsgdGhlbg0KCQkJb2xkWyRudW1dPSR7IWxvb3B9DQoJCQlkaWZmWyRudW1dPTANCgkJZWxz
ZQ0KCQkJZGlmZlskbnVtXT0kKCgkeyFsb29wfSAtICR7b2xkWyRudW1dfSkpDQoJCQlvbGRbJG51
bV09JHshbG9vcH0NCgkJZmkNCgkJbnVtPSQoKCRudW0gKyAxKSkNCglkb25lDQoNCgllY2hvIC1l
ICIkcm93XHQke2RpZmZbMF19XHQke2RpZmZbMV19XHQke2RpZmZbMl19XHQke2RpZmZbM119XHQk
e2RpZmZbNF19XHQke2RpZmZbNV19XHQke2RpZmZbNl19XHQke2RpZmZbN119XHQkaVx0JHtkaWZm
WzldfVx0JHtkaWZmWzEwXX0iDQpkb25lDQo=

--=-v98Cm3vCKGnJ6dSFlH93--

--=-6xzSgViLUZg+I9T7tocU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qpe2Wm2vlfa207ERAp7zAJsHroyATsjK1H2fYY2ySY3FNNuk0wCcCxAT
1B2TTl0D5k1waHPxRftkUrs=
=TEbZ
-----END PGP SIGNATURE-----

--=-6xzSgViLUZg+I9T7tocU--
