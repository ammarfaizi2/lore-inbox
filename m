Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290168AbSAKXoi>; Fri, 11 Jan 2002 18:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290169AbSAKXo3>; Fri, 11 Jan 2002 18:44:29 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:20792 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S290168AbSAKXoH>; Fri, 11 Jan 2002 18:44:07 -0500
Date: Sat, 12 Jan 2002 00:44:09 +0100
From: Kurt Garloff <garloff@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Jay Estabrook <Jay.Estabrook@compaq.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3 - miata pci dma fix
Message-ID: <20020112004409.A23020@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Jay Estabrook <Jay.Estabrook@compaq.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0201101827100.22287-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcelo, Richard, Ivan, Jay,

On Thu, Jan 10, 2002 at 06:30:07PM -0200, Marcelo Tosatti wrote:
> pre3:
>=20
[...]
> - Miata dma corruption workaround 		(Richard Henderson)
[...]

> pre2:=20
[...]
> - Alpha fixes					(Jay Estabrook)
[...]

To be honest, I expected to see the patch from Ivan go in.

He came up with the solution to disable scatter-gather for pci dma, after I
sent a patch which justs worked around the page boundary cross bug for
ide-dma on the miata/pyxis. Disabling SG for PCI DMA on miata is no problem,
as we can directly map a 2GB window of memory into PCI space.

A second patch also made sure it works for ISA (which also support 32bis on
pyxis), so the floppy controller is happy again.
This second patch is the only thing I see when having a quick look at the
2.4.18pre3 patch, and Ivan should be credited for it as far as I know.

Is this an oversight? Or is there seom magic bit switched which I overlooked
which switches off SG PCI DMA on pyxis?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8P3jIxmLh6hyYd04RAlUbAJ9Cjb65MrHEFAJSlujbOTmWJ5I+UgCfV9ln
kk2CatePFmqJdKDmkKMCugY=
=AhMs
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
