Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270228AbTHQNn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270243AbTHQNn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:43:26 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:54190 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S270228AbTHQNnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:43:18 -0400
Message-ID: <3F3F8818.9040101@t-online.de>
Date: Sun, 17 Aug 2003 15:50:16 +0200
From: Dominik.Strasser@t-online.de (Dominik Strasser)
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scsi.h uses "u8" which isn't defined.
References: <3F3F782C.2030902@t-online.de> <20030817134633.A7881@infradead.org> <3F3F7E67.2040506@t-online.de> <20030817140735.A11477@infradead.org>
In-Reply-To: <20030817140735.A11477@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: JrywsqZE8exYMuzgtX9pct5wsVyd7Gu6ZxWinixOE+dhKm+0FCoq0o
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Aug 17, 2003 at 03:08:55PM +0200, Dominik Strasser wrote:
> 
>>I am sorry, in 2.6.0-test3 (which I should have mentioned), there is no 
>>u8 in liux/types.h.
> 
> 
> u8 is defined in asm/types.h but the proper way to include asm/types.h
> is through linux/types.h.
> 
> 
>>Just a __u8.
>>Nevertheless there is a mixture in scsi.h, some lines above, u_char is 
>>used. This is why I chose to use it.
> 
> 
> If you want consistency please convert all u_char to u8 (similar
> for u_short -> u16 and u_int -> u32)
> 
> 

OK, here we go:

--- /tmp/scsi.h 2003-08-17 14:39:42.000000000 +0200
+++ include/scsi/scsi.h 2003-08-17 15:46:27.000000000 +0200
@@ -6,6 +6,8 @@
   * the scsi code for linux.
   */

+#include <linux/types.h>
+
  /*
      $Header: /usr/src/linux/include/linux/RCS/scsi.h,v 1.3 1993/09/24 
12:20:33 drew Exp $

@@ -208,18 +210,18 @@

  struct ccs_modesel_head
  {
-    u_char  _r1;    /* reserved */
-    u_char  medium; /* device-specific medium type */
-    u_char  _r2;    /* reserved */
-    u_char  block_desc_length; /* block descriptor length */
-    u_char  density; /* device-specific density code */
-    u_char  number_blocks_hi; /* number of blocks in this block desc */
-    u_char  number_blocks_med;
-    u_char  number_blocks_lo;
-    u_char  _r3;
-    u_char  block_length_hi; /* block length for blocks in this desc */
-    u_char  block_length_med;
-    u_char  block_length_lo;
+    u8  _r1;    /* reserved */
+    u8  medium; /* device-specific medium type */
+    u8  _r2;    /* reserved */
+    u8  block_desc_length; /* block descriptor length */
+    u8  density; /* device-specific density code */
+    u8  number_blocks_hi; /* number of blocks in this block desc */
+    u8  number_blocks_med;
+    u8  number_blocks_lo;
+    u8  _r3;
+    u8  block_length_hi; /* block length for blocks in this desc */
+    u8  block_length_med;
+    u8  block_length_lo;
  };

  /*

