Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUJWMCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUJWMCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUJWMCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:02:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:23207 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267374AbUJWMCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:02:15 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-mm1
Date: Sat, 23 Oct 2004 14:06:27 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org>
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1489113.QWPKAu1MWV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200410231406.31265.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1489113.QWPKAu1MWV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 22 October 2004 12:20, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-m
>m1/

I got this page allocation failure:

lisa: page allocation failure. order:0, mode:0x20
 [<c01371d2>] __alloc_pages+0x380/0x3a1
 [<c013720b>] __get_free_pages+0x18/0x31
 [<c013a2a3>] kmem_getpages+0x19/0xab
 [<c013ae98>] cache_grow+0xb4/0x182
 [<c013b16c>] cache_alloc_refill+0x206/0x235
 [<c013b39e>] kmem_cache_alloc+0x3b/0x3d
 [<c027815f>] dst_alloc+0x31/0x9f
 [<c02851a0>] ip_route_output_slow+0x2a4/0x808
 [<c02857d7>] ip_route_output_flow+0x22/0x8a
 [<c02a6aa8>] raw_sendmsg+0x27f/0x4fe
 [<c02af6bd>] inet_sendmsg+0x4a/0x62
 [<c026bd99>] sock_sendmsg+0xc9/0xeb
 [<c01150de>] recalc_task_prio+0xbb/0x1a8
 [<c02cfa7a>] schedule+0x27e/0x548
 [<c01314d4>] irq_exit+0x35/0x37
 [<c01060da>] do_IRQ+0x4e/0x6a
 [<c012b680>] autoremove_wake_function+0x0/0x43
 [<c01cdb42>] copy_from_user+0x34/0x62
 [<c026d196>] sys_sendto+0xdf/0x112
 [<c015fbf9>] __pollwait+0x0/0xc0
 [<c01cda46>] __copy_to_user_ll+0x3e/0x61
 [<c01150de>] recalc_task_prio+0xbb/0x1a8
 [<c026da72>] sys_socketcall+0x194/0x246
 [<c0103ee3>] syscall_call+0x7/0xb

don't know when it exactly happens, just saw it in the dmesg output right now.

best regards,
dominik

--nextPart1489113.QWPKAu1MWV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQCVAwUAQXpJRwvcoSHvsHMnAQJCIAP/QgkJm0RPRt0P4W/ia6zvaPFpIjhaxNJq
fs1n1dKNZ8X4xCqjh++AZJnfp2oy99VamBh5GfzH5YbLxeT65pmfCemi5N+7H8Tb
3ZP8ym57ZeTpxSbtBplttVEztqX6GcMPxyV18q3ms5W4jB/sKhtQJ2/OSP1k6nvI
4uFBRinxqpU=
=XAYF
-----END PGP SIGNATURE-----

--nextPart1489113.QWPKAu1MWV--
