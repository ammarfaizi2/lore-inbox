Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVFZQJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVFZQJN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVFZQIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 12:08:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15886 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261347AbVFZQFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 12:05:54 -0400
Date: Sun, 26 Jun 2005 18:05:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Luca Falavigna <dktrkranz@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [-mm patch] kernel/irq/autoprobe.c: remove an unused variable
Message-ID: <20050626160552.GK3629@stusta.de>
References: <20050626040329.3849cf68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050626040329.3849cf68.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2005 at 04:03:29AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.12-mm1:
>...
> +using-msleep-instead-of-hz.patch
>...
>  cleanup
>...

This patch causes the following warning:

<--  snip  -->

...
  CC      kernel/irq/autoprobe.o
kernel/irq/autoprobe.c: In function `probe_irq_on':
kernel/irq/autoprobe.c:30: warning: unused variable `delay'
...

<--  snip  -->


This patch removes this no longer used variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/kernel/irq/autoprobe.c.old	2005-06-26 14:46:35.000000000 +0200
+++ linux-2.6.12-mm2-full/kernel/irq/autoprobe.c	2005-06-26 14:46:46.000000000 +0200
@@ -27,7 +27,7 @@
  */
 unsigned long probe_irq_on(void)
 {
-	unsigned long val, delay;
+	unsigned long val;
 	irq_desc_t *desc;
 	unsigned int i;
 
