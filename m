Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261947AbSJDXHO>; Fri, 4 Oct 2002 19:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261961AbSJDXGq>; Fri, 4 Oct 2002 19:06:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:37761 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261947AbSJDXFr>;
	Fri, 4 Oct 2002 19:05:47 -0400
Message-ID: <3D9E1F0D.3040800@colorfullife.com>
Date: Sat, 05 Oct 2002 01:06:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-05-name
Content-Type: multipart/mixed;
 boundary="------------060906060605070606010907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060906060605070606010907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

part 5:
- remove the space from the name of the DMA caches:
   they make it impossible to tune the caches through
   /proc/slabinfo, and make parsing /proc/slabinfo
   difficult

2.4 doesn't contain the spaces, seems to be a bug from the introduction 
of the 96/192 byte slabs.

--
	Manfred

--------------060906060605070606010907
Content-Type: text/plain;
 name="patch-slab-split-05-name"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-05-name"

--- 2.5/mm/slab.c	Fri Oct  4 21:38:29 2002
+++ build-2.5/mm/slab.c	Sat Oct  5 01:01:20 2002
@@ -351,7 +351,7 @@
 	{     0,	NULL, NULL}
 };
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
-#define CN(x) { x, x " (DMA)" }
+#define CN(x) { x, x "(DMA)" }
 static struct { 
 	char *name; 
 	char *name_dma;

--------------060906060605070606010907--


