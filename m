Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268595AbRG3Nrl>; Mon, 30 Jul 2001 09:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268597AbRG3Nrc>; Mon, 30 Jul 2001 09:47:32 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:24899 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S268595AbRG3NrS>; Mon, 30 Jul 2001 09:47:18 -0400
Date: Mon, 30 Jul 2001 15:44:58 +0200
From: Kurt Garloff <garloff@suse.de>
To: Daniela Engert <dani@ngrt.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VIA KT133A / athlon / MMX
Message-ID: <20010730154458.C4859@pckurt.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Daniela Engert <dani@ngrt.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20010729222830.A25964@pckurt.casa-etp.nl> <20010730125012Z268576-720+7896@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20010730125012Z268576-720+7896@vger.kernel.org>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7-SMP i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniela,

On Mon, Jul 30, 2001 at 08:04:54AM +0200, Daniela Engert wrote:
> On Sun, 29 Jul 2001 22:28:30 +0200, Kurt Garloff wrote:
>=20
> >Me neither. I was hoping that only a bit differs. Unfortunately that's n=
ot
> >the case, so I need to have a look in the datasheet.
> >But those are not publically available :-(
> >Anybody having them?
>=20
> Try to get a clue yourself from the WPCREDIT KT133 plugin (see below,
> stripped down to the differing registers). Some differences look
> suspicious to me...

Hey thanks!

> [54:6]=3DProbe Next Tag State T1	0=3Ddisable   1=3Denable

Main suspect. (Should be 0)

> [54:0]=3DFast Write-to-Read	0=3Ddisable   1=3Denable

Third candidate. (Should be 0)

> [68:4]=3DDRAM Data Latch Delay	0=3DLatch     1=3DDelay latch

Second candidate (Should be 1)

> [68:2]=3DBurst Refresh(4 times)	0=3Ddisable   1=3Denable

Fourth candidate (Should be 0?)

> [6B:5]=3DFast Read to Write t-a	0=3Ddisable   1=3Denable

Should this one match 54:0 (third candidate)?

> [6B:1]=3DVirtual Channel-DRAM	0=3Ddisable   1=3Denable

Strange, why does this one differ between the configs.

OK, I'll come up with a kernel patches (driver/pci/quirks ...)
for people to test.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7ZWTZxmLh6hyYd04RAnikAKCblq+IusrramGZwq2aP2+xviqMOwCgkP6k
jeKw93bOpx76NIoSxEXzVws=
=FJ9e
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
