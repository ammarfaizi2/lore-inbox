Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbVAER2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbVAER2K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVAER1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:27:47 -0500
Received: from pop.gmx.de ([213.165.64.20]:16317 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262288AbVAER01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:26:27 -0500
X-Authenticated: #4512188
Message-ID: <41DC2353.7010206@gmx.de>
Date: Wed, 05 Jan 2005 18:26:43 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050103)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: APIC/LAPIC hanging problems on nForce2 system.
References: <Pine.LNX.4.60.0501051604200.24191@kepler.fjfi.cvut.cz> <41DC1AD7.7000705@gmx.de> <Pine.LNX.4.60.0501051757300.25946@kepler.fjfi.cvut.cz> <41DC2113.8080604@gmx.de> <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0501051821430.25946@kepler.fjfi.cvut.cz>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD8CBC864DA65142A737EAD5C"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD8CBC864DA65142A737EAD5C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Martin Drab schrieb:
>
> On Wed, 5 Jan 2005, Prakash K. Cheemplavam wrote:
>
>
>>Martin Drab schrieb:
>>Just to avoid confusion: If your bios does *not contain the fix, the
>>kernel should fix it and above line should appear. (It does here with
>>2.6.10) So if it doesn't in your case (and your bios does not contain
>>that fix), the detection code probably isn't enough. -> This should be
>>fixed in kernel.
>>
>>When you use a fixed bios though, above line should not appear, and your
>>system should be stable.
>
>
> Is there some other way to get to know whether BIOS contains the fix
> allready?

lspci -xxx

then check

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
00: de 10 e0 01 06 00 b0 00 c1 00 00 06 00 00 80 00
10: 08 00 00 a0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 00 1c
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 02 60 30 00 1b 42 00 1f 02 03 00 00 ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 08 00 01 20 20 00 88 80 10 00 00 00 01 ff 01 9f <----
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: 00 01 00 00 ff ff ff 3f 01 00 00 00 01 80 00 00
90: 14 80 40 a7 14 80 40 a5 00 30 00 00 00 00 00 00
a0: 40 00 00 00 32 fb 10 00 01 00 00 00 00 00 00 00
b0: cc ff 07 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 33 33 03 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: d6 01 47 00 16 30 00 10 00 00 00 00 00 00 00 00
f0: 0f 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00


 From fixup.c:
          * Chip  Old value   New value
          * C17   0x1F0FFF01  0x1F01FF01
          * C18D  0x9F0FFF01  0x9F01FF01

If there is old value, it needs to be fixed.

Prakash

--------------enigD8CBC864DA65142A737EAD5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFB3CNTxU2n/+9+t5gRAuUKAKCPGvEVz9ndObB5CjzdnTvQtr+f9gCeNaTb
Naqk6LfVs7Jq5eJ0GuKGFnI=
=LsYa
-----END PGP SIGNATURE-----

--------------enigD8CBC864DA65142A737EAD5C--
