Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933433AbWF0Elq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933433AbWF0Elq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933432AbWF0Elp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:45 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:46043 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933427AbWF0Elk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:40 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/21] [Suspend2] Get amount of memory needed for userui.
Date: Tue, 27 Jun 2006 14:41:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044138.14883.97141.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of memory needed for the userui to operate. This doesn't
need to include the size of the program and it's data, just extra pages
needed while writing the image.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 16e540d..2f779a5 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -204,3 +204,9 @@ static void userui_load_config_info(char
 	ui_helper_data.program[sizeof(ui_helper_data.program)-1] = '\0';
 }
 
+static unsigned long userui_memory_needed(void)
+{
+	/* ball park figure of 128 pages */
+	return (128 * PAGE_SIZE);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
