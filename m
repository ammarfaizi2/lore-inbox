Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWGQQNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWGQQNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbWGQQNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:13:04 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:49123 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S1750919AbWGQQNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:13:02 -0400
X-Ids: 168
Date: Mon, 17 Jul 2006 18:13:34 +0200
From: Julien Cristau <julien.cristau@ens-lyon.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: Linux v2.6.17 - PCI Bus hidden behind transparent bridge
Message-ID: <20060717161333.GA5204@bryan.is-a-geek.org>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <20060716193452.GA5299@bryan.is-a-geek.org> <20060717141315.GB2771@colo.lackof.org> <20060717142917.GJ5299@bryan.is-a-geek.org> <20060717153128.GA16679@colo.lackof.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20060717153128.GA16679@colo.lackof.org>
X-Operating-System: Linux 2.6.17-1-686 i686
User-Agent: Mutt/1.5.11+cvs20060403
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (shiva.jussieu.fr [134.157.0.168]); Mon, 17 Jul 2006 18:13:00 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2006 at 09:31:28 -0600, Grant Grundler wrote:

> On Mon, Jul 17, 2006 at 04:29:17PM +0200, Julien Cristau wrote:
> > Loading the driver with modprobe doesn't change anything (it just
> > outputs the 'Loaded prism54 driver' line), the device still doesn't
> > appear in lspci or ifconfig -a.
>=20
> Uhm, that's a different symptom than "doesn't work" :)
> thanks for clarifying.
>=20
Sorry for being unclear in my first mail :/

> Sounds more like a problem with the Cardbus controller not providing
> access to PCI config space, not telling PCI generic code there is a
> PCI bus below it, or something like that.
>=20
> Can you post "lspci -vvv -s 02:09" output for 2.6.17 as well?
> I'd like to compare the CardBus bridge config info for both (2:09.0
> and 02:09.1) controllers on both kernel releases.
>=20
Here it is:

02:09.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controlle=
r (rev 01)
	Subsystem: Acer Incorporated [ALI] Unknown device 1027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at 80101000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D03, subordinate=3D06, sec-latency=3D176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00007400-000074ff
	I/O window 1: 00007800-000078ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:09.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus Controlle=
r (rev 01)
	Subsystem: Acer Incorporated [ALI] Unknown device 1027
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 80102000 (32-bit, non-prefetchable) [size=3D4K]
	Bus: primary=3D02, secondary=3D07, subordinate=3D0a, sec-latency=3D176
	Memory window 0: 22000000-23fff000 (prefetchable)
	Memory window 1: 28000000-29fff000
	I/O window 0: 00007c00-00007cff
	I/O window 1: 00001000-000010ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

Thanks for your help!
Julien

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEu7ctmEvTgKxfcAwRAs+lAJ4yOwUczPGISw0SdyOUhOTbPccpNQCcDeIB
GHZFUG/ejxUMvw+h7wg19x8=
=e0Iq
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
