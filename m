Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTFVASM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 20:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTFVASM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 20:18:12 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.5.17]:17260 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264890AbTFVASK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 20:18:10 -0400
Date: Sat, 21 Jun 2003 20:31:44 -0400
From: Jeff <jeffpc@optonline.net>
Subject: Re: kswapd 2.4.2? ext3
In-reply-to: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
To: john@beyondhelp.co.nz, linux-kernel@vger.kernel.org
Message-id: <200306212032.09382.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Tlv/OF6GZeJ7m2URZKRuYQ)"
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_Tlv/OF6GZeJ7m2URZKRuYQ)
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Same, here. 2.4.20-xfs and 2.4.21 (vanilla) both have some problem in kswapd. 
This happened after about 4 days and 6 hours of uptime/load. I use this box 
as a router with DHCP, DNS, NTP and SSH (for administration only.)

P100, 10GB HDD (ext3), 32MB RAM

I noticed the two oopses in syslog - see attachment.

Jeff.

- -- 
Penguin : Linux version 2.5.71 on an i686 machine (3932.16 BogoMips).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9PkDwFP0+seVj/4RAo42AKC+VN9A8dEslFeFP1HsAMA9wDH/7ACdHxU0
0spiWwszGGrplAgmebO5St4=
=OsE0
-----END PGP SIGNATURE-----

--Boundary_(ID_Tlv/OF6GZeJ7m2URZKRuYQ)
Content-type: text/plain; charset=iso-8859-1; name=oops-2.4.21
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=oops-2.4.21

Jun 21 06:25:19:
----------------

Unable to handle kernel NULL pointer dereference at virtual address 00000028
 printing eip:
c01355d4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[cdput+4/64]    Not tainted
EFLAGS: 00010202
eax: 00000020   ebx: c0e43be0   ecx: 00000020   edx: c0e43bf8
esi: c10f3f5c   edi: c05dd408   ebp: c10f3f64   esp: c10f3f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c10f3000)
Stack: c01419c1 00000020 c0e43be0 c0141a24 c0e43be0 c1588e08 c1588e00 c0141c72
       c10f3f5c 00000013 000001d0 00000020 0000035b c0e43a08 c1276468 00000006
       c0141caf 00000000 c012a429 00000006 000001d0 00000006 000001d0 00000006
Call Trace:    [clear_inode+185/212] [dispose_list+72/96] [prune_icache+190/224] [
shrink_icache_memory+27/48] [shrink_caches+109/132]
  [try_to_free_pages_zone+50/80] [kswapd_balance_pgdat+69/144] [kswapd_balance+22/
44] [kswapd+153/188] [arch_kernel_thread+40/56]

Code: ff 49 08 0f 94 c0 84 c0 74 26 8b 51 04 8b 01 89 50 04 89 02


Jun 21 06:25:22:
----------------

<1>Unable to handle kernel NULL pointer dereference at virtual address 00000028
 printing eip:
c01355d4
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[cdput+4/64]    Not tainted
EFLAGS: 00010202
eax: 00000020   ebx: c0eb3be0   ecx: 00000020   edx: c0eb3bf8
esi: c0b69dbc   edi: c1a79288   ebp: c0b69dc4   esp: c0b69d88
ds: 0018   es: 0018   ss: 0018
Process find (pid: 571, stackpage=c0b69000)
Stack: c01419c1 00000020 c0eb3be0 c0141a24 c0eb3be0 c1a790a8 c1a790a0 c0141c72
       c0b69dbc 00000018 000001f0 00000020 00000439 c0eb3a08 c0ee0688 00000006
       c0141caf 00000000 c012a429 00000006 000001f0 00000006 000001f0 00000006
Call Trace:    [clear_inode+185/212] [dispose_list+72/96] [prune_icache+190/224] [
shrink_icache_memory+27/48] [shrink_caches+109/132]
  [try_to_free_pages_zone+50/80] [balance_classzone+80/496] [__alloc_pages+251/340
] [_alloc_pages+22/24] [__get_free_pages+11/88] [kmem_cache_grow+154/488]
  [kmem_cache_alloc+199/220] [alloc_inode+48/296] [get_new_inode+18/316] [iget4+20
2/220] [ext3_lookup+83/128] [real_lookup+83/196]
  [link_path_walk+1487/2132] [path_walk+26/28] [path_lookup+27/36] [__user_walk+38
/64] [sys_lstat64+25/112] [system_call+51/64]

Code: ff 49 08 0f 94 c0 84 c0 74 26 8b 51 04 8b 01 89 50 04 89 02

--Boundary_(ID_Tlv/OF6GZeJ7m2URZKRuYQ)--
