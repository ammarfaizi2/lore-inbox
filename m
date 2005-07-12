Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVGLXDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVGLXDx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVGLXBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:01:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:64504 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262465AbVGLXBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:01:41 -0400
Subject: RT and XFS
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 12 Jul 2005 16:01:32 -0700
Message-Id: <1121209293.26644.8.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there something so odd about the XFS locking, that it can't use the
rt_lock ?


--- linux.orig/fs/xfs/linux-2.6/mrlock.h
+++ linux/fs/xfs/linux-2.6/mrlock.h
@@ -37,12 +37,12 @@
 enum { MR_NONE, MR_ACCESS, MR_UPDATE };
 
 typedef struct {
-	struct rw_semaphore	mr_lock;
-	int			mr_writer;
+	struct compat_rw_semaphore	mr_lock;
+	int				mr_writer;
 } mrlock_t;
 


