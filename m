Return-Path: <linux-kernel-owner+w=401wt.eu-S932926AbWLTBfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932926AbWLTBfA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWLTBfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:35:00 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:53566 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932926AbWLTBe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:34:59 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 20:34:59 EST
Date: Wed, 20 Dec 2006 01:34:55 +0100
From: Vincent Legoll <vlegoll@9online.fr>
Subject: [patch 1/4] Add <linux/klog.h>
To: zackw@panix.com
Cc: linux-kernel@vger.kernel.org
Message-id: <4588852F.4070703@9online.fr>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_02ZJNXwipOrTDjHjsA1odQ)"
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_02ZJNXwipOrTDjHjsA1odQ)
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT

Hello,

what about something along the lines of the following,
on top of your patch ?

Or should the kernel-doc be put on another function
instead of that one ?

-- 
Vincent Legoll

--Boundary_(ID_02ZJNXwipOrTDjHjsA1odQ)
Content-type: text/plain; name=do-syslog-kernel-doc
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=do-syslog-kernel-doc

Add do_syslog() kernel-doc

---
commit 95b0721d8b4b46ddf83113fe49492810d7d92060
tree e2715a8cf7eb0d71b3bee2185a5cf98639d79d90
parent de794d2dfd6dd0c38dd552020ac00c46e1df5293
author Vincent Legoll <vincent.legoll@gmail.com> Wed, 20 Dec 2006 01:29:34 +0100
committer Vincent Legoll <vincent.legoll@gmail.com> Wed, 20 Dec 2006 01:29:34 +0100

 kernel/printk.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 232467e..5416d07 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -164,7 +164,16 @@ out:
 
 __setup("log_buf_len=", log_buf_len_setup);
 
-/* See linux/klog.h for the command numbers passed as the first argument.  */
+/**
+ * do_syslog - operate on kernel messages log
+ * @type: operation to perform
+ * @buf: user-space buffer to copy data into
+ * @len: length of data to copy from log into @buf
+ *
+ * See include/linux/klog.h for the command numbers passed as @type.
+ * Parameters @buf & @len are only used for operations of type %KLOG_READ,
+ * %KLOG_READ_HIST and %KLOG_READ_CLEAR_HIST.
+ */
 int do_syslog(int type, char __user *buf, int len)
 {
 	unsigned long i, j, limit, count;

--Boundary_(ID_02ZJNXwipOrTDjHjsA1odQ)--
