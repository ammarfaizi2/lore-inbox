Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265671AbTFNNe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTFNNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 09:34:26 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:58538 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265663AbTFNNeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 09:34:22 -0400
Date: Sat, 14 Jun 2003 15:48:11 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@hera.kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21 zlib merge #2 return
Message-ID: <20030614134811.GE15099@wohnheim.fh-wedel.de>
References: <20030614134708.GD15099@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030614134708.GD15099@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one return code in huft_build.

Jörn

-- 
Those who come seeking peace without a treaty are plotting.
-- Sun Tzu

--- linux-2.4.20/lib/zlib_inflate/inftrees.c~zlib_merge_return	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.20/lib/zlib_inflate/inftrees.c	2003-06-10 17:00:25.000000000 +0200
@@ -228,7 +228,7 @@
 
         /* allocate new table */
         if (*hn + z > MANY)     /* (note: doesn't matter for fixed) */
-          return Z_MEM_ERROR;   /* not enough memory */
+          return Z_DATA_ERROR;  /* overflow of MANY */
         u[h] = q = hp + *hn;
         *hn += z;
 
