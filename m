Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVA0UQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVA0UQb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVA0UPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:15:22 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:20125 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261165AbVA0UMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:12:48 -0500
Message-ID: <41F94B5A.2030301@comcast.net>
Date: Thu, 27 Jan 2005 15:13:14 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-os@analogic.com, Linux kernel <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>	 <20050127101322.GE9760@infradead.org> <41F92721.1030903@comcast.net>	 <1106848051.5624.110.camel@laptopd505.fenrus.org>	 <41F92D2B.4090302@comcast.net>	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>	 <Pine.LNX.4.61.0501271414010.23221@chaos.analogic.com> <1106856178.5624.128.camel@laptopd505.fenrus.org>
In-Reply-To: <1106856178.5624.128.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0174DF9DFE53F773F711DD77"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0174DF9DFE53F773F711DD77
Content-Type: multipart/mixed;
 boundary="------------000203030005050400070805"

This is a multi-part message in MIME format.
--------------000203030005050400070805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In other words, no :)

Here's self-exploiting code to discover its own return address offset
and exploit itself.  It'll lend some insight into how this stuff works.

Just a toy.

Arjan van de Ven wrote:
> On Thu, 2005-01-27 at 14:19 -0500, linux-os wrote:
> 
>>Gentlemen,
>>
>>Isn't the return address on the stack an offset in the
>>code (.text) segment?
>>
>>How would a random stack-pointer value help? I think you would
>>need to start a program at a random offset, not the stack!
>>No stack-smasher that worked would care about the value of
>>the stack-pointer.
> 
> 
> the simple stack exploit works by overflowing a buffer ON THE STACK with
> a "dirty payload and then also overwriting the return address to point
> back into that buffer.
> 
> (all the security guys on this list will now cringe about this over
> simplification; yes reality is more complex but lets keep the
> explenation simple for Richard) 
> 
> pointing back into that buffer needs the address of that buffer. That
> buffer is on the stack, which is now randomized.
> 
> 
> 

-- 
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.


--------------000203030005050400070805
Content-Type: text/plain;
 name="exploit.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="exploit.c"

I2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxp
Yi5oPgoKaW50IHBheWxvYWQoKTsKaW50IGV4cGxvaXQoY2hhciAqZCk7CgoKaW50IG1haW4o
KSB7CglpbnQgZGlzdGFuY2U7CgljaGFyIGFbNTEyXSA9IHswfTsKCWRpc3RhbmNlID0gZXhw
bG9pdChOVUxMKTsKCW1lbXNldChhLCAweEZGLCBkaXN0YW5jZSk7CgkvKkdldCBvdXIgcGF5
bG9hZCBhZGRyZXNzKi8KCSoodm9pZCoqKShhICsgZGlzdGFuY2UpID0gJnBheWxvYWQ7Cgkq
KHZvaWQqKikoYSArIGRpc3RhbmNlICsgc2l6ZW9mKHZvaWQqKSkgPSAwOyAvKmNhcCovCgkv
KmV4cGxvaXQgdGhlIHBheWxvYWQqLwoJZXhwbG9pdChhKTsKCS8qd2UgbmV2ZXIgcmVhY2gg
dGhpcyovCglyZXR1cm4gMjU1Owp9CgovKgogKiBleHBsb2l0KCkKICogVGhpcyBvdmVyZmxv
d3MgaXRzIG93biBidWZmZXJzIGFuZCBjYXVzZXMgdGhlIHJldHVybiB0byBqdW1wIHRvIHBh
eWxvYWQoKQogKi8KaW50IGV4cGxvaXQoY2hhciAqZCkgewoJY2hhciBhWzQwMF0gPSB7MH07
Cgl2b2lkICppOwoJaW50IGRpc3RhbmNlID0gMDsKCWNoYXIgcGF5bGRbc2l6ZW9mKHZvaWQq
KSArIDFdOwoJdm9pZCAqbXlyZXQ7Cgl2b2lkICp6OwoKCWlmICghZCkgewoJCW15cmV0ID0g
X19idWlsdGluX3JldHVybl9hZGRyZXNzKDApOwoJCS8qZmluZCB0aGUgZGlzdGFuY2UgYmV0
d2VlbiBhIGFuZCBteXJldCovCgkJZm9yIChpID0gKHZvaWQqKWE7ICoodm9pZCoqKWkgIT0g
bXlyZXQ7IGkrKykgewoJCQlkaXN0YW5jZSsrOwoJCX0KCQlyZXR1cm4gZGlzdGFuY2U7Cgl9
CgkvKldlJ3JlIHBhc3NlZCBhIGQgYnVmZmVyLCBzbyBzdHJjcHkgaXQgdW5zYWZlbHkqLwoJ
c3RyY3B5KGEsZCk7CgkvKlJldHVybiB0byBwYXlsb2FkKCkqLwoJcmV0dXJuIDE7Cgp9Cgpp
bnQgcGF5bG9hZCgpIHsKCXByaW50ZigiUGF5bG9hZCBleGVjdXRlZCBzdWNjZXNzZnVsbHkh
XG4iKTsKCS8qMDogIFVuc2FmZTsgc3VjY2Vzc2Z1bCBleHBsb2l0Ki8KCV9leGl0KDApOwp9
Cg==
--------------000203030005050400070805--

--------------enig0174DF9DFE53F773F711DD77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+UtahDd4aOud5P8RAigoAJoDxFIHZDX0CJCfNPzbQ40Uj1tkXACdFkLA
Qg1WO6OusEfMVhIKMyV0tKk=
=Y+fg
-----END PGP SIGNATURE-----

--------------enig0174DF9DFE53F773F711DD77--
