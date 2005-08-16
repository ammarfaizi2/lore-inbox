Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbVHPPGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbVHPPGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 11:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965265AbVHPPGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 11:06:18 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:9631 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965262AbVHPPGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 11:06:15 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13-rc6] remove dead reset function from cpqfcTS driver
Date: Tue, 16 Aug 2005 17:07:48 +0200
User-Agent: KMail/1.8.2
Cc: "Martin K. Petersen" <mkp@mkp.net>, Christoph Hellwig <hch@infradead.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161137.37749@bilbo.math.uni-mannheim.de> <yq14q9qdjig.fsf@wilson.lab.mkp.net>
In-Reply-To: <yq14q9qdjig.fsf@wilson.lab.mkp.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4839344.7JXZs6uu73";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508161707.57101@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4839344.7JXZs6uu73
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Martin K. Petersen wrote:
>>>>>> "Rolf" =3D=3D Rolf Eike Beer <eike-kernel@sf-tec.de> writes:
>
>Hey Rolf!

I should go and use "R. Eike Beer" ;)

>Rolf> There was a request on lkml last week for a working version of
>Rolf> this driver. For the moment I try to clean this up a bit before
>Rolf> doing some real work. I found 4 major things that should be
>Rolf> done, for half of them I have patches in a proof-of-concept
>Rolf> state.
>
>As Christoph said I'm working on a driver for the TachLite TL/TS/XL2
>chips.
>
>Initially I just wanted to add support for the integrated PHY on XL2
>so we could support those cards on PA-RISC.  But when I started
>looking at the driver I came to the conclusion that it was just too
>ugly to live.  Architecturally, the overall design of cpqfc just
>doesn't fit in well with Linux.  So I'm rewriting it from scratch -
>but that obviously takes a while.

>I think it's cool that you want to hack on cpqfcTS.  But be aware that
>it's not just a matter of running lindent and making it compile in
>2.6.late.  And without hardware it's going to be hard.  Fibre channel
>is very finicky.

=46or the moment I'm trying to fix the most buggy parts. The Lindent run is=
=20
scheduled to be done last, it's too big and adds nothing if it would go int=
o=20
kernel for now. It won't even compile now, my tests are only compile tests=
=20
done with the two #error commented out. That should prevent most users from=
=20
using it without all patches applied. The rest either knows what he's doing=
=20
and/or would get crashes anyway ;)

Next to come will be splitting up the ISR and then fixing the #errors. Afte=
r=20
this is might even work. :)

>If you manage to get your hands on hardware (cards - avoid Tachyon
>5000 series. TachLite 5100, 5166 or 5200 is what you want, disk array,
>hub/switch, GBICs, etc.) I wouldn't mind some help...

Give me some code and we can see...

Bolke, what kind of adapter do you have?

Eike

--nextPart4839344.7JXZs6uu73
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAgFMXKSJPmm5/E4RAue+AJ4vTneSwUZAAGHCPxk6uxVUPH1nLwCgldhd
yGE6eYy7V6qqAFSh9mxiBE8=
=BN2O
-----END PGP SIGNATURE-----

--nextPart4839344.7JXZs6uu73--
