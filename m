Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267986AbUIGMoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267986AbUIGMoh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUIGMoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:44:37 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:57064 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267986AbUIGMoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:44:32 -0400
Message-ID: <413DAD07.3030306@kolivas.org>
Date: Tue, 07 Sep 2004 22:43:51 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: attribute warn_unused_result
References: <413DA83A.7010704@kolivas.org> <1094560688.2801.11.camel@laptop.fenrus.com>
In-Reply-To: <1094560688.2801.11.camel@laptop.fenrus.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6678B9787AF7B5AE20908F90"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6678B9787AF7B5AE20908F90
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Arjan van de Ven wrote:
> On Tue, 2004-09-07 at 14:23, Con Kolivas wrote:
> 
>>Gcc3.4.1 has recently been complaining of a number of unused results 
>>from function with attribute warn_unused_result set. I'm not sure of how 
>>you want to tackle this so I'm avoiding posting patches. Should we 
>>remove the attribute (seems the likely option) or set some dummy 
>>variable (sounds stupid now that I ask it).
> 
> 
> that attribute is supposed to only be set for functions you really ought
> to check the result for.... so how about checking/using the result ?

I understand the concept... these are functions that seem to work fine 
without using the return value... unless of course the original coders 
aren't yet aware of that fact then I'm sorry. Here's the list just with 
my config on 2.6.9-rc1-bk13:

sound/core/seq/seq_clientmgr.c: In function `snd_seq_read':
sound/core/seq/seq_clientmgr.c:423: warning: ignoring return value of 
`copy_to_user', declared with attribute warn_unused_result

fs/binfmt_elf.c: In function `padzero':
fs/binfmt_elf.c:113: warning: ignoring return value of `clear_user', 
declared with attribute warn_unused_result
include/asm/uaccess.h: In function `create_elf_tables':
fs/binfmt_elf.c:175: warning: ignoring return value of `__copy_to_user', 
declared with attribute warn_unused_result
fs/binfmt_elf.c:273: warning: ignoring return value of `copy_to_user', 
declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `load_elf_binary':
fs/binfmt_elf.c:750: warning: ignoring return value of `clear_user', 
declared with attribute warn_unused_result
fs/binfmt_elf.c: In function `fill_psinfo':
fs/binfmt_elf.c:1216: warning: ignoring return value of 
`copy_from_user', declared with attribute warn_unused_result

net/ipv6/ip6_flowlabel.c: In function `ipv6_flowlabel_opt':
net/ipv6/ip6_flowlabel.c:541: warning: ignoring return value of 
`copy_to_user', declared with attribute warn_unused_result

net/ipv4/netfilter/ip_tables.c: In function `do_replace':
net/ipv4/netfilter/ip_tables.c:1133: warning: ignoring return value of 
`copy_to_user', declared with attribute warn_unused_result

net/ipv4/netfilter/arp_tables.c: In function `do_replace':
net/ipv4/netfilter/arp_tables.c:952: warning: ignoring return value of 
`copy_to_user', declared with attribute warn_unused_result


Con

--------------enig6678B9787AF7B5AE20908F90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBPa0KZUg7+tp6mRURArdyAJ9o1p3SIf11rU57jmqI6PIinfj0UgCfRDxH
lnEmuqcW5PEiLmxxH2f1DRA=
=yEgI
-----END PGP SIGNATURE-----

--------------enig6678B9787AF7B5AE20908F90--
