Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268545AbSIRV1K>; Wed, 18 Sep 2002 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbSIRV1K>; Wed, 18 Sep 2002 17:27:10 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:51984 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S268545AbSIRV0i>; Wed, 18 Sep 2002 17:26:38 -0400
Date: Wed, 18 Sep 2002 22:31:39 +0100
From: John Levon <levon@movementarian.org>
To: trivial@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] tiny kmem_cache_destroy doc tweak
Message-ID: <20020918213139.GA21178@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make it clear that _destroy() won't do the kmem_cache_free()s for you (it seems).

Against 2.5.36

thanks
john

--- linux-linus/mm/slab.c	Wed Sep 18 19:48:54 2002
+++ linux/mm/slab.c	Wed Sep 18 22:27:32 2002
@@ -1018,6 +1018,8 @@
  * cache being allocated each time a module is loaded and unloaded, if the
  * module doesn't have persistent in-kernel storage across loads and unloads.
  *
+ * The cache must be empty before calling this function.
+ *
  * The caller must guarantee that noone will allocate memory from the cache
  * during the kmem_cache_destroy().
  */
