Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVAPN6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVAPN6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVAPN5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:57:23 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:8324 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262506AbVAPNwp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:52:45 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050116135244.30109.69180.33718@localhost.localdomain>
In-Reply-To: <20050116135223.30109.26479.55757@localhost.localdomain>
References: <20050116135223.30109.26479.55757@localhost.localdomain>
Subject: [PATCH 3/13] ftape: remove cli()/sti() in drivers/char/ftape/lowlevel/ftape-format.c
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.220.243] at Sun, 16 Jan 2005 07:52:44 -0600
Date: Sun, 16 Jan 2005 07:52:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-format.c linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-format.c
--- linux-2.6.11-rc1-mm1-original/drivers/char/ftape/lowlevel/ftape-format.c	2004-12-24 16:34:45.000000000 -0500
+++ linux-2.6.11-rc1-mm1/drivers/char/ftape/lowlevel/ftape-format.c	2005-01-16 07:32:19.293557207 -0500
@@ -132,7 +132,7 @@
 	TRACE_CATCH(ftape_seek_head_to_track(track),);
 	TRACE_CATCH(ftape_command(QIC_LOGICAL_FORWARD),);
 	spin_lock_irqsave(&ftape_format_lock, flags);
-	TRACE_CATCH(fdc_setup_formatting(head), restore_flags(flags));
+	TRACE_CATCH(fdc_setup_formatting(head),);
 	spin_unlock_irqrestore(&ftape_format_lock, flags);
 	TRACE_EXIT 0;
 }
