Return-Path: <linux-kernel-owner+w=401wt.eu-S1763011AbWLKSkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763011AbWLKSkf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763013AbWLKSke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:40:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3919 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1763011AbWLKSke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:40:34 -0500
Date: Mon, 11 Dec 2006 19:40:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make sysrq_always_enabled_setup() static
Message-ID: <20061211184043.GA28443@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm2:
>...
> +debug-add-sysrq_always_enabled-boot-option.patch
>...
>  Misc updates
>...

This patch makes the needlessly global sysrq_always_enabled_setup() 
static.
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-mm1/drivers/char/sysrq.c.old	2006-12-11 17:46:54.000000000 +0100
+++ linux-2.6.19-mm1/drivers/char/sysrq.c	2006-12-11 17:47:01.000000000 +0100
@@ -59,7 +59,7 @@
 						(__sysrq_enabled & mask);
 }
 
-int __init sysrq_always_enabled_setup(char *str)
+static int __init sysrq_always_enabled_setup(char *str)
 {
 	sysrq_always_enabled = 1;
 	printk(KERN_INFO "debug: sysrq always enabled.\n");

