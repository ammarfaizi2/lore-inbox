Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933295AbWFZW40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295AbWFZW40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFZW4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:56:24 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32439 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933307AbWFZWko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 29/35] [Suspend2] Test filewriter target.
Date: Tue, 27 Jun 2006 08:40:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224041.4685.11403.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Test the filewriter target when the filewriter_target proc entry is
written.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index 9947323..56de7d9 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -858,3 +858,17 @@ static int __test_filewriter_target(char
 	return 1;
 }
 
+static void test_filewriter_target(void)
+{
+	int cant_suspend;
+
+	setting_filewriter_target = 1;
+       	
+	printk(name_suspend "Filewriter: Testing whether you can suspend:\n");
+	cant_suspend =__test_filewriter_target(filewriter_target, 0);
+
+	printk(name_suspend "Suspending %sabled.\n",  cant_suspend ? "dis" : "en");
+	
+	setting_filewriter_target = 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
