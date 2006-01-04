Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWADPu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWADPu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWADPu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:50:27 -0500
Received: from mail.gmx.net ([213.165.64.21]:22753 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751797AbWADPu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:50:27 -0500
X-Authenticated: #24128601
Date: Wed, 4 Jan 2006 16:50:36 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
Message-ID: <20060104155036.GA5542@section_eight.mops.rwth-aachen.de>
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <20060104092058.GN3472@suse.de> <20060104092443.GO3472@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20060104092443.GO3472@suse.de>
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all! Hi Jens!

I'd be kind if you would cc me in case you reply as I'm not (yet)
subscribed to this list.

On Mi, Jan 04, 2006 at 10:24:44 +0100, Jens Axboe wrote:
> On Wed, Jan 04 2006, Jens Axboe wrote:
> >=20
> > Can you try and see how, say, track01 differ? Is it single bytes, chunks
> > of 2352 bytes, or?
>=20
> Oh, and try and disable DMA on the cd driver and repeat your results
> with ide-cd. It uses DMA, where ide-scsi does not. Dunno what Windows
> does. It could just be a problem with your drive and DMA enabled rips.

Hi Jens,

I did as you said and disabled dma:

/dev/hdc:
 IO_support   =3D  1 (32-bit)
 unmaskirq    =3D  1 (on)
 using_dma    =3D  0 (off)
 keepsettings =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D 256 (on)
 HDIO_GETGEO failed: Invalid argument

Then I reripped the whole disc. Now this is remarkable. The rip still
has errors, but the errors are not only in the same tracks. They are
exactly the same errors (md5sums are equal to the ones I yielded from
using ide-cd before):

e8319ccc20d053557578b9ca3eb368dd  track01.cdda.wav (!)
cb978f86ddc18c9df1b7e91705380bc5  track02.cdda.wav (!)
35f1b296d72a8708d03aeb540a3b4f30  track03.cdda.wav (!)
e82169e5ea1b441b80db96fce12fd109  track04.cdda.wav
8d807b7ac19f90049aec6ff177e9b486  track05.cdda.wav
02561939763d67aacf23157c09966a89  track06.cdda.wav (!)
9724b0a3e2295084613da9df7397ae6d  track07.cdda.wav (!)
c2d85b3d10428aad66664d0fb3e4c71a  track08.cdda.wav (!)
5116b2fae44b8b86fbf40b9bac9a8268  track09.cdda.wav (!)
9e6a5ab2dab76e1677667f586895293a  track10.cdda.wav (!)
3792a680b1ba729de9185043d331186f  track11.cdda.wav
ba534fd8eb42dd84aa7b59ab3ae6f132  track12.cdda.wav
d6346ab76696dddf735a5b752aa7888b  track13.cdda.wav

I used the wav compare function in EAC.

1. wav ripped by EAC
####################

What happened?          Where?
-------------------------------------------------

Different samples       0:04:08.318 - 0:04:08.362
2100 missing samples    0:04:08.359
Different samples       0:04:08.430 - 0:04:08.433
Different samples       0:04:09.348 - 0:04:09.398

2. wav ripped by cdparanoia
###########################

What happened?          Where?
-------------------------------------------------

Different samples       0:04:08.318 - 0:04:08.362
2039 missing samples    0:04:08.414
Different samples       0:04:08.431 - 0:04:08.434
Different samples       0:04:09.349 - 0:04:09.399

I'm sorry if this isn't what you had in mind when you told me to compare
the wav files. If it doesn't help what can I do to compare the files to
your liking?

Sebastian
--=20
"When the going gets weird, the weird turn pro." (HST)

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDu+7MTWouIrjrWo4RAk73AJoCguOKurFNKf+lXQVB/wKQ5xEFnACfflTq
9qD+V8TmTny1ng7bLTAf/kE=
=1Alr
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

