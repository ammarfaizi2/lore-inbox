Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTJCRkZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 13:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTJCRkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 13:40:25 -0400
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:23441 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S263650AbTJCRkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 13:40:23 -0400
Date: Fri, 3 Oct 2003 18:40:18 +0100
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata support for Adaptec 1205SA?
Message-ID: <20031003174018.GA6628@carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	"Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
	linux-kernel@vger.kernel.org
References: <3F7D9C83.4050200@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <3F7D9C83.4050200@backtobasicsmgmt.com>
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2003 at 08:57:55AM -0700, Kevin P. Fleming wrote:
> I need to add some SATA ports to a system, not RAID, just plain SATA 
> ports. I've found the SIIG SC-SAT212 which is based on the Sil3112A 
> chip, but may not fit in my low-profile case. 

   I just happen to have an SC-SAT212 sitting in front of me, as a
replacement for my Adaptec 1210SA which doesn't work in Linux. :(

   The card is 64mm from the top edge to the bottom of the PCI pins,
and 56mm from the top edge to the edge of the "cutout" on the card
(i.e. the top edge of the PCI slot). Bear in mind though that the SATA
data cable is going to stick up at least 15mm beyond the top of the
card.

> There is also the Adaptec 1205SA which already is a low-profile
> card, but I can't seem to find any information on the 'net as to
> which chip it uses.

   I don't know for certain, *but* the AAR-1210SA definitely uses the
SiI3112 chip (slightly mangled), and I'd be surprised if Adaptec used
a different chip for the 1205SA. There's a picture of the 1210SA card
on Adaptec's site which is just about good enough to see the shape of
the word "SiI" on the chip surface -- there may be an equivalent
picture for the 1205SA.

   Bear in mind, though, that the 1210SA doesn't seem to play exactly
like other SiI3112 cards, and keeps dropping interrupts. This makes it
effectively useless for anything practical. You may want to take this
into account when thinking of Adaptec SATA kit.

> Does anyone here know, and more importantly, is libata ready to 
> support it? I want to build a 6-drive SATA RAID using software RAID 5 
> (can't just the expense of a 3ware card for this application), so I 
> need to add four ports to the two already present on an ICH5 on the 
> motherboard.

   AFAIK, libata doesn't support SiI3112 yet. Jeff has promised it at
some point -- possibly as the next SATA chip to support.

   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
           --- There are three mistaiks in this sentance. ---            

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/fbSCssJ7whwzWGARAg8xAJ4sxdU+eUcfido8yOyw/4hMJ58SRACggPNh
twqCMKqeTHSkelUJrG+jb3w=
=cHSM
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
