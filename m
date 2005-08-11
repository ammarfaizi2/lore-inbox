Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVHKQ5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVHKQ5t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVHKQ5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:57:49 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:24711 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751125AbVHKQ5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:57:48 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Bolke de Bruin <bdbruin@aub.nl>
Subject: Re: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA
Date: Thu, 11 Aug 2005 18:58:38 +0200
User-Agent: KMail/1.8.2
References: <42FB72DE.8000703@aub.nl> <200508111819.45325@bilbo.math.uni-mannheim.de> <42FB7FC2.10405@aub.nl>
In-Reply-To: <42FB7FC2.10405@aub.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2568067.pnqs2RUrGK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508111858.45153@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2568067.pnqs2RUrGK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag, 11. August 2005 18:41 schrieben Sie:
>>arrays allocated by the driver eat 2kB each, so a stack overflow is very
>>likely. Even with 8kB stack it is still not impossible. Using the version
>>from 2.6.5 will not be a very good idea I think, it's likely to crash your
>>machine one day.
>>
>:-(
>:
>>The right solution would be fixing the driver to use kmalloc()/kfree() wh=
en
>> he really needs the memory. There was a patch only a few days ago that
>> tried to do that, but it was not really well done and would have crashed.
>> If you are really interested in I can do such a patch. The code of this
>> driver sucks universes through nanotubes, but one day someone _will_ have
>> to start cleaning this up.
>
>Define: really interested
>
>So, probably we are really interested. Though there are a couple of caveat=
s:
>
>- Testing can be done only very limited. We have only one raid array
>available and it is in production

If whatever I do will go wrong you'll see it very fast. Then you can't rece=
ive=20
data ;)

>- Servers are not in yet, but will been in the next couple of weeks
>- As Arjan noted the kernel will be "some vendor 2.6.5". More precisely
>sles9 or rhle 3. This is dictated by the setup of informix 10 on those
>machines, we are stuck with that unfortunately. To be really interesting
>a patch should be backportable to 2.6.5 (or the equivalent rh kernel).

This should be rather simple. Just use their kernel sources, copy the files=
=20
from a newer kernel in and rebuild the module.

>- I am currently investigating if other controllers are able to support
>this raid array and are supported. If so it might be a better idea to
>use those

Yes, if you find some which have a driver that smells less it would be a go=
od=20
idea to use them.

>- We are willing to offer something in exchange. This ranges from 24
>bottles of beer of your choice to something else. The something else
>part needs to be discussed, but the beer part I can be held responsible
>for :-)

*g* I'll remind you ;)

Eike

--nextPart2568067.pnqs2RUrGK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC+4PFXKSJPmm5/E4RAlrEAJ98J0dZRUpoH6KJi+1hmx1/X6n4tACfS80y
lgNGVnoDiPCIQDaUoEDnLDQ=
=kQYW
-----END PGP SIGNATURE-----

--nextPart2568067.pnqs2RUrGK--
