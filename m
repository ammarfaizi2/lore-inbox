Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTBTCxM>; Wed, 19 Feb 2003 21:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTBTCxM>; Wed, 19 Feb 2003 21:53:12 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32424 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S264729AbTBTCxL>;
	Wed, 19 Feb 2003 21:53:11 -0500
Date: Thu, 20 Feb 2003 03:03:08 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, <alan@redhat.com>
Subject: [patch] i810 for loop replaced with udelay
Message-ID: <Pine.LNX.4.44.0302200254350.2961-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial patch pulled from the DRI tree against 2.4.20, please apply ..

Dave.


--- kernel-2.4-orig/drivers/char/drm/i810_dma.c	2003-02-20 14:04:22.000000000 +1100
+++ kernel-2.4/drivers/char/drm/i810_dma.c	2003-02-20 14:04:53.000000000 +1100
@@ -317,7 +317,7 @@
 		   	goto out_wait_ring;
 		}

-	   	for (i = 0 ; i < 2000 ; i++) ;
+	   	udelay(1);
 	}

 out_wait_ring:


