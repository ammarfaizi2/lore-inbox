Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933102AbWFZWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102AbWFZWcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933115AbWFZWb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:31:56 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:61418 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933102AbWFZWbl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:31:41 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/7] [Suspend2] Pages for zone.
Date: Tue, 27 Jun 2006 08:31:39 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626223138.3725.12590.stgit@nigel.suspend2.net>
In-Reply-To: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
References: <20060626223128.3725.55605.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Find out how many pages are used for the bitmap for a given zone.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/pageflags.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/kernel/power/pageflags.c b/kernel/power/pageflags.c
index 3781fc8..ec028d3 100644
--- a/kernel/power/pageflags.c
+++ b/kernel/power/pageflags.c
@@ -37,3 +37,9 @@ static int num_zones(void)
 	return result;
 }
 
+static int pages_for_zone(struct zone *zone)
+{
+	return (zone->spanned_pages + (PAGE_SIZE << 3) - 1) /
+			(PAGE_SIZE << 3);
+}
+

--
Nigel Cunningham		nigel at suspend2 dot net
