Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265238AbUD3TvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUD3TvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265243AbUD3TvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:51:09 -0400
Received: from lists.us.dell.com ([143.166.224.162]:43715 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265238AbUD3TvE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:51:04 -0400
Date: Fri, 30 Apr 2004 14:50:55 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: reduce blk queue and I/O capability printk to KERN_DEBUG?
Message-ID: <20040430195055.GA7235@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jens,

Any reason why this message isn't being printed at KERN_DEBUG or
thereabouts, as the comment immediately before it notes it's for
debugging purposes, and it's only interesting to kernel developers not
end users?

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

=3D=3D=3D=3D=3D drivers/block/ll_rw_blk.c 1.244 vs edited =3D=3D=3D=3D=3D
--- 1.244/drivers/block/ll_rw_blk.c	Tue Apr 27 08:11:32 2004
+++ edited/drivers/block/ll_rw_blk.c	Fri Apr 30 14:46:57 2004
@@ -284,7 +284,7 @@
 	 * keep this for debugging for now...
 	 */
 	if (dma_addr !=3D BLK_BOUNCE_HIGH && q !=3D last_q) {
-		printk("blk: queue %p, ", q);
+		printk(KERN_DEBUG "blk: queue %p, ", q);
 		if (dma_addr =3D=3D BLK_BOUNCE_ANY)
 			printk("no I/O memory limit\n");
 		else

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAkq4fIavu95Lw/AkRAjwEAJ98h966JbPCCS1nk2xl2ewqQggvWgCeM1Zs
FDWXJKTjWQaTZn4SNsOt3h4=
=/aOt
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
