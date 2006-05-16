Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWEPLsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWEPLsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 07:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWEPLsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 07:48:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:8723 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751801AbWEPLsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 07:48:31 -0400
Date: Tue, 16 May 2006 13:48:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make dvb/b2c2/flexcop-fe-tuner.c:alps_tdee4_stv0297_tuner_set_params() static
Message-ID: <20060516114829.GO6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
>  git-dvb.patch
>...
>  git trees
>...

This patch makes the needlessly global 
alps_tdee4_stv0297_tuner_set_params() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc4-mm1-full/drivers/media/dvb/b2c2/flexcop-fe-tuner.c.old	2006-05-16 12:50:54.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/media/dvb/b2c2/flexcop-fe-tuner.c	2006-05-16 12:51:08.000000000 +0200
@@ -354,7 +354,8 @@
 	.demod_address = 0x0e,
 };
 
-int alps_tdee4_stv0297_tuner_set_params (struct dvb_frontend* fe, struct dvb_frontend_parameters *fep)
+static int alps_tdee4_stv0297_tuner_set_params(struct dvb_frontend* fe,
+					       struct dvb_frontend_parameters *fep)
 {
 	struct flexcop_device *fc = fe->dvb->priv;
 	u8 buf[4];
