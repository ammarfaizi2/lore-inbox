Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbTFEUg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 16:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbTFEUg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 16:36:28 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:28131 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S265116AbTFEUg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 16:36:26 -0400
Date: Thu, 5 Jun 2003 22:49:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: [Patch] 2.5.70-bk9 zlib cleanup #5 __32BIT__ and STDC
Message-ID: <20030605204955.GH22439@wohnheim.fh-wedel.de>
References: <20030605194644.GA22439@wohnheim.fh-wedel.de> <20030605200958.GB22439@wohnheim.fh-wedel.de> <20030605201850.GC22439@wohnheim.fh-wedel.de> <20030605203346.GE22439@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030605203346.GE22439@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This one is working now.  Please apply.

Jörn

-- 
When you close your hand, you own nothing. When you open it up, you
own the whole world.
-- Li Mu Bai in Tiger & Dragon

--- linux-2.5.70-bk9/include/linux/zconf.h~zlib_cleanup_more_intentions	2003-06-05 22:36:32.000000000 +0200
+++ linux-2.5.70-bk9/include/linux/zconf.h	2003-06-05 22:42:41.000000000 +0200
@@ -8,18 +8,6 @@
 #ifndef _ZCONF_H
 #define _ZCONF_H
 
-#if defined(__GNUC__) || defined(__386__) || defined(i386)
-#  ifndef __32BIT__
-#    define __32BIT__
-#  endif
-#endif
-
-#if defined(__STDC__) || defined(__cplusplus)
-#  ifndef STDC
-#    define STDC
-#  endif
-#endif
-
 /* The memory requirements for deflate are (in bytes):
             (1 << (windowBits+2)) +  (1 << (memLevel+9))
  that is: 128K for windowBits=15  +  128K for memLevel = 8  (default values)
@@ -49,13 +37,7 @@
 
                         /* Type declarations */
 
-#ifndef OF /* function prototypes */
-#  ifdef STDC
 #    define OF(args)  args
-#  else
-#    define OF(args)  ()
-#  endif
-#endif
 
 typedef unsigned char  Byte;  /* 8 bits */
 typedef unsigned int   uInt;  /* 16 bits or more */
