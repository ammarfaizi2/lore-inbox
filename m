Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263816AbTCUUrD>; Fri, 21 Mar 2003 15:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263812AbTCUSxo>; Fri, 21 Mar 2003 13:53:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31620
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263815AbTCUSxE>; Fri, 21 Mar 2003 13:53:04 -0500
Date: Fri, 21 Mar 2003 20:08:19 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212008.h2LK8Jgj026272@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix ";" in cs46xx
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/sound/oss/cs46xx.c linux-2.5.65-ac2/sound/oss/cs46xx.c
--- linux-2.5.65/sound/oss/cs46xx.c	2003-03-06 17:04:39.000000000 +0000
+++ linux-2.5.65-ac2/sound/oss/cs46xx.c	2003-03-06 22:01:50.000000000 +0000
@@ -4314,7 +4314,7 @@
     {
         offset = ClrStat[i].BA1__DestByteOffset;
         count  = ClrStat[i].BA1__SourceSize;
-        for(  temp1 = offset; temp1<(offset+count); temp1+=4 );
+        for(  temp1 = offset; temp1<(offset+count); temp1+=4 )
               writel(0, pBA1+temp1);
     }
 
