Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTFOWFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 18:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262912AbTFOWFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 18:05:33 -0400
Received: from cpt-dial-196-30-180-57.mweb.co.za ([196.30.180.57]:11137 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262903AbTFOWF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 18:05:28 -0400
Subject: Slab corruption/errors in 2.5.71-bk1
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+9z3hP0CZqR+wbYgleoR"
Organization: 
Message-Id: <1055715645.8360.16.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 16 Jun 2003 00:20:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+9z3hP0CZqR+wbYgleoR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hiya

Lot of these in the logs.  I am sure there were others with the same
problem, but that was in rpc_depopulate.  If more info needed, feel free
to ask.

Please just CC me, as subscribed only at work, and will only be back on
Tuesday.

------------------
Slab corruption: start=3De13d0cdc, expend=3De13d0cfb, problemat=3De13d0cdc
Last user: [<c01b7cfa>](copy_semundo+0x94/0xe8)
Data: 02 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 ***************A5=20
Next: A5 C2 0F 17 FA 7C 1B C0 A5 C2 0F 17 00 00 00 00 01 00 00 00 05 00
00 00 01 00 00 00 ****
slab error in check_poison_obj(): cache `size-32': object was modified
after freeing
Call Trace:
 [<c013f4c2>] check_poison_obj+0x14a/0x18a
 [<c0141059>] __kmalloc+0x155/0x188
 [<c017ea1b>] load_elf_binary+0x99b/0xb4a
 [<c017ea1b>] load_elf_binary+0x99b/0xb4a
 [<c0155dd0>] do_sync_read+0x8b/0xb7
 [<c013cc12>] buffered_rmqueue+0xed/0x19b
 [<c013cc12>] buffered_rmqueue+0xed/0x19b
 [<c013cd4b>] __alloc_pages+0x8b/0x2f8
 [<c013cd4b>] __alloc_pages+0x8b/0x2f8
 [<c0160a12>] copy_strings+0x203/0x241
 [<c017e080>] load_elf_binary+0x0/0xb4a
 [<c0161efa>] search_binary_handler+0x192/0x2d9
 [<c01621fc>] do_execve+0x1bb/0x22b
 [<c010928e>] sys_execve+0x42/0x7a
 [<c010aa55>] sysenter_past_esp+0x52/0x71

slab error in cache_alloc_debugcheck_after(): cache `size-32': memory
before object was overwritten
Call Trace:
 [<c0140fef>] __kmalloc+0xeb/0x188
 [<c017ea1b>] load_elf_binary+0x99b/0xb4a
 [<c017ea1b>] load_elf_binary+0x99b/0xb4a
 [<c0155dd0>] do_sync_read+0x8b/0xb7
 [<c013cc12>] buffered_rmqueue+0xed/0x19b
 [<c013cc12>] buffered_rmqueue+0xed/0x19b
 [<c013cd4b>] __alloc_pages+0x8b/0x2f8
 [<c013cd4b>] __alloc_pages+0x8b/0x2f8
 [<c0160a12>] copy_strings+0x203/0x241
 [<c017e080>] load_elf_binary+0x0/0xb4a
 [<c0161efa>] search_binary_handler+0x192/0x2d9
 [<c01621fc>] do_execve+0x1bb/0x22b
 [<c010928e>] sys_execve+0x42/0x7a
 [<c010aa55>] sysenter_past_esp+0x52/0x71

slab error in cache_alloc_debugcheck_after(): cache `size-32': memory
after object was overwritten
Call Trace:
 [<c0141017>] __kmalloc+0x113/0x188
 [<c017ea1b>] load_elf_binary+0x99b/0xb4a
 [<c017ea1b>] load_elf_binary+0x99b/0xb4a
 [<c0155dd0>] do_sync_read+0x8b/0xb7
 [<c013cc12>] buffered_rmqueue+0xed/0x19b
 [<c013cc12>] buffered_rmqueue+0xed/0x19b
 [<c013cd4b>] __alloc_pages+0x8b/0x2f8
 [<c013cd4b>] __alloc_pages+0x8b/0x2f8
 [<c0160a12>] copy_strings+0x203/0x241
 [<c017e080>] load_elf_binary+0x0/0xb4a
 [<c0161efa>] search_binary_handler+0x192/0x2d9
 [<c01621fc>] do_execve+0x1bb/0x22b
 [<c010928e>] sys_execve+0x42/0x7a
 [<c010aa55>] sysenter_past_esp+0x52/0x71


Regards,

--=20

Martin Schlemmer




--=-+9z3hP0CZqR+wbYgleoR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+7PE9qburzKaJYLYRApy2AJsGyhbPLfrOc30SPRh7vik54vk+ggCcCahR
3Zjro7OxBbdRhcx7r4oZKZ4=
=8run
-----END PGP SIGNATURE-----

--=-+9z3hP0CZqR+wbYgleoR--

