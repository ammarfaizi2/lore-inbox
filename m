Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUH2PZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUH2PZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUH2PZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:25:46 -0400
Received: from delta.ds3.agh.edu.pl ([149.156.124.3]:39945 "EHLO
	pluto.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S267935AbUH2PZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:25:37 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/xfs/xfs_bmap - gcc34 warning killed.
Date: Sun, 29 Aug 2004 17:25:34 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uVfMBT6h9S0WRLk"
Message-Id: <200408291725.34780.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_uVfMBT6h9S0WRLk
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

CC [M] =C2=A0fs/xfs/xfs_bmap.o
fs/xfs/xfs_bmap.c: In function `xfs_bmap_do_search_extents':
fs/xfs/xfs_bmap.c:3434: warning: integer constant is too large for "long" t=
ype
fs/xfs/xfs_bmap.c:3435: warning: integer constant is too large for "long" t=
ype
fs/xfs/xfs_bmap.c:3439: warning: integer constant is too large for "long" t=
ype

=2D-=20
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_uVfMBT6h9S0WRLk
Content-Type: text/x-diff;
  charset="utf-8";
  name="xfs_bmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="xfs_bmap.patch"

--- linux-2.6.9-rc1/fs/xfs/xfs_bmap.c.orig	2004-08-24 09:03:32.000000000 +0200
+++ linux-2.6.9-rc1/fs/xfs/xfs_bmap.c	2004-08-29 17:17:07.737547088 +0200
@@ -3431,12 +3431,12 @@
 	* uninitialized br_startblock field.
 	*/
 
-        got.br_startoff = 0xffa5a5a5a5a5a5a5;
-        got.br_blockcount = 0xa55a5a5a5a5a5a5a;
+        got.br_startoff = 0xffa5a5a5a5a5a5a5ULL;
+        got.br_blockcount = 0xa55a5a5a5a5a5a5aULL;
         got.br_state = XFS_EXT_INVALID;
 
 	#if XFS_BIG_BLKNOS
-        	got.br_startblock = 0xffffa5a5a5a5a5a5;
+        	got.br_startblock = 0xffffa5a5a5a5a5a5ULL;
 	#else
 		got.br_startblock = 0xffffa5a5;
 	#endif

--Boundary-00=_uVfMBT6h9S0WRLk--
