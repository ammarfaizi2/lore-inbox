Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbULOJXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbULOJXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbULOJVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:21:06 -0500
Received: from sd291.sivit.org ([194.146.225.122]:12173 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262306AbULOJSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:18:42 -0500
Date: Wed, 15 Dec 2004 10:19:36 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] correct dma_set_mask return code in DMA-API.txt
Message-ID: <20041215091935.GB3863@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says dma_set_api() returns 1 on success and 
0 on error, which is plain wrong, standard kernel return codes
are used instead (0 on ok, -ESOMETHING on error).

Trivial patch attached, please apply.

Stelian.

===== Documentation/DMA-API.txt 1.9 vs edited =====
--- 1.9/Documentation/DMA-API.txt	2004-07-01 04:01:43 +02:00
+++ edited/Documentation/DMA-API.txt	2004-12-15 10:01:27 +01:00
@@ -160,7 +160,7 @@
 Checks to see if the mask is possible and updates the device
 parameters if it is.
 
-Returns: 1 if successful and 0 if not
+Returns: 0 if successful and a negative error if not.
 
 u64
 dma_get_required_mask(struct device *dev)
-- 
Stelian Pop <stelian@popies.net>    
