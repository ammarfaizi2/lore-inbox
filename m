Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbTHaNN6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTHaNN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:13:58 -0400
Received: from rgnb-d9b87606.pool.mediaWays.net ([217.184.118.6]:61830 "EHLO
	pec-84-66.tnt6.m2.uunet.de") by vger.kernel.org with ESMTP
	id S261941AbTHaNNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:13:52 -0400
Date: Sun, 31 Aug 2003 15:13:13 +0200
From: M G Berberich <berberic@fmi.uni-passau.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 experiences
Message-ID: <20030831131313.GA1049@wiland.intern>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

i tried 2.6.0-test on a laptop (Sony Vaio FX502, AMD Mobile Duron
1GHz)

With a PCMCIA-Modem (ELSA Microlink 56k MC Internet, a V.90 Modem) I
have only 1/3 throughput with 2.6.0-test4 compared to a 2.4.X kernel
(which gives the normal throughput for 56k modem).

     Yenta: CardBus bridge found at 0000:00:0a.0 [104d:80f6]
     Yenta IRQ list 0008, PCI irq11
     Socket status: 30000010
     Yenta: CardBus bridge found at 0000:00:0a.1 [104d:80f6]
     Yenta IRQ list 0008, PCI irq10
     Socket status: 30000006
     cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xdc000-=
0xdffff 0xe4000-0xfffff
     serial_cs: RequestIRQ: Unsupported mode
     ttyS1 at I/O 0x2f8 (irq =3D 0) is a 16550A   =20
     ...
     ttyS1: 1 input overrun(s)

pulling the card out I get

     Trying to free nonexistent resource <000002f8-000002ff>

pushing it in again I get:

     serial_cs: RequestIRQ: Unsupported mode
     ttyS1 at I/O 0x2f8 (irq =3D 0) is a 16550A

lspci says:
     00:0a.0 CardBus bridge: Texas Instruments PCI1420
     00:0a.1 CardBus bridge: Texas Instruments PCI1420

So it seems the card is not getting an interrupt with 2.6.0-test4 for
some reason I don't understand.

BTW: 'serial_cs' has been renamed to '8250-cs' but there are still
references to 'serial_cs' in source, messages, Kconfig ("The module
will be called serial_cs.") and Documentation.

I'm not on kernel-mailing-list.

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  |

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/UfRpnp4msu7jrxMRAhOaAJ4sYVABfG8KzAPvxY986zbKHw73VgCeJ6MM
UeC16cudqtXh1IASlz5o5r0=
=xm1A
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
