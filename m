Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTENS0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTENS0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:26:22 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:58319 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262636AbTENS0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:26:20 -0400
Message-ID: <3EC28D47.4020909@namesys.com>
Date: Wed, 14 May 2003 22:39:03 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK] [PATCH] [2.4] ReiserFS export balance_dirty
Content-Type: multipart/mixed;
 boundary="------------040304040609040108070507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040304040609040108070507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

please apply

-- 
Hans


--------------040304040609040108070507
Content-Type: message/rfc822;
 name="[PATCH] [2.4] export balance_dirty"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] [2.4] export balance_dirty"

Return-Path: <linux-kernel-owner+reiser=40namesys.com@vger.kernel.org>
Delivered-To: reiser@namesys.com
Received: (qmail 26148 invoked by uid 85); 14 May 2003 13:20:26 -0000
Received: from linux-kernel-owner+reiser=40namesys.com@vger.kernel.org by thebsh.namesys.com by uid 82 with qmail-scanner-1.15 
 (spamassassin: 2.43-cvs.  Clear:SA:0(-4.3/8.0):. 
 Processed in 1.371041 secs); 14 May 2003 13:20:26 -0000
Received: from vger.kernel.org (209.116.70.75)
  by thebsh.namesys.com with SMTP; 14 May 2003 13:20:25 -0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTENNE6 (ORCPT <rfc822;reiser@namesys.com>);
	Wed, 14 May 2003 09:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTENNE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:04:58 -0400
Received: from angband.namesys.com ([212.16.7.85]:46466 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262226AbTENNE4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:04:56 -0400
Received: by angband.namesys.com (Postfix, from userid 521)
	id 9FE3557F309; Wed, 14 May 2003 17:17:43 +0400 (MSD)
Date: Wed, 14 May 2003 17:17:43 +0400
From: Oleg Drokin <green@namesys.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4] export balance_dirty
Message-ID: <20030514131743.GB1875@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-Spam-Status: No, hits=-4.3 required=8.0
	tests=PATCH_UNIFIED_DIFF,USER_AGENT_MUTT,X_MAILING_LIST
	version=2.50-cvs

Hello!

    We seem to need balance_dirty to be exported now with latest
    reiserfs patches (so that reiserfs can be built as module).
    Please apply (against latest 2.4 bk tree).

    Thank you.

Bye,
    Oleg

===== fs/buffer.c 1.82 vs edited =====
--- 1.82/fs/buffer.c	Mon Dec 16 09:22:07 2002
+++ edited/fs/buffer.c	Wed May 14 16:51:00 2003
@@ -1026,6 +1026,7 @@
 		write_some_buffers(NODEV);
 	}
 }
+EXPORT_SYMBOL(balance_dirty);
 
 inline void __mark_dirty(struct buffer_head *bh)
 {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



--------------040304040609040108070507--

