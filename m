Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbUBXDKv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 22:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbUBXDKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 22:10:51 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:49117 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262150AbUBXDKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 22:10:49 -0500
Date: Mon, 23 Feb 2004 22:09:34 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 3c359_microcode.h clean up - 2.6.3
Message-ID: <20040224030933.GA7116@siasl.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mike Phillips <phillim2@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small patch to clean up 3c359_micrcode.h, no other drivers in the kernel
come anywhere near the file and the #if is superflous.

Mike Phillips 

diff -urN -X dontdiff linux-2.6.3/drivers/net/tokenring/3c359_microcode.h linux-2.6.3-working/drivers/net/tokenring/3c359_microcode.h
--- linux-2.6.3/drivers/net/tokenring/3c359_microcode.h	2004-02-17 22:57:20.000000000 -0500
+++ linux-2.6.3-working/drivers/net/tokenring/3c359_microcode.h	2004-02-23 21:57:58.000000000 -0500
@@ -20,9 +20,6 @@
  * different length.
  */
 
-
-#if defined(CONFIG_3C359) || defined(CONFIG_3C359_MODULE) 
-
 static int mc_size = 24880 ; 
 
 u8 microcode[] = { 
@@ -1582,4 +1579,3 @@
 ,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
 ,0x90,0xea,0xc0,0x15,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x13,0x06
 } ;  
-#endif 
