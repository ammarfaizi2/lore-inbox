Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWIUSg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWIUSg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIUSg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:36:27 -0400
Received: from smtp19.orange.fr ([80.12.242.17]:43194 "EHLO
	smtp-msa-out19.orange.fr") by vger.kernel.org with ESMTP
	id S1751440AbWIUSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:36:26 -0400
X-ME-UUID: 20060921183625465.7192D1C0029D@mwinf1911.orange.fr
From: Vincent Pelletier <vincent.plr@wanadoo.fr>
To: Ludovic Drolez <ldrolez@linbox.com>
Subject: Re: [PATCH] sched.c: Be a bit more conservative in SMP
Date: Thu, 21 Sep 2006 20:36:18 +0200
User-Agent: KMail/1.9.4
Cc: Antonio Vargas <windenntw@gmail.com>, linux-kernel@vger.kernel.org
References: <200609031541.39984.subdino2004@yahoo.fr> <69304d110609191050w777a5c48ibe84bc0e3ce65df3@mail.gmail.com> <4510F0FD.4060602@linbox.com>
In-Reply-To: <4510F0FD.4060602@linbox.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart39966094.NtZhisrhdi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609212036.24856.vincent.plr@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart39966094.NtZhisrhdi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le mercredi 20 septembre 2006 09:42, Ludovic Drolez a =E9crit=A0:
> Yes ! That might be a better idea !
> In fact, I tested the 1st patch on our cluster (Finite elements computing
> on 8 CPUs):
> - Under Windows: 875 seconds
> - Linux 2.6.16 : 1019 s
> - Linux 2.6.16 + manual taskset : 842 s
> - Linux 2.6.16 + Vincent's patch : 1373 s  :-(

I was afraid of this :/.
I did some quick tests, and I got non-significant results. I tried building=
 a=20
kernel with different make -j parameters, and there was like a few seconds =
of=20
difference, and not always in favour of the same version.

I find it strange that you get such horrible results...
Maybe I was completely wrong with my assumption that one running process=20
always has an impact of 1, which would have make the scheduler underestimat=
e=20
the load on one cpu and put too many processes on it, without moving them=20
afterward.

=2D-=20
Vincent Pelletier

--nextPart39966094.NtZhisrhdi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFEtuoFEQoKRQyjtURAiLbAJ0fSAm+nCadJLUaNJSq11LbfUbddACcDJTv
N79V3nIFwhZVDRijwKML0Ug=
=Je1D
-----END PGP SIGNATURE-----

--nextPart39966094.NtZhisrhdi--
