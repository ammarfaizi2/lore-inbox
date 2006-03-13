Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWCMV2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWCMV2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbWCMV2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:28:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10511 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751518AbWCMV2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:28:15 -0500
Date: Mon, 13 Mar 2006 22:28:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] dvb/frontends/zl10353.c: make a function static
Message-ID: <20060313212814.GM13973@stusta.de>
References: <20060312031036.3a382581.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 03:10:36AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc5-mm3:
>...
>  git-dvb.patch
>...
>  git trees
>...


This patch makes a needlessly global function static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-full/drivers/media/dvb/frontends/zl10353.c.old	2006-03-13 21:11:08.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/media/dvb/frontends/zl10353.c	2006-03-13 21:11:33.000000000 +0100
@@ -88,7 +88,7 @@
 	return b1[0];
 }
 
-void zl10353_dump_regs(struct dvb_frontend *fe)
+static void zl10353_dump_regs(struct dvb_frontend *fe)
 {
 	struct zl10353_state *state = fe->demodulator_priv;
 	char buf[52], buf2[4];

