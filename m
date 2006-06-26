Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWFZW70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWFZW70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933281AbWFZWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:40:27 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:27831 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933295AbWFZWkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:40:13 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 20/35] [Suspend2] Filewriter image header read cleanup.
Date: Tue, 27 Jun 2006 08:40:11 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224009.4685.55474.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
References: <20060626223902.4685.52543.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup routine for reading a filewriter image header.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_file.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_file.c b/kernel/power/suspend_file.c
index da50422..8e4431c 100644
--- a/kernel/power/suspend_file.c
+++ b/kernel/power/suspend_file.c
@@ -656,3 +656,10 @@ static int filewriter_read_header_init(v
 	return 0;
 }
 
+static int filewriter_read_header_cleanup(void)
+{
+	free_page((unsigned long) suspend_writer_buffer);
+	suspend_writer_buffer = NULL;
+	return 0;
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
