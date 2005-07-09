Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVGILMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVGILMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 07:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVGILMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 07:12:17 -0400
Received: from gold.veritas.com ([143.127.12.110]:51754 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261201AbVGILML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 07:12:11 -0400
Date: Sat, 9 Jul 2005 12:13:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 14/13] swsusp mod needed parentheses
In-Reply-To: <Pine.LNX.4.61.0507090111440.13391@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0507091211390.18520@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507090057340.13391@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0507090111440.13391@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jul 2005 11:12:08.0791 (UTC) FILETIME=[0C0A6670:01C58477]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, some parentheses around my SWP_WRITEOK check would help.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 kernel/power/swsusp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- swap13/kernel/power/swsusp.c	2005-07-08 19:15:59.000000000 +0100
+++ swap14/kernel/power/swsusp.c	2005-07-09 12:04:19.000000000 +0100
@@ -180,7 +180,7 @@ static int swsusp_swap_check(void) /* Th
 
 	spin_lock(&swap_lock);
 	for (i=0; i<MAX_SWAPFILES; i++) {
-		if (!swap_info[i].flags & SWP_WRITEOK) {
+		if (!(swap_info[i].flags & SWP_WRITEOK)) {
 			swapfile_used[i]=SWAPFILE_UNUSED;
 		} else {
 			if (!len) {
