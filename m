Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265602AbSKACbw>; Thu, 31 Oct 2002 21:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265606AbSKACbw>; Thu, 31 Oct 2002 21:31:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:32491 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265602AbSKACbv>; Thu, 31 Oct 2002 21:31:51 -0500
Date: Thu, 31 Oct 2002 18:35:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
cc: mingo@elte.hu, Erich Focht <efocht@ess.nec.de>
Subject: Re: [PATCH 2.5.45] NUMA Scheduler  (1/2)
Message-ID: <3481414249.1036089305@[10.10.2.3]>
In-Reply-To: <1010470000.1036108344@flay>
References: <1010470000.1036108344@flay>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========3481431698=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========3481431698==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hum. A last minute change broke UP compilation.
Attatched ... should come out as text/plain so you can read 
it, but if it all goes wrong, it just removes:

       if (cache_decay_ticks)
               cache_decay_ticks=1;

from sched_init.

M.

--==========3481431698==========
Content-Type: text/plain; charset=us-ascii; name=numaschedfix
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=numaschedfix; size=357

--- 2.5.45-numasched/kernel/sched.c.old	2002-10-31 17:48:41.000000000 -0800
+++ 2.5.45-numasched/kernel/sched.c	2002-10-31 17:51:43.000000000 -0800
@@ -2331,8 +2331,7 @@
 			__set_bit(MAX_PRIO, array->bitmap);
 		}
 	}
-	if (cache_decay_ticks)
-		cache_decay_ticks=1;
+
 	/*
 	 * We have to do a little magic to get the first
 	 * thread right in SMP mode.

--==========3481431698==========--

