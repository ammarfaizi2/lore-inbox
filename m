Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267787AbTBME2I>; Wed, 12 Feb 2003 23:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267809AbTBME2H>; Wed, 12 Feb 2003 23:28:07 -0500
Received: from mithra.wirex.com ([65.102.14.2]:31755 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S267787AbTBME2G>;
	Wed, 12 Feb 2003 23:28:06 -0500
Message-ID: <3E4B211F.8080501@wirex.com>
Date: Wed, 12 Feb 2003 20:37:51 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: magniett <Frederic.Magniette@lri.fr>, torvalds@transmeta.com,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
Subject: Re: What went wrong with LSM, was: Re: [BK PATCH] LSM changes for
 2.5.59
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se> <3E4A9C4D.F580576E@lri.fr> <20030212183812.A14810@infradead.org> <3E4AC92A.4020705@wirex.com> <20030212230550.A19831@infradead.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig05D88AE5A9A97E5ABC857153"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig05D88AE5A9A97E5ABC857153
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

'Christoph Hellwig' wrote:

>On Wed, Feb 12, 2003 at 02:22:34PM -0800, Crispin Cowan wrote:
>
>>LSM does have an abstract design: it mediates 
>>access to major internal kernel objects (processes, inodes, etc.) by 
>>user-space processes, throwing access requests out to the LSM module.
>>    
>>
>We seem to use the term design differently.  And maybe my english
>wording wasn't perfect (I'm no native speaker..).  My objection is that
>LSM by itself does not enforce the tightest bit of security policy
>design.  Your "design" is putting in hooks before object accesses
>without making them tied to enforcing some security policy.
>
You're right, we're using English differently :-) I don't know what the 
above paragraph means. I can guess, but that's where the trouble is 
coming from. Based on the guessing:

    * Yes, LSM by itself does not enforce security policy.
    * Yes, the desing is to put hooks in front of important objects, and
      ask the modules if that access is ok.

The effect of this is to push security policy out to the modules. This 
is what Linus asked for, so that he would not have to maintain security 
policy or security policy engines.

>When reading this thread some people (e.g. David [*]) still seem that
>changes should be done for LSM's sake - but that's entirely wrong.
>The point of getting LSM or something similar in is for the sake
>of the _linux_ _kernel_ getting usefull features, not for enabling
>some small community writing out of tree modules.
>
You have often made this point about "for the Linux kernel's sake" vs. 
some other motivation, and it bothers me. It suggests that you somehow 
care about the Linux kernel more than I do. No, I care about the Linux 
kernel a lot. More over, I don't see how "who cares about the kernel 
more" is pertinent.

That aside, the Linux kernel per se is not some entity to be pleased 
like a stone god. Linux exists for its users. LSM is designed to benefit 
Linux kernel users. Some benefit by being able to add security features 
that they could not get before, because they are not capable of patching 
their own kernels. Some benefit by being able to produce experimental 
security modules without having to patch & track the Linux kernel. Some 
benefit by being able to unload security stuff and go for a leaner 
configuration.

LSM is not about pleasing a small number of module vendors. It is about 
benefiting a large number of potential users.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html
			    Just say ".Nyet"


--------------enig05D88AE5A9A97E5ABC857153
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+SyEf5ZkfjX2CNDARAaixAKCUTRz5kpDYkaPQeSOsSYNk35BBxQCfQaHx
Cbch5vfwYdlFisg/OHC8eow=
=9coV
-----END PGP SIGNATURE-----

--------------enig05D88AE5A9A97E5ABC857153--

