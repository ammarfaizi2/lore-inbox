Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270495AbRHQTVG>; Fri, 17 Aug 2001 15:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270552AbRHQTU7>; Fri, 17 Aug 2001 15:20:59 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:12680 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S270495AbRHQTUt>; Fri, 17 Aug 2001 15:20:49 -0400
Date: Fri, 17 Aug 2001 15:21:03 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Patch for Linus' 2.4.8 show_trace() on i386
Message-ID: <20010817152103.A30155@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is not relevant for latest and greatest where this
area was reworked completely, but in case anyone ships
a 2.4.8-based distro...

--- linux-2.4.8/arch/i386/kernel/traps.c	Wed Jun 20 13:59:44 2001
+++ linux-2.4.8-e/arch/i386/kernel/traps.c	Fri Aug 17 11:50:46 2001
@@ -105,7 +105,6 @@
 	i = 1;
 	module_start = VMALLOC_START;
 	module_end = VMALLOC_END;
-	module_end = 0;
 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
 		/*
