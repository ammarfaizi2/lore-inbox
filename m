Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933326AbWFZWtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326AbWFZWtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933320AbWFZWtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:49:19 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:42167 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933326AbWFZWls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:41:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 12/28] [Suspend2] Swapwriter storage allocated and available.
Date: Tue, 27 Jun 2006 08:41:46 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626224144.4975.65646.stgit@nigel.suspend2.net>
In-Reply-To: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
References: <20060626224105.4975.90758.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return the amount of storage available and llocated for swapwriter use.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/suspend_swap.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/kernel/power/suspend_swap.c b/kernel/power/suspend_swap.c
index af6640f..792bcc8 100644
--- a/kernel/power/suspend_swap.c
+++ b/kernel/power/suspend_swap.c
@@ -418,3 +418,14 @@ static void get_main_pool_phys_params(vo
 	swapwriter_allocate_header_space(prev_header_pages_allocated);
 }
 
+static int swapwriter_storage_allocated(void)
+{
+	return swapextents.size;
+}
+
+static int swapwriter_storage_available(void)
+{
+	si_swapinfo(&swapinfo);
+	return swapinfo.freeswap + swapwriter_storage_allocated();
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
