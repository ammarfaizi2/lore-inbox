Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbVK0LBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbVK0LBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 06:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVK0LBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 06:01:09 -0500
Received: from mout2.freenet.de ([194.97.50.155]:12727 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750992AbVK0LBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 06:01:07 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Larry Finger <Larry.Finger@lwfinger.net>, linux-kernel@vger.kernel.org
Subject: Re: What are the general causes of frozen system?
Date: Sun, 27 Nov 2005 11:59:46 +0100
User-Agent: KMail/1.8.3
References: <43891D97.4000404@lwfinger.net>
In-Reply-To: <43891D97.4000404@lwfinger.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1442067.czrJdLxX3L";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511271159.47129.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1442067.czrJdLxX3L
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 27 November 2005 03:44, you wrote:
> I am trying to help the bcm43xx project develop a driver for the=20
> Broadcom 43xx wireless chips, using my Linksys WPC54G card.=20
> Unfortunately, since the group got far enough to turn on RX DMA, my=20
> system has frozen whenever I load the driver. TX DMA was OK. It seems to=
=20
> correlate with the receipt of a beacon from my AP, but that cannot be=20
> proven. When the freeze happens, I cannot do anything more and have to=20
> power the system off.
>=20
> What should I consider as a cause of the freeze? I have reviewed the=20
> code and do not find any obvious out-of-bounds memory references. I have=
=20
> tried various 'printk' statements, but none of them in the bottom-half=20
> interrupt routine make it to the logs. Are there any tricks that I=20
> should try?

Enable most of the "Kernel Hacking" Debugging options, like
Memory and spinlock debugging. This will often catch memory corruptions
or deadlocks.

I'm not sure where the freeze happens, from your explanations.
Does it freeze before or after the DMA operations? I am sure we find the
reason, if you talk to us about the problem on IRC or the bcm43xx mailing l=
ist.

=2D-=20
Greetings Michael.

--nextPart1442067.czrJdLxX3L
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDiZGjlb09HEdWDKgRAsTLAKCg4J4pva6diVbNFu2GqmMqbEQueQCeNxaB
yzCYvB79y70M0ss/Ixc93qs=
=/EC2
-----END PGP SIGNATURE-----

--nextPart1442067.czrJdLxX3L--
