Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267501AbUHDXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267501AbUHDXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267502AbUHDXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:16:28 -0400
Received: from ozlabs.org ([203.10.76.45]:20633 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267501AbUHDXQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:16:23 -0400
Date: Thu, 5 Aug 2004 09:11:35 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix gcc 3.5 compile issue in mm/mempolicy.c
Message-ID: <20040804231135.GX30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix another gcc 3.5 compile issue, this time the default_policy prototype
was not marked static whereas the definition was. There is no need for
the prototype, so remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN include/linux/mempolicy.h~more-3.5-fixes include/linux/mempolicy.h
--- linux-2.6.8-rc2-mm2/include/linux/mempolicy.h~more-3.5-fixes	2004-08-04 17:46:37.671867293 -0500
+++ linux-2.6.8-rc2-mm2-anton/include/linux/mempolicy.h	2004-08-04 17:46:37.681865704 -0500
@@ -68,9 +68,6 @@ struct mempolicy {
 	} v;
 };
 
-/* An NULL mempolicy pointer is a synonym of &default_policy. */
-extern struct mempolicy default_policy;
-
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.

_
