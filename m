Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVDLMyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVDLMyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVDLMxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:53:55 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:15986 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262390AbVDLMsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:48:15 -0400
Message-ID: <425BC387.3080703@yahoo.com.au>
Date: Tue, 12 Apr 2005 22:48:07 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: [patch 1/9] GFP_ZERO fix
References: <425BC262.1070500@yahoo.com.au>
In-Reply-To: <425BC262.1070500@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------010008010200040206080507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010008010200040206080507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

1/9

-- 
SUSE Labs, Novell Inc.

--------------010008010200040206080507
Content-Type: text/plain;
 name="GFP_ZERO-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="GFP_ZERO-fix.patch"

__GFP_ZERO really shouldn't tempt fate.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h	2005-04-12 22:05:49.000000000 +1000
+++ linux-2.6/include/linux/gfp.h	2005-04-12 22:26:10.000000000 +1000
@@ -44,8 +44,8 @@ struct vm_area_struct;
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
-			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP)
+			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
+			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO)
 
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_NOIO	(__GFP_WAIT)

--------------010008010200040206080507--

