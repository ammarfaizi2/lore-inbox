Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWISGAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWISGAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 02:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWISGAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 02:00:42 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:40968 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S932301AbWISGAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 02:00:40 -0400
Subject: Re: [patch 7/8] process filtering for fault-injection capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <20060914102032.989190948@localhost.localdomain>
References: <20060914102012.251231177@localhost.localdomain>
	 <20060914102032.989190948@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 22:55:28 -0700
Message-Id: <1158645328.2419.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Temporary fix-up so that next patch:
"[patch 8/8] stacktrace filtering for fault-injection capabilities"
applies cleanly.


Signed-off-by: Don Mullis <dwm@meer.net>

---
 include/linux/fault-inject.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.17/include/linux/fault-inject.h
===================================================================
--- linux-2.6.17.orig/include/linux/fault-inject.h
+++ linux-2.6.17/include/linux/fault-inject.h
@@ -16,7 +16,9 @@ struct fault_attr {
 	atomic_t times;
 	atomic_t space;
 	unsigned long count;
-	atomic_t process_filter;
+
+	/* A value of '0' means process filter is disabled. */
+	u32 process_filter;
 };
 
 #define DEFINE_FAULT_ATTR(name) \


