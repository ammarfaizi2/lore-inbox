Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTBJDa4>; Sun, 9 Feb 2003 22:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbTBJDaz>; Sun, 9 Feb 2003 22:30:55 -0500
Received: from mithra.wirex.com ([65.102.14.2]:18693 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S261356AbTBJDaw>;
	Sun, 9 Feb 2003 22:30:52 -0500
Message-ID: <3E471F21.4010803@wirex.com>
Date: Sun, 09 Feb 2003 19:40:17 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LA Walsh <law@tlinx.org>
Cc: "'Christoph Hellwig'" <hch@infradead.org>, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
References: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigAFD7B6430F191C642C988C1A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAFD7B6430F191C642C988C1A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

LA Walsh wrote:

>>From: Crispin Cowan
>>
>>LSM does have a careful design.... meeting a 
>>goal stated by Linus nearly two years ago.
>>    
>>
>	A security model that mediates access to security objects by
>logging all access and blocking access if logging cannot continue is
>unsupportable in any straight forward, efficient and/or non-kludgy, ugly
>way. 
>
Because Linus asked for access control support, not audit logging 
support, it is not surprising that logging models don't fit so well.

>  Some security people were banned from the kernel
>devel. summit because their thoughts were deemed 'dangerous': fear was they
>were too persuasive about ideas that were deemed 'ignorant' and would
>fool those poor kernel lambs at the summit.
>
Internal SGI politics.

>	Also unsupported: The "no-security" model -- where all security 
>is thrown out (to save memory space and cycles) that was desired for embedded work.
>
False: capabilities is now a removable module, which is what Linus asked 
for.

>	LSM also doesn't support standard LSPP-B1 style graded security
>where mandatory access checks are logged as security violations before
>DAC checks are even looked at for an object.
>
Because doing so would have required approx. 6-10X as many LSM hooks as 
the current LSM. Speak up if you think LSM should be 10X bigger to be 
able to support Common Criteria standards compliant audit logging ...

>	At one point a plan was proposed (by Casey Schaufler, SGI) and 
>_\implemented\_ (team members & prjct lead Linda Walsh) to move all
>security checks out of the kernel into a 'default policy' module.
>The code to implement this was submitted to the LSM list in June 1991.
>
And I actually like that plan. But I still believe it to be too radical 
for 2.6. It has many nice properties, but is much more invasive to the 
kernel. I think it is a very interesting idea for 2.7, and should be 
floated past the maintainers who will be impacted to see if it has a 
hope in hell.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html
			    Just say ".Nyet"


--------------enigAFD7B6430F191C642C988C1A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Rx8o5ZkfjX2CNDARAaf4AJ96UU5EQ1qTi0fu9OUt0LU77y8rYwCfRNE7
vzwilVzhD8It1Y9IkMieYgs=
=D4oT
-----END PGP SIGNATURE-----

--------------enigAFD7B6430F191C642C988C1A--

