Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUHGVmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUHGVmu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 17:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUHGVmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 17:42:50 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:41449 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264097AbUHGVmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 17:42:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: architectures with their own "config PCMCIA"
Date: Sat, 7 Aug 2004 23:41:17 +0200
User-Agent: KMail/1.6.2
Cc: Adrian Bunk <bunk@fs.tum.de>, Christoph Hellwig <hch@infradead.org>,
       wli@holomorphy.com, "David S. Miller" <davem@redhat.com>,
       schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de> <200408072013.01168.arnd@arndb.de> <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0408072234290.23642@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_9xUFBrbRPHm/0mK";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408072341.17721.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_9xUFBrbRPHm/0mK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Samstag, 7. August 2004 22:36, Geert Uytterhoeven wrote:
> I've been `fixing up' many of them lately. Please give it a try.
> Anyway, probably all additional clean ups you do for s390 are useful for =
m68k
> as well ;-)

Yes, most devices drivers that rely on ISA or PCI attachment now
appear to be gone.

However, I just tried and found that out of the 23 driver submenus, only
"Generic Driver Options", "Block devices", "SCSI device support",
"Multi-device support", "Networking support" and "Character devices"
make any sense at all. All others depend on some hardware that has
never been attached to an s390 box.=20

We could of course build some subsystems like MTD, ISDN or FB, but
there is still little point without any low-level drivers.

	Arnd <><

--Boundary-02=_9xUFBrbRPHm/0mK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBFUx95t5GS2LDRf4RArfdAJsF/YxSdaEVkYBM6TVKvjS5zkpPdgCggUdl
bMlel72lryEHUERf1SzD0Os=
=eFKu
-----END PGP SIGNATURE-----

--Boundary-02=_9xUFBrbRPHm/0mK--
