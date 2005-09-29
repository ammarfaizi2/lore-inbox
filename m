Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVI2XAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVI2XAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVI2XAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:00:20 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:53385 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S1751331AbVI2XAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:00:18 -0400
Message-ID: <433C71FA.6060608@naurel.org>
Date: Fri, 30 Sep 2005 01:00:10 +0200
From: Aurelien Francillon <aurel@naurel.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050807)
X-Accept-Language: fr, en, en-us
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org>	 <433C60B1.8080003@ens-lyon.fr> <6bffcb0e0509291551161e7eb5@mail.gmail.com>
In-Reply-To: <6bffcb0e0509291551161e7eb5@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigCBF7F7B425BEB244C467364F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCBF7F7B425BEB244C467364F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Michal Piotrowski wrote:
> Hi,
> 
> On 29/09/05, Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
> 
>>Andrew Morton wrote:
>>
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm2/
>>>
>>>(temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc2-mm2.gz)
>>>
>>
>>
>>Hi Andrew,
>>
>>just wanting to report that reiser4 as a module was not compiling
>>anymore. It failed with the following message :
>>
>>In file included from fs/reiser4/lock.h:15,
>>                 from fs/reiser4/context.h:14,
>>                 from fs/reiser4/debug.c:25:
>>fs/reiser4/txnmgr.h: In function `spin_atom_init':
>>fs/reiser4/txnmgr.h:512: error: duplicate case value
>>fs/reiser4/txnmgr.h:512: error: previously used here
>>fs/reiser4/txnmgr.h: In function `spin_txnh_init':
>>fs/reiser4/txnmgr.h:513: error: duplicate case value
>>fs/reiser4/txnmgr.h:513: error: previously used here
>>fs/reiser4/txnmgr.h: In function `spin_txnmgr_init':
>>fs/reiser4/txnmgr.h:514: error: duplicate case value
>>fs/reiser4/txnmgr.h:514: error: previously used here
>>In file included from fs/reiser4/context.h:14,
>>                 from fs/reiser4/debug.c:25:
>>fs/reiser4/lock.h: In function `spin_stack_init':
>>fs/reiser4/lock.h:198: error: duplicate case value
>>fs/reiser4/lock.h:198: error: previously used here
>>In file included from fs/reiser4/znode.h:16,
>>                 from fs/reiser4/tree.h:15,
>>                 from fs/reiser4/super.h:9,
>>                 from fs/reiser4/debug.c:26:
>>fs/reiser4/jnode.h: In function `spin_jnode_init':
>>fs/reiser4/jnode.h:344: error: duplicate case value
>>fs/reiser4/jnode.h:344: error: previously used here
>>fs/reiser4/jnode.h: In function `spin_jload_init':
>>fs/reiser4/jnode.h:348: error: duplicate case value
>>fs/reiser4/jnode.h:348: error: previously used here
>>In file included from fs/reiser4/super.h:9,
>>                 from fs/reiser4/debug.c:26:
>>fs/reiser4/tree.h: In function `spin_epoch_init':
>>fs/reiser4/tree.h:169: error: duplicate case value
>>fs/reiser4/tree.h:169: error: previously used here
>>In file included from fs/reiser4/debug.c:26:
>>fs/reiser4/super.h: In function `spin_super_init':
>>fs/reiser4/super.h:379: error: duplicate case value
>>fs/reiser4/super.h:379: error: previously used here
>>make[2]: *** [fs/reiser4/debug.o] Error 1
>>make[1]: *** [fs/reiser4] Error 2
>>make: *** [fs] Error 2
>>
>>
>>I did not investigate further and simply removed the module.
>>
>>Regards,
>>Alexandre
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 
> I haven't noticed it. I have reiser4 as module
> 
> # CONFIG_JBD_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> CONFIG_REISER4_FS=m
> CONFIG_REISER4_DEBUG=y
> CONFIG_REISERFS_FS=m
> 
> ng02:/usr/src/linux-mm# gcc --version
> gcc (GCC) 3.3.5 (Debian 1:3.3.5-13)
> Copyright (C) 2003 Free Software Foundation, Inc.
> 
> gcc issue?
> 


I guess this is the same issue disscussed on the reiserfs mailing-list :
support for amd64 broken...
http://marc.theaimsgroup.com/?t=112801486300002&r=1&w=2

--------------enigCBF7F7B425BEB244C467364F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDPHH6tsnPPsovZP0RAlyPAJ97cxVMXr3MGAtEWHFtpoqgRI3SAgCfXOvz
525geeCNMt4NqQux1aP57nA=
=xlTs
-----END PGP SIGNATURE-----

--------------enigCBF7F7B425BEB244C467364F--
