Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbTLOUJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTLOUJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:09:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:15500 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263927AbTLOUJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:09:39 -0500
X-Authenticated: #21388368
Subject: Nvidia kernel module and kernel 2.6
From: Lukas Postupa <postupa@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6X/HtdxKWrHdlSSvusU5"
Message-Id: <1071519127.770.12.camel@linux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 21:12:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6X/HtdxKWrHdlSSvusU5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,

i'm using linux 2.6.0-test11-bk11 on Intel architecture (Celeron
Coppermine) and nvidia kernel module 1.0-4620 for Nvidia GF FX 5200.
Mttr registers are enabled.
I applied appropriate patches from www.minion.de.
After loading and using nvidia kernel module, dmesg shows this output:

nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4620=20
Mon Sep 29 08:49:59 PDT 2003
Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c0118c0c>] __might_sleep+0xac/0xe0
 [<c013bba7>] kmem_cache_alloc+0x67/0x70
 [<c0149521>] __get_vm_area+0x21/0x100
 [<c0149633>] get_vm_area+0x33/0x40
 [<c0115e52>] __ioremap+0xc2/0x120
 [<c0115ed9>] ioremap_nocache+0x29/0xb0
 [<d5c00cec>] os_map_kernel_space+0x4c/0x80 [nvidia]
 [<d5ac9e37>] __nvsym00566+0x1f/0x2c [nvidia]
 [<d5acbf56>] __nvsym00753+0x6e/0xe0 [nvidia]
 [<d5acbfe6>] __nvsym00759+0x1e/0x190 [nvidia]
 [<d5acdc3c>] rm_init_adapter+0xc/0x10 [nvidia]
 [<d5bfd637>] nv_kern_open+0x127/0x240 [nvidia]
 [<c01586b4>] chrdev_open+0xf4/0x220
 [<c014e22b>] dentry_open+0x14b/0x220
 [<c014e0d6>] filp_open+0x66/0x70
 [<c014e585>] sys_open+0x55/0x90
 [<c0109659>] sysenter_past_esp+0x52/0x71

Debug: sleeping function called from invalid context at mm/slab.c:1856
in_atomic():1, irqs_disabled():0
Call Trace:
118c0c>] __might_sleep+0xac/0xe0
 [<c013bc39>] __kmalloc+0x89/0x90
 [<d5c003fc>] os_alloc_mem+0x7c/0xa0 [nvidia]
 [<d5ac9f54>] __nvsym00082+0x10/0x24 [nvidia]
 [<d5ba4828>] __nvsym04313+0x10/0x14 [nvidia]
 [<d5b45f32>] __nvsym03556+0x4a/0x1f0 [nvidia]
 [<d5af08dc>] __nvsym01940+0x46c/0xf20 [nvidia]
 [<c01373c0>] mempool_free+0x50/0xb0
 [<c01373c0>] mempool_free+0x50/0xb0
 [<d5be8232>] __nvsym03624+0x106/0x110 [nvidia]
 [<d5b4b2ec>] __nvsym03626+0x0/0x54 [nvidia]
 [<d5b4b2ec>] __nvsym03626+0x0/0x54 [nvidia]
 [<d5af3cd7>] __nvsym02598+0x4f/0x6c [nvidia]
 [<d5aff937>] __nvsym02635+0x277/0x2b4 [nvidia]
 [<d5acf345>] __nvsym00842+0x6d/0xa0 [nvidia]
 [<d5be30a7>] __nvsym00758+0x77/0x224 [nvidia]
 [<d5acbb9c>] __nvsym00751+0x1c/0x5c [nvidia]
 [<d5acc0e3>] __nvsym00759+0x11b/0x190 [nvidia]
 [<d5acdc3c>] rm_init_adapter+0xc/0x10 [nvidia]
 [<d5bfd637>] nv_kern_open+0x127/0x240 [nvidia]
 [<c01586b4>] chrdev_open+0xf4/0x220
 [<c014e22b>] dentry_open+0x14b/0x220
 [<c014e0d6>] filp_open+0x66/0x70
 [<c014e585>] sys_open+0x55/0x90
 [<c0109659>] sysenter_past_esp+0x52/0x71

agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode

This always is happening on loading this module.
I get same trouble with nvidia kernel module 1.0-4496.
I never had such problems with kernel 2.4 before.

Any suggestions?

With best regards,
Lukas

--=-6X/HtdxKWrHdlSSvusU5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/3hWV7NqD+yPvj1cRAqw2AJ4qJcjg7iJ/5Z3Y05oVxp+EoBxpjwCfUsui
Rnhyj3pX3XZ+oto+zFjkuxI=
=bv/Q
-----END PGP SIGNATURE-----

--=-6X/HtdxKWrHdlSSvusU5--

