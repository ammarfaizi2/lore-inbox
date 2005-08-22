Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbVHVW3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbVHVW3V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbVHVW2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:28:12 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:17289 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751433AbVHVWZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:25:29 -0400
Date: Mon, 22 Aug 2005 10:15:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] suspend: update warnings
Message-ID: <20050822081528.GA4418@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update suspend documentation. Warnings were a bit overstated, and did
not point out important stuff.

---
commit 790df7223ac29afec81e7201adc879973311f27e
tree 97fa2017f8f5aded0c44cfc75ba4903fbdb7f0a4
parent 63393fcbf056a6fd68142a49ed4e1258560dce2c
author <pavel@amd.(none)> Mon, 22 Aug 2005 10:13:51 +0200
committer <pavel@amd.(none)> Mon, 22 Aug 2005 10:13:51 +0200

 Documentation/power/swsusp.txt |   60 ++++++++++++++++++++++++++++++++--------
 Documentation/power/video.txt  |    9 +++++-
 2 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -1,22 +1,20 @@
-From kernel/suspend.c:
+Some warnings, first.
 
  * BIG FAT WARNING *********************************************************
  *
- * If you have unsupported (*) devices using DMA...
- *				...say goodbye to your data.
- *
  * If you touch anything on disk between suspend and resume...
  *				...kiss your data goodbye.
  *
- * If your disk driver does not support suspend... (IDE does)
- *				...you'd better find out how to get along
- *				   without your data.
- *
- * If you change kernel command line between suspend and resume...
- *			        ...prepare for nasty fsck or worse.
+ * If you do resume from initrd after your filesystems are mounted...
+ *				...bye bye root partition.
+ *			[this is actually same case as above]
  *
- * If you change your hardware while system is suspended...
- *			        ...well, it was not good idea.
+ * If you have unsupported (*) devices using DMA, you may have some
+ * problems. If your disk driver does not support suspend... (IDE does),
+ * it may cause some problems, too. If you change kernel command line 
+ * between suspend and resume, it may do something wrong. If you change 
+ * your hardware while system is suspended... well, it was not good idea;
+ * but it wil probably only crash.
  *
  * (*) suspend/resume support is needed to make it safe.
 

-- 
if you have sharp zaurus hardware you don't need... you know my address
