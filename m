Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVAEC0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVAEC0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVAEC0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:26:51 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:39847 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S262211AbVAECYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:24:49 -0500
From: James Nelson <james4765@cwazy.co.uk>
To: linux-kernel@vger.kernel.org, linuxsh-shmedia-dev@lists.sourceforge.net
Cc: lethal@linux-sh.org, James Nelson <james4765@cwazy.co.uk>
Message-Id: <20050105022508.22297.55623.56061@localhost.localdomain>
In-Reply-To: <20050105022449.22297.54853.67329@localhost.localdomain>
References: <20050105022449.22297.54853.67329@localhost.localdomain>
Subject: [PATCH 3/3] sh64: remove cli()/sti() in arch/sh64/mm/fault.c
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.220.243] at Tue, 4 Jan 2005 20:24:48 -0600
Date: Tue, 4 Jan 2005 20:24:48 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-mm1-original/arch/sh64/mm/fault.c linux-2.6.10-mm1/arch/sh64/mm/fault.c
--- linux-2.6.10-mm1-original/arch/sh64/mm/fault.c	2005-01-03 18:42:41.000000000 -0500
+++ linux-2.6.10-mm1/arch/sh64/mm/fault.c	2005-01-04 21:06:29.331202671 -0500
@@ -148,7 +148,7 @@
 	mm = tsk->mm;
 
 	/* Not an IO address, so reenable interrupts */
-	sti();
+	local_irq_enable();
 
 	/*
 	 * If we're in an interrupt or have no user
