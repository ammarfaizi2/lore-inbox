Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUGQW6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUGQW6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUGQW6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:58:17 -0400
Received: from digitalimplant.org ([64.62.235.95]:37353 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262080AbUGQWf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:27 -0400
Date: Sat, 17 Jul 2004 15:35:19 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [11/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171529370.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1853, 2004/07/17 11:13:16-07:00, mochel@digitalimplant.org

[Power Mgmt] Fix up call in kernel/power/disk.c to swsusp_suspend().


 kernel/power/disk.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-07-17 14:51:17 -07:00
+++ b/kernel/power/disk.c	2004-07-17 14:51:17 -07:00
@@ -161,7 +161,7 @@

 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
-	if ((error = swsusp_save()))
+	if ((error = swsusp_suspend()))
 		goto Done;

 	if (in_suspend) {
