Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319332AbSHVOly>; Thu, 22 Aug 2002 10:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319355AbSHVOly>; Thu, 22 Aug 2002 10:41:54 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:41709 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S319332AbSHVOlx>;
	Thu, 22 Aug 2002 10:41:53 -0400
Message-ID: <3D64F92A.9040406@acm.org>
Date: Thu, 22 Aug 2002 09:46:02 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] export symbol for panic_notifier_list
Content-Type: multipart/mixed;
 boundary="------------010301020404080107090403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010301020404080107090403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If a module needs to be notified of a panic, well, it needs to get at 
the notifier list, but that's not exported.  patch is attached.

Thanks,

-Corey

--------------010301020404080107090403
Content-Type: text/plain;
 name="linux-export_panic_list.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-export_panic_list.diff"

--- linux.orig/kernel/ksyms.c	Thu Aug 22 08:20:26 2002
+++ linux/kernel/ksyms.c	Thu Aug 22 09:03:01 2002
@@ -492,6 +492,7 @@
 
 /* misc */
 EXPORT_SYMBOL(panic);
+EXPORT_SYMBOL(panic_notifier_list);
 EXPORT_SYMBOL(sprintf);
 EXPORT_SYMBOL(snprintf);
 EXPORT_SYMBOL(sscanf);

--------------010301020404080107090403--

