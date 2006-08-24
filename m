Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWHXRUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWHXRUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 13:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbWHXRUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 13:20:31 -0400
Received: from VPRMAIL.tamu.edu ([165.91.119.178]:1485 "EHLO vprmail.tamu.edu")
	by vger.kernel.org with ESMTP id S1030408AbWHXRUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 13:20:30 -0400
From: "Michael M. Dwyer" <mdwyer@vprmail.tamu.edu>
Organization: Texas A&M University
To: linux-kernel@vger.kernel.org
Subject: Re: tg3 timeouts with 2.6.17-rc6
Date: Thu, 24 Aug 2006 12:19:52 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3924827.rfnLD0BMeu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608241219.57572.mdwyer@vprmail.tamu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3924827.rfnLD0BMeu
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > David, Here's the patch if you haven't already made one:
> >
> > [TG3]: Disable TSO by default on 5780 class chips.
>
> Sorry, I didn't get a chance to push this into 2.6.17
> in time. I will push it into the first 2.6.17.x -stable
> release.

I just wanted to mention that I also have had this problem with tg3 on my D=
ell=20
Optiplex 280.  Here's my dmesg info:

> tg3.c:v3.59 (June 8, 2006)
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCI Express)
> 10/100/1000BaseT E thernet 00:12:3f:4d:a5:bd
> eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1]
> TSOcap[1] eth0: dma_rwctrl[76180000] dma_mask[64-bit]

I wasn't sure if BCM95751 was covered by "5780 class chips".

The problem didn't show up for >3 days after I upgraded to 2.6.17=20
(Gentoo-sources, 2.6.17-r4 to be exact).  Problem was most evident during=20
bittorrent download.  Setting TSO to off seems have solved it.  If there's=
=20
any other information you'd like from me, please let me know.

Thanks,
Mike

=2D-=20
Michael Dwyer, Programmer/Analyst II
Vice President for Research
Texas A&M University, College Station
mdwyer@vprmail.tamu.edu
979.845.3295

--nextPart3924827.rfnLD0BMeu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQBE7d+9MBFb1FotgRoRAnvBAJ9OUIXxa5bUy2JNL0irFemgiGp/KwCfc9oI
S33qiiLPyfsMkdlrx3WNr94=
=8qL2
-----END PGP SIGNATURE-----

--nextPart3924827.rfnLD0BMeu--
