Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVLEO2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVLEO2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbVLEO2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:28:52 -0500
Received: from mout2.freenet.de ([194.97.50.155]:25024 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1751373AbVLEO2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:28:50 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: [Bcm43xx-dev] Broadcom 43xx first results
Date: Mon, 5 Dec 2005 15:28:32 +0100
User-Agent: KMail/1.8.3
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de> <200512051208.16241.mbuesch@freenet.de> <20051205141935.GC8940@jm.kir.nu>
In-Reply-To: <20051205141935.GC8940@jm.kir.nu>
Cc: bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Feyd <feyd@seznam.cz>
MIME-Version: 1.0
Message-Id: <200512051528.33146.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart3164103.eIFhCFF4k1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3164103.eIFhCFF4k1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 05 December 2005 15:19, you wrote:
> On Mon, Dec 05, 2005 at 12:08:16PM +0100, Michael Buesch wrote:
>=20
> > The SoftMAC is a separate module. That is _good_, so devices like
> > the ipw do not have to load the code, because they do not need it.
> > The SoftMAC ties (and integrates) very close to the ieee80211 subsystem.
>=20
> I like the modular design..
>=20
> > You see that SoftMAC is not exactly a part or the ieee80211 subsystem,
> > but it uses its interface to TX a frame (and the struct to get
> > some information about the device).
>=20
> .. but I disagree with this. If there is functionality like generating
> management frames, it is very much part of the ieee80211 subsystem in my
> opinion.

Think of SoftMAC as an extension to ieee80211.

> > This all works fine. There is absolutely no need to bloat the
> > ieee80211 layer with functionality, which is not needed by all devices.
>=20
> I'm afraid of this leading to duplicated work since ieee80211 stack is
> being used without this new SoftMAC code for devices that do need host
> CPU to take care of functionality that is currently in SoftMAC module
> and will be added to ieee80211 subsystem.

Well, I do not care for drivers ignoring SoftMAC and duplicating
the work. The question is: Why don't these drivers use SoftMAC?
(Yeah, because it is incomplete, is the answer. :D I am talking
about future.)
What is so hard about a driver including ieee80211.h _and_
ieee80211softmac.h, if it requires Software MAC? And what
exactly is duplicated work here? SoftMAC does _not_ duplicate;
it extends.

=2D-=20
Greetings Michael.

--nextPart3164103.eIFhCFF4k1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDlE6Rlb09HEdWDKgRAhdSAKCn83no3WQmMWf1T71yAn/m9J/4UQCghe39
ClKQ2XOqqLL4e/T9Lf72/8Y=
=vGNm
-----END PGP SIGNATURE-----

--nextPart3164103.eIFhCFF4k1--
