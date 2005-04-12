Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVDLUXC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVDLUXC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVDLUVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:21:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:20680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262131AbVDLKb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:27 -0400
Message-Id: <200504121030.j3CAUdVp005109@shell0.pdx.osdl.net>
Subject: [patch 001/198] mmtimer build fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, clameter@engr.sgi.com,
       clameter@sgi.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Christoph Lameter <clameter@engr.sgi.com>

Signed-off-by: Christoph Lameter <clameter@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/char/mmtimer.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/mmtimer.c~mmtimer-build-fix drivers/char/mmtimer.c
--- 25/drivers/char/mmtimer.c~mmtimer-build-fix	2005-04-12 03:21:03.896544536 -0700
+++ 25-akpm/drivers/char/mmtimer.c	2005-04-12 03:21:03.900543928 -0700
@@ -485,7 +485,7 @@ void mmtimer_tasklet(unsigned long data)
 		goto out;
 	t->it_overrun = 0;
 
-	if (tasklist_lock.write_lock || posix_timer_event(t, 0) != 0) {
+	if (posix_timer_event(t, 0) != 0) {
 
 		// printk(KERN_WARNING "mmtimer: cannot deliver signal.\n");
 
_
