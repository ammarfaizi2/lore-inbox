Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264366AbUASC65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 21:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUASC65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 21:58:57 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:52924 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264366AbUASC6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 21:58:54 -0500
Date: Mon, 19 Jan 2004 16:04:21 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: Help port swsusp to ppc.
In-reply-to: <20040119105237.62a43f65@localhost>
To: Hugang <hugang@soulinfo.com>
Cc: ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074481461.7208.1.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-60WiAVlCHcggGEecX77g";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <20040119105237.62a43f65@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-60WiAVlCHcggGEecX77g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

I'd love to be able to help, but unfortunately the old assembly I know
is good old 6502 :> Hopefully someone else will pipe up and get you
going.

Once you do get it going, I'll be happy to help keep the other parts
updated, so far as I'm able.

Regards,

Nigel

On Mon, 2004-01-19 at 15:52, Hugang wrote:
> Hello guys:
>=20
> I'm try to porting Software Suspend to PowerPC. But I'm not family with
> PowerPC assemble languae. So need someone to help me write the save
> process state function in assemble language.
>=20
> 1: Download i386 suspend patch for 2.6.1 from swsusp.sf.net
>  you need two patch=20
>  software-suspend-core-2.0-rc4-whole.bz2
>  software-suspend-linux-2.6.1-rev1-whole.bz2
> 2: first you need apply linux-2.6.1 to 2.6.1 clean kernel
>    then apply core-2.0-rc4 to current patched kernel
> 3: then apply ppc-swsusp.patch to patched kernel
> 4: do make menuconfig
>  CONFIG_SOFTWARE_SUSPEND2=3Dy
>  CONFIG_SOFTWARE_SUSPEND_DEBUG=3Dy
>  CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION=3Dy
>  CONFIG_SOFTWARE_SUSPEND_KEEP_IMAGE=3Dy
>  CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION=3Dy
>  CONFIG_SOFTWARE_SUSPEND_SWAPWRITER=3Dy
> 5: test with swsusp enable kernel.
>  in yaboot prompt:
>  /vmlinux.swsusp root=3D/dev/hda13 resume2=3Dswap:/dev/hda10 init=3D/bin/=
sh
> =20
>  /dev/hda13 is the root device name
>  /dev/hda10 is swap device name
> =20
> 6: run suspend script to do software suspend, now the machine will power
>  off.
>=20
> 7: power on machin, in yaboot prompt:
>   /vmlinux.swsusp root=3D/dev/hda13 resume2=3Dswap:/dev/hda10 init=3D/bin=
/sh
>=20
> But for now the save and restore processor state is not finish, the
> resume will oops.
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-60WiAVlCHcggGEecX77g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAC0k1VfpQGcyBBWkRAgf9AJ4qmWZNYeJGPo1rB40ibWopw/dXpgCfZW1s
Rl+TBywhqJ6VpUvGUSAr65Q=
=Lbcm
-----END PGP SIGNATURE-----

--=-60WiAVlCHcggGEecX77g--

