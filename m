Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUHXODM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUHXODM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHXODM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 10:03:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:32900 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267841AbUHXODI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 10:03:08 -0400
Message-Id: <200408241402.i7OE2nJC001362@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: lethal@linux-sh.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.9-rc1 - #ifdef cleanup for sh64
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1029391272P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 24 Aug 2004 10:02:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1029391272P
Content-Type: text/plain; charset=us-ascii

Another small cleanup patch for #if/#ifdef usage.

Signed-off-by: valdis.kletnieks@vt.edu

--- linux-2.6.9-rc1/arch/sh64/kernel/process.c.ifdef	2004-08-14 01:38:11.000000000 -0400
+++ linux-2.6.9-rc1/arch/sh64/kernel/process.c	2004-08-24 09:58:01.407004057 -0400
@@ -901,7 +901,7 @@ unsigned long get_wchan(struct task_stru
 	 */
 	pc = thread_saved_pc(p);
 
-#if CONFIG_FRAME_POINTER
+#ifdef CONFIG_FRAME_POINTER
 	if (in_sh64_switch_to(pc)) {
 		sh64_switch_to_fp = (long) p->thread.sp;
 		/* r14 is saved at offset 4 in the sh64_switch_to frame */




--==_Exmh_-1029391272P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBK0qIcC3lWbTT17ARAmTfAKCX3WlcbV7ZSSlcwpfVwmM2vwyNpgCg874T
r8Uh9/7T2xfi8v/C/bLi2cI=
=luzr
-----END PGP SIGNATURE-----

--==_Exmh_-1029391272P--
