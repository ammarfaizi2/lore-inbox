Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWIAAEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWIAAEs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWIAAEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:04:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:50163 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932410AbWIAAEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:04:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LFKbW6peqaaeXTKrNDdfQOm8c9ti8ViN0C/Q6i5eDDuPGPsVqohqM5HoaewBdtnSww+FH9mfHq+oFFx9NIGLST1YZRM9bjMAsXZoZpMVbG+8/zeNf6eutzmKlOkdUNQHMSvK0tIzSYb3euJsEXYo1jMTxNaHdcW7pEbqfCX4yDA=
Message-ID: <728201270608311704n6c505bdcy3abfd7be483be950@mail.gmail.com>
Date: Thu, 31 Aug 2006 19:04:46 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH]mm:Updating comments to reflect current code
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>, trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the comments for __oom_kill_task function to
reflect the code changes. Please apply

Signed-off-by: Ram Gupta<r.gupta@astronautics.com>
-----

--- linux-2.6.18-rc5-rg/mm/oom_kill.c.orig      2006-08-31
18:03:29.000000000 -0500
+++ linux-2.6.18-rc5-rg/mm/oom_kill.c   2006-08-31 18:17:50.000000000 -0500
@@ -221,9 +221,9 @@ static struct task_struct *select_bad_pr
 }

 /**
- * We must be careful though to never send SIGKILL a process with
- * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
- * we select a process with CAP_SYS_RAW_IO set).
+ * Send SIGKILL to the selected  process irrespective of  CAP_SYS_RAW_IO
+ * flag though it's unlikely that  we select a process with CAP_SYS_RAW_IO
+ * set.
  */
 static void __oom_kill_task(struct task_struct *p, const char *message)
 {

Thanks
Ram Gupta
