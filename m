Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267891AbTBLWMw>; Wed, 12 Feb 2003 17:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBLWMw>; Wed, 12 Feb 2003 17:12:52 -0500
Received: from mithra.wirex.com ([65.102.14.2]:18185 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S267891AbTBLWMu>;
	Wed, 12 Feb 2003 17:12:50 -0500
Message-ID: <3E4AC92A.4020705@wirex.com>
Date: Wed, 12 Feb 2003 14:22:34 -0800
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
Subject: Re: [BK PATCH] LSM changes for 2.5.59
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se>	<3E4A9C4D.F580576E@lri.fr> <20030212183812.A14810@infradead.org>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enigE17B53C43C2991A8E5B296A4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE17B53C43C2991A8E5B296A4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

'Christoph Hellwig' wrote:

>[argg, any chance you two could get RFC-complaint mailers?]
>
>On Wed, Feb 12, 2003 at 07:11:09PM +0000, magniett wrote:
>  
>
>>exist. For finishing : PLEASE, stop reducing LSM possibilities : it cost a lot to develop things for a hook and then
>>redevelopping it for a classical syscall interposition.
>>    
>>
>There's no one taking away the LSM patches.  Anyway life would be a lot
>simpler if you actually announced the stuff you do on lkml instead of hiding
>behind the moon.  The only chance hook you need will stay is that you
>discuss them publically here.
>
For the second time in a week, I agree with HCH: If you are developing 
an LSM module, then by all means please make it publicly known. Whether 
we host your source or not, we want to at least link to your site from 
http://lsm.immunix.org/lsm_modules.html

WRT "taking away LSM patches": HCH wants to remove hooks that "no one 
uses" and also complains about LSM being a big ugly undesigned hack 
lacking abstraction. LSM does have an abstract design: it mediates 
access to major internal kernel objects (processes, inodes, etc.) by 
user-space processes, throwing access requests out to the LSM module. If 
you remove some of these hooks because they don't have a *present* 
module using them, then you break the abstraction.

People tell me that preserving functionality for the sake of abstraction 
is "not the Linux way". Ok, sure, but you degrade the quality of 
abstraction if you aggressively prune the interface.

But it would be much better to short-circuit that debate, and have 
extant modules that use the hooks than to try to defend them on the 
basis of abstraction. So if your sekrit module uses a hook, post here, 
or your hook may go away.

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html
			    Just say ".Nyet"


--------------enigE17B53C43C2991A8E5B296A4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+Sskq5ZkfjX2CNDARAWu4AKCLenQOAu35A5O+IZT206pvopOjhACgo2+K
qRAlRKbIXGtKLhZUVSMAXIA=
=JmpB
-----END PGP SIGNATURE-----

--------------enigE17B53C43C2991A8E5B296A4--

