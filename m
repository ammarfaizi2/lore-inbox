Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272788AbTHKQth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272821AbTHKQtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:49:36 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:64856 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272788AbTHKQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:49:29 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove useless assertions from reiserfs
Message-Id: <E19mFqr-00068B-00@tetrachloride>
Date: Mon, 11 Aug 2003 17:48:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/reiserfs/hashes.c linux-2.5/fs/reiserfs/hashes.c
--- bk-linus/fs/reiserfs/hashes.c	2003-04-10 06:01:29.000000000 +0100
+++ linux-2.5/fs/reiserfs/hashes.c	2003-07-13 06:04:57.000000000 +0100
@@ -90,10 +90,6 @@ u32 keyed_hash(const signed char *msg, i
 
 	if (len >= 12)
 	{
-	    	//assert(len < 16);
-		if (len >= 16)
-		    BUG();
-
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -116,9 +112,6 @@ u32 keyed_hash(const signed char *msg, i
 	}
 	else if (len >= 8)
 	{
-	    	//assert(len < 12);
-		if (len >= 12)
-		    BUG();
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -137,9 +130,6 @@ u32 keyed_hash(const signed char *msg, i
 	}
 	else if (len >= 4)
 	{
-	    	//assert(len < 8);
-		if (len >= 8)
-		    BUG();
 		a = (u32)msg[ 0]      |
 		    (u32)msg[ 1] << 8 |
 		    (u32)msg[ 2] << 16|
@@ -154,9 +144,6 @@ u32 keyed_hash(const signed char *msg, i
 	}
 	else
 	{
-	    	//assert(len < 4);
-		if (len >= 4)
-		    BUG();
 		a = b = c = d = pad;
 		for(i = 0; i < len; i++)
 		{
