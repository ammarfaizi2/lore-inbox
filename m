Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVJBBrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVJBBrE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 21:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVJBBrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 21:47:04 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12767 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750938AbVJBBrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 21:47:02 -0400
Date: Sat, 1 Oct 2005 18:46:47 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@zeniv.linux.org.uk>,
       Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20051002014647.26511.84451.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset one more crapectomy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove one more useless line from cpuset_common_file_read().

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.14-rc2-mm2/kernel/cpuset.c
===================================================================
--- 2.6.14-rc2-mm2.orig/kernel/cpuset.c
+++ 2.6.14-rc2-mm2/kernel/cpuset.c
@@ -995,7 +995,6 @@ static ssize_t cpuset_common_file_read(s
 		goto out;
 	}
 	*s++ = '\n';
-	*s = '\0';
 
 	retval = simple_read_from_buffer(buf, nbytes, ppos, page, s - page);
 out:

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
