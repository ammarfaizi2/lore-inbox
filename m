Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWDBK7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWDBK7D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDBK7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:59:02 -0400
Received: from 169.248.adsl.brightview.com ([80.189.248.169]:55819 "EHLO
	getafix.willow.local") by vger.kernel.org with ESMTP
	id S932324AbWDBK7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:59:00 -0400
Date: Sun, 2 Apr 2006 11:58:59 +0100
From: John Mylchreest <johnm@gentoo.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, paulus@samba.org
Subject: Re: [PATCH 1/1] POWERPC: Fix ppc32 compile with gcc+SSP in 2.6.16
Message-ID: <20060402105859.GN16917@getafix.willow.local>
References: <20060401224849.GH16917@getafix.willow.local> <20060402085850.GA28857@suse.de> <20060402102259.GM16917@getafix.willow.local> <20060402102815.GA29717@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
Content-Disposition: inline
In-Reply-To: <20060402102815.GA29717@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s9kDAZ2EyO0AcRYa
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2006 at 12:28:15PM +0200, Olaf Hering <olh@suse.de> wrote:
>  On Sun, Apr 02, John Mylchreest wrote:
>=20
> >   BOOTLD  arch/powerpc/boot/zImage.vmode
> >   arch/powerpc/boot/prom.o(.text+0x19c): In function `call_prom':
> >   : undefined reference to `__stack_smash_handler'
>=20
> Any this strange "security feature" is disabled by defining __KERNEL__?

That correct, yes. SSP is actually used by quite a lot of vendors, and
shouldn't be used outside of userland. Typically speaking it isn't, but
in this case its being leaked.

I've also heard some strange reports with ppc32 and 2.6.16 not
decompressing properly all of the time which might be related. I've not
been able to recreate this, nor heard any feedback yet.

--=20
Role:            Gentoo Linux Kernel Lead
Gentoo Linux:    http://www.gentoo.org
Public Key:      gpg --recv-keys 9C745515
Key fingerprint: A0AF F3C8 D699 A05A EC5C  24F7 95AA 241D 9C74 5515


--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEL65zNzVYcyGvtWURAoQLAJ9upFpqnLWany+m7ST5wFsQkUbtRwCgvIcI
KKlyZKrfR9KIPAqb0d86wAY=
=XDVa
-----END PGP SIGNATURE-----

--s9kDAZ2EyO0AcRYa--
