Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWHZP2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWHZP2t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 11:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHZP2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 11:28:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48390 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932085AbWHZP2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 11:28:49 -0400
Date: Sat, 26 Aug 2006 17:28:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [-mm patch] drivers/net/pcmcia/xirc2ps_cs.c: remove unused label
Message-ID: <20060826152847.GF4765@stusta.de>
References: <20060819220008.843d2f64.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060819220008.843d2f64.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 10:00:08PM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc4-mm1:
>...
>  git-pcmcia.patch
>...
>  git trees
>...

This patch fixes the following warning due to a no longer used label:

<--  snip  -->

...
  CC      drivers/net/pcmcia/xirc2ps_cs.o
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm2/drivers/net/pcmcia/xirc2ps_cs.c: In function ‘xirc2ps_config’:
/home/bunk/linux/kernel-2.6/linux-2.6.18-rc4-mm2/drivers/net/pcmcia/xirc2ps_cs.c:1044: warning: label ‘cis_error’ defined but not used
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/drivers/net/pcmcia/xirc2ps_cs.c.old	2006-08-26 17:18:36.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/net/pcmcia/xirc2ps_cs.c	2006-08-26 17:18:40.000000000 +0200
@@ -1041,8 +1041,6 @@ xirc2ps_config(struct pcmcia_device * li
     xirc2ps_release(link);
     return -ENODEV;
 
-  cis_error:
-    printk(KNOT_XIRC "unable to parse CIS\n");
   failure:
     return -ENODEV;
 } /* xirc2ps_config */

