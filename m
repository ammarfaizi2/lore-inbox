Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSDJPC3>; Wed, 10 Apr 2002 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313204AbSDJPBK>; Wed, 10 Apr 2002 11:01:10 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6160 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S313190AbSDJPBH>;
	Wed, 10 Apr 2002 11:01:07 -0400
Message-ID: <3CB45298.90504@namesys.com>
Date: Wed, 10 Apr 2002 18:56:24 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ReiserFS bugfixes 10 of 13
Content-Type: multipart/mixed;
 boundary="------------050905060501080005010508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050905060501080005010508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050905060501080005010508
Content-Type: message/rfc822;
 name="[PATCH] 2.5.8-pre3 patch 10 of 13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] 2.5.8-pre3 patch 10 of 13"


>From - Wed Apr 10 15:37:37 2002
X-Mozilla-Status2: 00000000
Return-Path: <green@namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 13275 invoked from network); 10 Apr 2002 11:21:51 -0000
Received: from angband.namesys.com (postfix@212.16.7.85)
  by thebsh.namesys.com with SMTP; 10 Apr 2002 11:21:51 -0000
Received: by angband.namesys.com (Postfix on SuSE Linux 7.3 (i386), from userid 521)
	id 195974D1B34; Wed, 10 Apr 2002 15:21:51 +0400 (MSD)
Date: Wed, 10 Apr 2002 15:21:51 +0400
From: Oleg Drokin <green@namesys.com>
To: reiser@namesys.com
Subject: [PATCH] 2.5.8-pre3 patch 10 of 13
Message-ID: <20020410152151.A20906@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i


This patch removes confusing warning about journal replay on readonly FS

--- linux-2.5.8-pre2/fs/reiserfs/journal.c.orig	Mon Apr  8 15:32:20 2002
+++ linux-2.5.8-pre2/fs/reiserfs/journal.c	Mon Apr  8 15:32:36 2002
@@ -1710,9 +1710,6 @@
     printk("clm-2076: device is readonly, unable to replay log\n") ;
     return -1 ;
   }
-  if (continue_replay && (p_s_sb->s_flags & MS_RDONLY)) {
-    printk("Warning, log replay starting on readonly filesystem\n") ;    
-  }
 
   /* ok, there are transactions that need to be replayed.  start with the first log block, find
   ** all the valid transactions, and pick out the oldest.



--------------050905060501080005010508--

