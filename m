Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVGVXTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVGVXTp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVGVXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:17:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:9926 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262217AbVGVXR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:17:26 -0400
Message-ID: <42E17E7B.6090805@us.ibm.com>
Date: Fri, 22 Jul 2005 16:17:15 -0700
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serverworks should not take ahold of megaraid'd controllers
References: <42E023B2.5030900@us.ibm.com> <1121993194.854.14.camel@localhost.localdomain>
In-Reply-To: <1121993194.854.14.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCAC76465A93FDC269A56172B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAC76465A93FDC269A56172B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Arjan, Alan:

I didn't know that dmraid supports MegaIDE nowadays.  Thanks for the
tipoff, and I apologize for the unnecessary traffic.  I'll look into dmraid.

--D

Alan Cox wrote:
> On Iau, 2005-07-21 at 15:37 -0700, Darrick J. Wong wrote:
> 
>>I've noticed what might be a small bug with the serverworks driver in
>>2.6.12.3.  The IBM HS20 blade has a ServerWorks CSB6 IDE controller with
>>an optional LSI MegaIDE RAID BIOS (BIOS assisted software raid, iow).
> 
> 
> With a binary only proprietary driver.
> 
> 
>>(ServerWorks) to IBM.  However, the serverworks driver doesn't notice
>>this and will attach to the controller anyway, thus allowing raw access
>>to the disks in the RAID.  An unsuspecting user can then read and write
>>whatever they want to the drive, which could very well degrade or
>>destroy the array, which is clearly not desirable behavior.
> 
> 
> It may be appropriate for some vendor situations but it isn't
> appropriate for the base kernel to default to assuming the user wants to
> use binary only drivers instead of dmraid. Especially as the raid
> formats for this hardware are partially known despite no assistance I
> know of from the vendor.
> 
> Alan
> 
> 

--------------enigCAC76465A93FDC269A56172B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC4X57a6vRYYgWQuURAgqKAJwIJ0DNjCbQGjY6tloriFBzJSvUzQCeMpF8
1kIuPjwcHSoeEoe4/NIdfEE=
=WXjk
-----END PGP SIGNATURE-----

--------------enigCAC76465A93FDC269A56172B--
