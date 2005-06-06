Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVFFJlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFFJlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 05:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVFFJlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 05:41:08 -0400
Received: from smtp2.poczta.interia.pl ([213.25.80.232]:64905 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261256AbVFFJlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 05:41:00 -0400
Message-ID: <42A41A21.5050100@poczta.fm>
Date: Mon, 06 Jun 2005 11:40:49 +0200
From: Lukasz Stelmach <stlman@poczta.fm>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Ananda Krishnan <veedutwo@yahoo.com>
Cc: linux-kernel@vger.kernel.org, veedutwous@yahoo.com
Subject: Re: device-driver supporting more than one device
References: <20050604024830.13002.qmail@web14824.mail.yahoo.com>
In-Reply-To: <20050604024830.13002.qmail@web14824.mail.yahoo.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE89948A55A6CF30E7EF64CE1"
X-EMID: a2396138
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE89948A55A6CF30E7EF64CE1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ananda Krishnan napisa=C5=82(a):
> Hi All,
>=20
>   Can a device-driver (a generic serial driver)
> support more than one device from different vendors
> (hence different vendor ids and device ids)?

In general, yes. Does it apply to the particular driver you mentioned? I
don't know.

> If so,
> during the boot time how the pci_device_id structure
> gets the info about the drvier_data?  Would like to
> know the name of the function name(s) and file(s) that
> are used for this process.  Thanks a lot.

The driver contains IDs of hardware it supports. At the boot time
each driver registers itself providing this list. Then for each piece of
hardware supported by a particular driver .probe function is called.
You should definitly look at /usr/src/linux/drivers/usb/usb-skeleton.c.
However, it is a usb driver, pci seem to work in a similar manner.

You might also like to read this: http://lwn.net/Kernel/LDD3/

I am quite a newbie to kernel drivers so please correct me someone if I
am wrong.

--=20
By=C5=82o mi bardzo mi=C5=82o.                    Trzecia pospolita kl=C4=
=99ska, [...]
>=C5=81ukasz<                      Ju=C5=BC nie katolicka lecz z=C5=82odz=
iejska.  (c)PP


--------------enigE89948A55A6CF30E7EF64CE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCpBomNdzY8sm9K9wRAru/AJ9waSoHL48Ef8zSptPvKADLpMeJKACePgko
JxZqpSkkZZn/gQfF4CHZr90=
=Us+O
-----END PGP SIGNATURE-----

--------------enigE89948A55A6CF30E7EF64CE1--
