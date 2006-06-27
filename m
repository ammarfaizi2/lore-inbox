Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933435AbWF0Elx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435AbWF0Elx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933429AbWF0Elw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:41:52 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:45019 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933414AbWF0Ele
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:41:34 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 06/21] [Suspend2] Get userui storage needed.
Date: Tue, 27 Jun 2006 14:41:33 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044131.14883.65594.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of space needed in the image header for userui settings.
This is currently just the name of the program we're running.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 48719de..21c6be7 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -176,3 +176,8 @@ static int userui_user_rcv_msg(struct sk
 	return 1;
 }
 
+static unsigned long userui_storage_needed(void)
+{
+	return sizeof(ui_helper_data.program) + 1 + sizeof(int);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
