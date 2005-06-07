Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVFGUfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVFGUfm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVFGUfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:35:42 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:47449 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261975AbVFGUf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:35:29 -0400
Message-ID: <42A604AA.2090907@poczta.fm>
Date: Tue, 07 Jun 2005 22:33:46 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Advices for a lcd driver design. (suite)
References: <20050607080404.96919.qmail@web25804.mail.ukl.yahoo.com>
In-Reply-To: <20050607080404.96919.qmail@web25804.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA230CE970F21A97A5ABBDC2"
X-EMID: 106b1138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA230CE970F21A97A5ABBDC2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

moreau francis napisa=C5=82(a):

>>>I posted an email 1 month ago because I was looking for advices to des=
ign
>>>a driver for a lcd device (128x64 pixels) with a t6963c controller.
>>
>>Ugh, whats wrong with standard handling via framebuffer?
>>
> well I already looked at framebuffers and choose to not use them becaus=
e
> t6963c controller does not have a frame buffer memory that can be acces=
sed
> by using mmap.
[...]
> am I wrong in my choice ?

I think the "buffer" could be shadowed in kernel and updated periodically=
=2E

>>>So I wrote another small driver that can be accessed through "/dev/lcd=
". It
>>>drives the lcd only in graphical mode. That means that a=20
>> "echo foo > /dev/lcd"
>>
>>>command won't work as expected.
>>
>>Look at framebuffer, that's what you want. See for example vesafb.
>=20
> Does frame buffer have such mechanism ? if so could you point me the co=
de that
> handles it ?

Yes and no. No because framebuffer is about drawing graphics not text
and yest for there is fbcon console driver on top of the framebuffer. At
least AFAIK.

BTW, have you seen these
http://www.skippari.net/lcd/t6963c_prog.html
http://wwwthep.physik.uni-mainz.de/~frink/lcd-t6963c-0.1/README.html

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enigEA230CE970F21A97A5ABBDC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCpgTFNdzY8sm9K9wRAnKEAJ9fnA/qV4DwBZq9GIAsXIw0RouakwCfRRZ8
RdqWGVIQ+Wy+M66SAmIUEQk=
=S6O4
-----END PGP SIGNATURE-----

--------------enigEA230CE970F21A97A5ABBDC2--
