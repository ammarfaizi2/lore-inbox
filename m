Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132914AbRDXJJk>; Tue, 24 Apr 2001 05:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132909AbRDXJJc>; Tue, 24 Apr 2001 05:09:32 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:11025 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S132912AbRDXJJR>; Tue, 24 Apr 2001 05:09:17 -0400
Date: Tue, 24 Apr 2001 11:05:32 +0200
From: Kurt Garloff <garloff@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: read perf improved by mounting ext2?
Message-ID: <20010424110532.E12624@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Jens Axboe <axboe@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010424013150.A6892@garloff.etpnet.phys.tue.nl> <20010424105858.C9357@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424105858.C9357@suse.de>; from axboe@suse.de on Tue, Apr 24, 2001 at 10:58:58AM +0200
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2001 at 10:58:58AM +0200, Jens Axboe wrote:
> On Tue, Apr 24 2001, Kurt Garloff wrote:
> > There are enough partitions to see a clear pattern: Those with mounted =
ext2
> > filesystems perform better. Umounting them does not harm, they just nee=
d to
> > have been mounted once. reiser or (v)fat however don't improve anything.
> > swap does, as does a ext2 over raid5.
>=20
> You wouldn't happen to have 4kB ext2 filesystems on those?

Sure I do.

> When ext2 mounts, it sets the soft blocksize to that then, I would expect
> this to give at least some benefit over using 1kB blocks (as your IDE
> partition otherwise would have).

Why? Are the request sizes larger this way? This would mean that the
overhead is very significant, turning a max of 26MB/s into 16MB/s!

If so, shouldn't we try to get the same effect also for the whole disk or
other filesystems? Most notably reiser?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4h (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE65UHbxmLh6hyYd04RAv0wAJ4w3thA5EaWuvC3e+xzAasZGVZuKACePxOV
hiYVstyEe4mJlRbxJEV+zMA=
=TBiU
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
