Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWCMV0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWCMV0F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbWCMV0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:26:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7183 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751211AbWCMV0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:26:03 -0500
Date: Mon, 13 Mar 2006 22:26:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com
Subject: [-mm patch] make drivers/net/tg3.c:tg3_request_irq()
Message-ID: <20060313212602.GL13973@stusta.de>
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
>  git-net.patch
>...
>  git trees
>...


This patch makes the needlessly global function tg3_request_irq() 
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-full/drivers/net/tg3.c.old	2006-03-13 21:13:31.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/net/tg3.c	2006-03-13 21:14:26.000000000 +0100
@@ -6531,7 +6531,7 @@
 	add_timer(&tp->timer);
 }
 
-int tg3_request_irq(struct tg3 *tp)
+static int tg3_request_irq(struct tg3 *tp)
 {
 	irqreturn_t (*fn)(int, void *, struct pt_regs *);
 	unsigned long flags;

