Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUIGMyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUIGMyS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUIGMyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:54:18 -0400
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:46521 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267998AbUIGMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:54:15 -0400
Message-ID: <413DAF3F.8080909@kolivas.org>
Date: Tue, 07 Sep 2004 22:53:19 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: attribute warn_unused_result
References: <413DA83A.7010704@kolivas.org> <1094560688.2801.11.camel@laptop.fenrus.com> <413DAD07.3030306@kolivas.org> <20040907124726.GF8237@devserv.devel.redhat.com>
In-Reply-To: <20040907124726.GF8237@devserv.devel.redhat.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig84F7AEB89D98FBB50FA209FC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84F7AEB89D98FBB50FA209FC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:
> On Tue, Sep 07, 2004 at 10:43:51PM +1000, Con Kolivas wrote:
> 
>>Arjan van de Ven wrote:
>>
>>>On Tue, 2004-09-07 at 14:23, Con Kolivas wrote:
>>>
>>>
>>>>Gcc3.4.1 has recently been complaining of a number of unused results 
>>>
>>>>from function with attribute warn_unused_result set. I'm not sure of how 
>>>
>>>>you want to tackle this so I'm avoiding posting patches. Should we 
>>>>remove the attribute (seems the likely option) or set some dummy 
>>>>variable (sounds stupid now that I ask it).
>>>
>>>
>>>that attribute is supposed to only be set for functions you really ought
>>>to check the result for.... so how about checking/using the result ?
>>
>>I understand the concept... these are functions that seem to work fine 
>>without using the return value... unless of course the original coders 
>>aren't yet aware of that fact then I'm sorry. Here's the list just with 
>>my config on 2.6.9-rc1-bk13:
> 
> 
>>fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', 
>>declared with attribute warn_unused_result
> 
> 
> you really are supposed to use the return value of copy_to_user and friends.

Oh dear I hadn't looked at that. My tree must have been corrupted by 
reiser4 doing the in-out thing to me ;P. Excuse the noise.

Con

--------------enig84F7AEB89D98FBB50FA209FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBPa9BZUg7+tp6mRURAkJDAJsEFdDNt+nsuvg6uZ6cS6lpTxiDfACfbbJ7
Vf6hFoYApKiYawTeWkvr9rk=
=8cWO
-----END PGP SIGNATURE-----

--------------enig84F7AEB89D98FBB50FA209FC--
