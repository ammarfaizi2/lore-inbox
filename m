Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbUBUJhp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 04:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUBUJhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 04:37:45 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:57989 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S261537AbUBUJho
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 04:37:44 -0500
Date: Sat, 21 Feb 2004 10:36:01 +0100
From: tim@cambrant.com
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove MOD_DEC_USE_COUNT from i2o_block.c
Message-ID: <20040221093601.GA32094@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please go easy on me if this patch is stupid, because it's not really
my patch. Someone told me these were removable alltogether since they
are deprecated, so I found one of them in John Cherry's compile stats
and simply removed it. Please apply in case it's not idiotic. Thanks.

Applies against Linux 2.6.3.



--- linux/drivers/message/i2o/i2o_block.c.orig	2004-02-21 10:04:45.895274304 +0100
+++ linux/drivers/message/i2o/i2o_block.c	2004-02-21 10:23:53.234852176 +0100
@@ -1503,9 +1503,6 @@ void i2ob_del_device(struct i2o_controll
 	 * Decrease usage count for module
 	 */	
 
-	while(i2ob_dev[unit].refcnt--)
-		MOD_DEC_USE_COUNT;
-
 	i2ob_dev[unit].refcnt = 0;
 	
 	i2ob_dev[i].tid = 0;
