Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270239AbUJTF4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270239AbUJTF4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270193AbUJTFvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 01:51:19 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:16336 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S266611AbUJTFrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 01:47:45 -0400
Date: Wed, 20 Oct 2004 15:47:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       ppc64-dev <linuxppc64-dev@lists.linuxppc.org>
Subject: [PATCH] PPC64 iSeries compile broken in 2.6.9-bk3
Message-Id: <20041020154730.39ea3509.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__20_Oct_2004_15_47_30_+1000_g/u2TnTfCl.q_nEc"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__20_Oct_2004_15_47_30_+1000_g/u2TnTfCl.q_nEc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

One of the iSeries specific files used HZ without including linux/param.h
and previously got away with it.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Please apply and send to Linus.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.9-bk3/arch/ppc64/kernel/iSeries_proc.c 2.6.9-bk3-sfr.1/arch/ppc64/kernel/iSeries_proc.c
--- 2.6.9-bk3/arch/ppc64/kernel/iSeries_proc.c	2004-08-19 17:01:59.000000000 +1000
+++ 2.6.9-bk3-sfr.1/arch/ppc64/kernel/iSeries_proc.c	2004-10-20 15:21:23.000000000 +1000
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/param.h>		/* for HZ */
 #include <asm/paca.h>
 #include <asm/processor.h>
 #include <asm/time.h>

--Signature=_Wed__20_Oct_2004_15_47_30_+1000_g/u2TnTfCl.q_nEc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdfv44CJfqux9a+8RArlNAJ9H+yh17AnGkLVfH+L/aJnnFJ761wCfTwKe
obvvBI+qM6jYRg3rXU4R78E=
=Q+VC
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Oct_2004_15_47_30_+1000_g/u2TnTfCl.q_nEc--
