Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbUJXUqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbUJXUqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbUJXUqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 16:46:03 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:44762 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261632AbUJXUpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 16:45:25 -0400
Subject: 2.6.9-mm1 page allocation failure [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SZWKuTJnmmVhwXppDO71"
Date: Sun, 24 Oct 2004 22:44:58 +0200
Message-Id: <1098650698.12420.20.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SZWKuTJnmmVhwXppDO71
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Getting a few of these (did not happen in 2.6.9-rc4-mm1 as far as I
can remember).

-----
skype.bin: page allocation failure. order:0, mode:0x20
 [<c013c1eb>] __alloc_pages+0x21e/0x3e0
 [<c013c3d2>] __get_free_pages+0x25/0x3f
 [<c013f6dd>] kmem_getpages+0x25/0xd6
 [<c01403ed>] cache_grow+0xab/0x14d
 [<c0140611>] cache_alloc_refill+0x182/0x244
 [<c014099d>] __kmalloc+0x80/0x87
 [<c0295aa5>] alloc_skb+0x47/0xe0
 [<f9a786f8>] e1000_alloc_rx_buffers+0x44/0xe3 [e1000]
 [<f9a783fd>] e1000_clean_rx_irq+0x18a/0x441 [e1000]
 [<c02f2d71>] _spin_unlock+0xd/0x21
 [<c012fc85>] autoremove_wake_function+0x0/0x57
 [<f9a77fb5>] e1000_clean+0x51/0xe7 [e1000]
 [<c029bdbb>] net_rx_action+0x7a/0x117
 [<c0120d61>] __do_softirq+0xad/0xbc
 [<c0120da1>] do_softirq+0x31/0x33
 [<c01363b2>] irq_exit+0x3b/0x3d
 [<c01065ef>] do_IRQ+0x2b/0x38
 [<c0104ad4>] common_interrupt+0x18/0x20
 [<c02f007b>] dump_esp_combs+0x1a/0x1ec
 [<c014e1fe>] get_swap_page+0x102/0x235
 [<c014dc0e>] add_to_swap+0x26/0xb4
 [<c0142fc2>] shrink_list+0x407/0x449
 [<c0141c62>] __pagevec_release+0x28/0x36
 [<c01431a7>] shrink_cache+0x1a3/0x496
 [<c0143a98>] shrink_zone+0xb6/0xd4
 [<c0143b21>] shrink_caches+0x6b/0x6d
 [<c0143beb>] try_to_free_pages+0xc8/0x1af
 [<c013c247>] __alloc_pages+0x27a/0x3e0
 [<c02f2d71>] _spin_unlock+0xd/0x21
 [<c013c3d2>] __get_free_pages+0x25/0x3f
 [<c01687eb>] __pollwait+0x86/0xc7
 [<c02e953f>] unix_poll+0x2b/0xa2
 [<c0292721>] sock_poll+0x29/0x31
 [<c0168b73>] do_select+0x268/0x2c2
 [<c0168765>] __pollwait+0x0/0xc7
 [<c0168ea5>] sys_select+0x2b3/0x4c6
 [<c01040a5>] sysenter_past_esp+0x52/0x71
-----


Thanks,
--=20
Martin Schlemmer


--=-SZWKuTJnmmVhwXppDO71
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBfBRKqburzKaJYLYRAnzHAJwMGgFyQp+Xjt+D6cmmNY639XWJRQCgjG07
NCO1XqM67MZcsVAEDxzM5yk=
=faOc
-----END PGP SIGNATURE-----

--=-SZWKuTJnmmVhwXppDO71--

