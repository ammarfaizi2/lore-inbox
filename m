Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUGCQcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUGCQcm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 12:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUGCQcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 12:32:42 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:33032 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S265147AbUGCQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 12:32:40 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [prefetch.h] warning: pointer of type `void *' used in arithmetic'
Date: Sat, 3 Jul 2004 18:32:34 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_i+t5AhXPbvgEFPq"
Message-Id: <200407031832.34780.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_i+t5AhXPbvgEFPq
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

warning killed.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_i+t5AhXPbvgEFPq
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="prefetch.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prefetch.h.diff"

--- /var/tmp/linux/include/linux/prefetch.h.orig	2004-06-16 07:20:25.000000000 +0200
+++ /var/tmp/linux/include/linux/prefetch.h	2004-07-03 18:28:10.478861720 +0200
@@ -59,7 +59,7 @@
 {
 #ifdef ARCH_HAS_PREFETCH
 	char *cp;
-	char *end = addr + len;
+	char *end = (char *)addr + len;
 
 	for (cp = addr; cp < end; cp += PREFETCH_STRIDE)
 		prefetch(cp);

--Boundary-00=_i+t5AhXPbvgEFPq--
