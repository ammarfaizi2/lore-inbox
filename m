Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313633AbSDICmg>; Mon, 8 Apr 2002 22:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313788AbSDICmf>; Mon, 8 Apr 2002 22:42:35 -0400
Received: from c207-202-243-179.sea1.cablespeed.com ([207.202.243.179]:21063
	"EHLO darklands.localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313633AbSDICme>; Mon, 8 Apr 2002 22:42:34 -0400
Date: Mon, 8 Apr 2002 19:42:32 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Reworked CONFIG_IDE_TASKFILE_IO help text
Message-ID: <20020409024232.GA23839@darklands.zimres.net>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0203291842530.6417-100000@freak.distro.conectiva> <Pine.NEB.4.44.0204042146520.7845-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux darklands 2.4.19-pre3-darklands 
X-Operating-Status: 14:53:47 up  5:05,  1 user,  load average: 7.81, 2.33, 0.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 04-Apr 09:50, Adrian Bunk wrote:
> Hi Marcelo,
>=20
> Configure.help contains the help text below that sounds more like a
> comment to a patch than a helpful help message for a user of a stable
> kernel:
>=20
> +CONFIG_IDE_TASKFILE_IO
> +  This is the "Jewel" of the patch.  It will go away and become the new
> +  driver core.  Since all the chipsets/host side hardware deal w/ their
> +  exceptions in "their local code" currently, adoption of a
> +  standardized data-transport is the only logical solution.
> +  Additionally we packetize the requests and gain rapid performance and
> +  a reduction in system latency.  Additionally by using a memory struct
> +  for the commands we can redirect to a MMIO host hardware in the next
> +  generation of controllers, specifically second generation Ultra133
> +  and Serial ATA.
> +
> +  Since this is a major transition, it was deemed necessary to make the
> +  driver paths buildable in separtate models.  Therefore if using this
> +  option fails for your arch then we need to address the needs for that
> +  arch.
> +
> +  If you want to test this functionality, say Y here.
>=20
> Could anyone provide a more useful help text?

Maybe this is better?=20

CONFIG_IDE_TASKFILE_IO
  This option enables a new standardized data-transport driver. It replaces
  code currently in each chipset/host driver. This should help reduce
  bugs and allow better data protection. This new code also packetizes
  requests to enable rapid performance and reduce system latency. It also u=
ses
  structures so MMIO hardware can be used in second generation Ultra133 and
  Serial ATA chipsets.

  Since this a a major reworking of current code, this will live along side
  current drivers for now. If this doesn't work on your arch yell.=20

  If you want to test this new driver (and have backups), say Y here.=20

>=20
> TIA
> Adrian
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8slUYUHPW3p9PurIRAopjAKCpQHJr+PBDRP0ZO+WRp7Cw78iCwACggNJa
wo4ibVnXRtgBPfm5hFRuiZo=
=A1qJ
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
