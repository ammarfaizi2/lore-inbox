Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275207AbRJNNj4>; Sun, 14 Oct 2001 09:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275211AbRJNNjq>; Sun, 14 Oct 2001 09:39:46 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:38608 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S275207AbRJNNji>; Sun, 14 Oct 2001 09:39:38 -0400
Date: Mon, 24 Sep 2001 11:25:10 +0200
To: linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [reiserfs-list] Re: ReiserFS data corruption in very simple configuration
Message-ID: <20010924112510.F15955@jensbenecke.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Reiserfs mail-list <Reiserfs-List@Namesys.COM>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <15276.34915.301069.643178@beta.reiserfs.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <15276.34915.301069.643178@beta.reiserfs.com>; from Nikita@Namesys.COM on Sat, Sep 22, 2001 at 04:47:31PM +0400
X-FAQ-is-At: http://www.linuxfaq.de/
X-No-Archive: Yes
X-Operating-System: Linux 2.4.7-jb
From: Jens Benecke <jens@jensbenecke.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 22, 2001 at 04:47:31PM +0400, Nikita Danilov wrote:
> foner-reiserfs@media.mit.edu writes:
>  > [Please CC me on any replies; I'm not on linux-kernel.]
>  >=20
>  > The ReiserFS that comes with both Mandrake 7.2 and 8.0 has
>  > demonstrated a serious data corruption problem, and I'd like to know
>  > (a) if anyone else has seen this, (b) how to avoid it, and (c) how to
>  > determine how badly I've been bitten.
>  >=20
> Stock reiserfs only provides meta-data journalling. It guarantees that
> structure of you file-system will be correct after journal replay, not
> content of a files. It will never "trash" file that wasn't accessed at
> the moment of crash, though. Full data-journaling comes at cost. There is
> patch by Chris Mason <Mason@Suse.COM> to support data journaling in
> reiserfs. Ext3 supports it also.

one question:

When I was using ext2 I always mounted the /usr partition read-only, so
that a fsck weren't necessary at boot - and the files were all guaranteed
to be OK to bring the system up at least.

Does this (mount -o ro) make sense with ReiserFS as well? What I mean is,
is there a chance of a file getting corrupted that was only *read* (not
*written*) at or before a power outage?
=20

I mount all my system partitions with -o notail,noatime if that makes any
difference.


--=20
Jens Benecke =B7=B7=B7=B7=B7=B7=B7=B7 http://www.hitchhikers.de/ - Europas =
Mitfahrzentrale

                           rm -rf /bin/laden

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE7rvv2153rQBa8U44RAuv4AKCInJ9HtFva9a5Vx2zobPrwP+sv6gCgkA5k
Y+C1vEgH7UyNpy3l+y8ObCI=
=KXn6
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--
