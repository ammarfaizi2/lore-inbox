Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbVCXDe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVCXDe0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbVCXDdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:33:16 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54289 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263007AbVCXDKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:10:31 -0500
Date: Thu, 24 Mar 2005 04:10:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Tina Yang <tinay@chelsio.com>,
       Scott Bardone <sbardone@chelsio.com>,
       Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [-mm patch] drivers/net/chelsio/osdep.h: small cleanups
Message-ID: <20050324031026.GV1948@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321025159.1cabd62e.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The #define MODVERSIONS doesn't make sense.

And there's no need to #ifdef an #include <linux/module.h>.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/net/chelsio/osdep.h.old	2005-03-24 01:20:02.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/net/chelsio/osdep.h	2005-03-24 01:20:17.000000000 +0100
@@ -33,13 +33,7 @@
 #define __CHELSIO_OSDEP_H
 
 #include <linux/version.h>
-#if defined(MODULE) && ! defined(MODVERSIONS)
-#define MODVERSIONS
-#endif
-#ifdef MODULE
 #include <linux/module.h>
-#endif
-
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/delay.h>

