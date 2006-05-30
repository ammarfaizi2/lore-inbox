Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWE3IrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWE3IrT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWE3IrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:47:19 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:40079 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932190AbWE3Iq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:46:58 -0400
Message-ID: <348978815.17342@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060530084705.962458563@localhost.localdomain>
References: <20060530084030.274375770@localhost.localdomain>
Date: Tue, 30 May 2006 16:40:34 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [patch 4/4] readahead: backward prefetching method - add use case comment
Content-Disposition: inline; filename=readahead-method-backward-fix-use-case-comment.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backward prefetching is vital to structural analysis and some other
scientific applications. Comment this use case.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1540,6 +1540,8 @@ initial_readahead(struct address_space *
  * Backward prefetching.
  *
  * No look-ahead and thrashing safety guard: should be unnecessary.
+ *
+ * Important for certain scientific arenas(i.e. structural analysis).
  */
 static int
 try_read_backward(struct file_ra_state *ra, pgoff_t begin_index,

--
