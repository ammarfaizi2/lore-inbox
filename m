Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSJQRjK>; Thu, 17 Oct 2002 13:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261683AbSJQRjK>; Thu, 17 Oct 2002 13:39:10 -0400
Received: from mithra.wirex.com ([65.102.14.2]:45068 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S261545AbSJQRjI>;
	Thu, 17 Oct 2002 13:39:08 -0400
Message-ID: <3DAEF703.20009@wirex.com>
Date: Thu, 17 Oct 2002 10:44:35 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org,
       Linux Security Module <linux-security-module@wirex.com>
Subject: Re: [PATCH] make LSM register functions GPLonly exports
References: <Pine.LNX.4.44.0210170958340.6739-100000@home.transmeta.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigBD4AF37B1CDD6D6701167A1D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD4AF37B1CDD6D6701167A1D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

>Note that if this fight ends up being a major issue, I'm just going to 
>remove LSM and let the security vendors do their own thing.
>
If it comes to that, go ahead and apply the patch. I would far rather 
have an LSM that requires GPL'd modules than no LSM at all.

> So far
>
> - I have not seen a lot of actual usage of the hooks
>
There are half a dozen modules here http://lsm.immunix.org/lsm_modules.html

I suspect there is a lot more use of LSM pending, and it will appear 
when the LSM interface stops changing, and when Linux 2.6 (or 3.0, 
whatever) appears. See for example the cover story in the September 2002 
Linux Journal: an LSM module being built by Ericsson Research for telco 
purposes.

>I will re-iterate my stance on the GPL and kernel modules:
>
>  There is NOTHING in the kernel license that allows modules to be 
>  non-GPL'd. 
>
>  The _only_ thing that allows for non-GPL modules is copyright law, and 
>  in particular the "derived work" issue. A vendor who distributes non-GPL 
>  modules is _not_ protected by the module interface per se, and should 
>  feel very confident that they can show in a court of law that the code 
>  is not derived.
>
Thanks for the clarification, but that still leaves questions. In 
particular, it is unclear whether a work is "derived" if it includes 
kernel header files, which is more or less required if you hope to make 
a module fit the interface.

Note that if we decide that #include of a kernel header file means that 
a work is derived, then we cause another problem: most Linux 
applications come under the GPL.  glibc #includes some kernel header 
files, and most Linux applications #include glibc headers, so most 
applications are #including kernel header files. If #include is the 
basis for declaring a module to be a derived work of the kernel, then 
there is some bad news coming for people who like to use Oracle and DB2 
on Linux ...

Thanks,
    Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


--------------enigBD4AF37B1CDD6D6701167A1D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9rvcD5ZkfjX2CNDARAVquAJ9555OeCDEhfpc6AhYTE8s22YTdugCZAcCJ
0A+RAWa2OKVdhtX2LmP4O5s=
=Cq26
-----END PGP SIGNATURE-----

--------------enigBD4AF37B1CDD6D6701167A1D--

