Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUD3V3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUD3V3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUD3V3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 17:29:07 -0400
Received: from linux.us.dell.com ([143.166.224.162]:31944 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261236AbUD3V26
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 17:28:58 -0400
Date: Fri, 30 Apr 2004 16:28:37 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jens Axboe <axboe@suse.de>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: reduce blk queue and I/O capability printk to KERN_DEBUG?
Message-ID: <20040430212837.GA9853@lists.us.dell.com>
References: <20040430195055.GA7235@lists.us.dell.com> <20040430211342.GA31842@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20040430211342.GA31842@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 30, 2004 at 11:13:43PM +0200, Jens Axboe wrote:
> It should just be deleted. As you note, it is a debug message. I
> originally added it so we would have some clues as to dma capability for
> bug reports. There never was any, the check can go :)

OK, please ack the below for Andrew then.


Remove blk: queue xxxx I/O limit xxxx  messages printed by all block devices

This was a debug message and is no longer needed.

=3D=3D=3D=3D=3D drivers/block/ll_rw_blk.c 1.244 vs edited =3D=3D=3D=3D=3D
--- 1.244/drivers/block/ll_rw_blk.c	Tue Apr 27 08:11:32 2004
+++ edited/drivers/block/ll_rw_blk.c	Fri Apr 30 16:24:03 2004
@@ -280,17 +280,6 @@
 	} else
 		q->bounce_gfp =3D GFP_NOIO;
=20
-	/*
-	 * keep this for debugging for now...
-	 */
-	if (dma_addr !=3D BLK_BOUNCE_HIGH && q !=3D last_q) {
-		printk("blk: queue %p, ", q);
-		if (dma_addr =3D=3D BLK_BOUNCE_ANY)
-			printk("no I/O memory limit\n");
-		else
-			printk("I/O limit %luMb (mask 0x%Lx)\n", mb, (long long) dma_addr);
-	}
-
 	q->bounce_pfn =3D bounce_pfn;
 	last_q =3D q;
 }



--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAksUFIavu95Lw/AkRAtrUAJ9UOe+TG5BuvlgrGks3f7/UhFx71QCfdLTO
kL2p+jWfrl9vSHXx89nmS8M=
=UWXG
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
