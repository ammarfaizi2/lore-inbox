Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288231AbSACHZM>; Thu, 3 Jan 2002 02:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288235AbSACHZE>; Thu, 3 Jan 2002 02:25:04 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:46084 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288231AbSACHYu>; Thu, 3 Jan 2002 02:24:50 -0500
Date: Thu, 3 Jan 2002 10:24:48 +0300
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [PATCH] reiserfs calls set_bit on not-a-long integer which causes oops on 64bit arches.
Message-ID: <20020103102448.A2655@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

   This patch fixes a problem for 64bit arches, because set_bit is only defined for long integers.
   Please apply.

Bye,
    Oleg

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="64bit_fix.diff"

--- linux/include/linux/reiserfs_fs_sb.h.org	Wed Jan  2 15:45:20 2002
+++ linux/include/linux/reiserfs_fs_sb.h	Wed Jan  2 15:45:36 2002
@@ -407,7 +407,7 @@
 				/* To be obsoleted soon by per buffer seals.. -Hans */
     atomic_t s_generation_counter; // increased by one every time the
     // tree gets re-balanced
-    unsigned int s_properties;    /* File system properties. Currently holds
+    unsigned long s_properties;    /* File system properties. Currently holds
 				     on-disk FS format */
     
     /* session statistics */




--45Z9DzgjV8m4Oswq--
