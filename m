Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbUBOISP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 03:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUBOISP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 03:18:15 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:151 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264376AbUBOISD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 03:18:03 -0500
Subject: Re: [BK PATCHES] 2.6.x libata update
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Jon Smirl <jonsmirl@yahoo.com>
In-Reply-To: <402E85EE.70801@pobox.com>
References: <20040213184316.GA28871@gtf.org>
	 <1076700491.22542.38.camel@nosferatu.lan>  <402D3B97.70005@pobox.com>
	 <1076783378.27648.3.camel@nosferatu.lan>  <402E85EE.70801@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LbcXLv+T9T1TfZ/fLetI"
Message-Id: <1076833119.27648.15.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 15 Feb 2004 10:18:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LbcXLv+T9T1TfZ/fLetI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-02-14 at 22:32, Jeff Garzik wrote:
> Martin Schlemmer wrote:
> > Yep, it still breaks it.  I get a dma timeout on heavy disk access,
> > and then things start to freeze (or do not start at all).  Seems
> > Jon is hitting the same issue with -bk4.
>=20
> Thanks for re-verifying.  The buggy patch is now reverted upstream, and=20
> I'll be looking into another way to fix the "too many interrupts on=20
> ICH5" problem.
>=20

Stupid question - its not maybe fixed in later revisions of the
controller (also those this breaks)?  I never had the heavy interrupts
problem some seems to have ...

--
 # cat /proc/interrupts
           CPU0       CPU1
  0:   64547502   64536877    IO-APIC-edge  timer
  2:          0          0          XT-PIC  cascade
  8:       6702        945    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:        244        142    IO-APIC-edge  ide0
 15:         35         62    IO-APIC-edge  ide1
169:    1287568    1399519   IO-APIC-level  libata, uhci_hcd, eth0
177:     746886     747222   IO-APIC-level  Intel ICH5
185:    5637855    5624744   IO-APIC-level  uhci_hcd, uhci_hcd, nvidia
193:          0          0   IO-APIC-level  uhci_hcd
201:          0          0   IO-APIC-level  ehci_hcd
NMI:          0          0
LOC:  129049693  129049832
ERR:          0
MIS:          0
--

(yes, with the patch it happens without nvidia as well)

--
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 2)=
.
      IRQ 169.
      I/O at 0xfc00 [0xfc0f].
      Non-prefetchable 32 bit memory at 0x40000000 [0x400003ff].
  Bus  0, device  31, function  2:
    IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 2)=
.
      IRQ 169.
      I/O at 0xefe0 [0xefe7].
      I/O at 0xefac [0xefaf].
      I/O at 0xefa0 [0xefa7].
      I/O at 0xefa8 [0xefab].
      I/O at 0xef90 [0xef9f].
--


--=20
Martin Schlemmer

--=-LbcXLv+T9T1TfZ/fLetI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBALytfqburzKaJYLYRAlzAAKCMP8r2zy6+/azEHZq/VtcPDeS7aACeIHZc
hCOIEupXiOOW5oZpeLdZeDo=
=3s/l
-----END PGP SIGNATURE-----

--=-LbcXLv+T9T1TfZ/fLetI--

