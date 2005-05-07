Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbVEGIiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbVEGIiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVEGI0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:26:24 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:4773 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262799AbVEGIOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:14:12 -0400
Date: Sat, 07 May 2005 17:12:31 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 3/4] nommu - trivial patch for fs/proc/task_nommu.c
To: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GJN1JK4Y@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3IPopSDvZBuITNGlTe+TuQX4nQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trivial patch against 2.6.12-rc3-mm3, fs/proc/task_nommu.c  :
need to declare the "proc_pid_smaps_op" struct to compile for nommu
architectures.

Signed-off-by : Hyok S. Choi <hyok.choi@samsung.com>

Index: linux-2.6.12-rc3-mm3/fs/proc/task_nommu.c
================================================================
--- linux-2.6.12-rc3-mm3/fs/proc/task_nommu.c	2005-03-02
16:38:10.000000000 +0900
+++ linux-2.6.12-rc3-mm3-hsc0/fs/proc/task_nommu.c	2005-05-06
12:05:11.000000000 +0900
@@ -162,3 +162,9 @@
 	.stop	= m_stop,
 	.show	= show_map
 };
+struct seq_operations proc_pid_smaps_op = {
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= show_map
+};

