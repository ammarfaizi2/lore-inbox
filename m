Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSGVJau>; Mon, 22 Jul 2002 05:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSGVJau>; Mon, 22 Jul 2002 05:30:50 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:10786 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316604AbSGVJat>; Mon, 22 Jul 2002 05:30:49 -0400
Date: Mon, 22 Jul 2002 11:33:41 +0200
From: Kurt Garloff <garloff@suse.de>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>,
       "C.L. Huang" <ching@tekram.com.tw>
Subject: Re: Tekram DC390 DMA allocation fixes
Message-ID: <20020722093341.GA32278@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@redhat.com>,
	"C.L. Huang" <ching@tekram.com.tw>
References: <Pine.LNX.4.44.0207211943020.3309-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207211943020.3309-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 21, 2002 at 07:58:49PM -0600, Thunder from the hill wrote:
> drivers/scsi/scsiiom.c is seriously DMA broken, for sure.=20

Oh yes, I know.
I was just waiting until somebody complains before I take the time
to convert everything to use pci_map stuff.

> Now there is that suggestion that we allocate DMAable memory via the PCI=
=20
> DMA pool functions. I'm still rather confused which way to go for the=20
> address field. We have

I believe we should just use
pci_map_single/_sg and sg_dma_address(), no?

Or are they scheduled for removal ... ?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9O9F0xmLh6hyYd04RAvQaAJ923B4XQj1G1f3+nEqH/loyqWuQxQCgqH77
9jEU+aCQYgUxun2oWYOnrbU=
=IIYt
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
