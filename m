Return-Path: <linux-kernel-owner+w=401wt.eu-S1751209AbXAFH2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXAFH2B (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 02:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbXAFH1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 02:27:37 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:59143 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751206AbXAFH10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 02:27:26 -0500
Message-ID: <368068420.98357@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20070106072729.455570443@mail.ustc.edu.cn>
References: <20070106072626.911640026@mail.ustc.edu.cn>
User-Agent: quilt/0.45-1
Date: Sat, 06 Jan 2007 15:26:27 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] readahead: sysctl parameters: set readahead_hit_rate=1
Content-Disposition: inline; filename=readahead-sysctl-parameters-set-readahead_hit_rate-1.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Set default readahead_hit_rate to 1 for the majority users.

Signed-off-by: Fengguang Wu <wfg@mail.ustc.edu.cn>
---
 Documentation/sysctl/vm.txt |    2 +-
 mm/readahead.c              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux.orig/Documentation/sysctl/vm.txt
+++ linux/Documentation/sysctl/vm.txt
@@ -261,4 +261,4 @@ Possible values can be:
 
 The larger value, the more capabilities, with more possible overheads.
 
-The default value is 0.
+The default value is 1.
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -42,7 +42,7 @@ int readahead_ratio = 50;
 EXPORT_SYMBOL_GPL(readahead_ratio);
 
 /* Readahead as long as cache hit ratio keeps above 1/##. */
-int readahead_hit_rate = 0;
+int readahead_hit_rate = 1;
 #endif /* CONFIG_ADAPTIVE_READAHEAD */
 
 /*

--
