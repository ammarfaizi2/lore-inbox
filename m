Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUI1MV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUI1MV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUI1MV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:21:26 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:16900 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S267186AbUI1MVY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:21:24 -0400
Date: Tue, 28 Sep 2004 14:21:17 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: James Morris <jmorris@redhat.com>
Cc: Michal Ludvig <michal@logix.cz>, Andreas Happe <crow@old-fsckful.ath.cx>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc2 1/2] cryptoapi: update sysfs-patch
Message-ID: <20040928122117.GA21010@final-judgement.ath.cx>
References: <20040927084149.GA3625@final-judgement.ath.cx> <Xine.LNX.4.44.0409271151500.21876-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0409271151500.21876-100000@thoron.boston.redhat.com>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Just removes the cra_list entry from the whirlpool - cipher.

please apply after the old patch.

Signed-off-by: Andreas Happe <andreashappe@snikt.net>

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.9-rc2-update_cryptoapi_class"

diff -u -r -N linux-2.6.8/crypto/whirlpool.c linux-sysfs/crypto/whirlpool.c
--- linux-2.6.8/crypto/whirlpool.c	2004-09-28 12:50:31.000000000 +0200
+++ linux-sysfs/crypto/whirlpool.c	2004-09-28 12:24:23.000000000 +0200
@@ -1106,7 +1106,6 @@
 	.cra_blocksize	=	WHIRLPOOL_BLOCK_SIZE,
 	.cra_ctxsize	=	sizeof(struct whirlpool_ctx),
 	.cra_module	=	THIS_MODULE,
-	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),	
 	.cra_u		=	{ .digest = {
 	.dia_digestsize	=	WHIRLPOOL_DIGEST_SIZE,
 	.dia_init   	= 	whirlpool_init,

--a8Wt8u1KmwUX3Y2C--
