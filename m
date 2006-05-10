Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWEJNgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWEJNgi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 09:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWEJNgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 09:36:38 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:53693 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964960AbWEJNgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 09:36:37 -0400
Date: Wed, 10 May 2006 09:36:23 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Gleb Natapov <gleb@minantech.com>
cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm 02/02] Redefine "lock" in Document futex PI design
In-Reply-To: <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605100930140.4503@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605090954150.7007@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100331290.31598@gandalf.stny.rr.com>
 <Pine.LNX.4.58.0605100429220.436@gandalf.stny.rr.com> <20060510101729.GB31504@elte.hu>
 <Pine.LNX.4.58.0605100657510.2485@gandalf.stny.rr.com> <20060510124600.GN5319@minantech.com>
 <Pine.LNX.4.58.0605100925190.4503@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try to explain the term lock better.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt
===================================================================
--- linux-2.6.17-rc3-mm1.orig/Documentation/rt-mutex-design.txt	2006-05-10 09:21:41.000000000 -0400
+++ linux-2.6.17-rc3-mm1/Documentation/rt-mutex-design.txt	2006-05-10 09:21:55.000000000 -0400
@@ -84,9 +84,11 @@ mutex    - In this document, to differen
            PI and spin locks that are used in the PI code, from now on
            the PI locks will be called a mutex.

-lock     - In this document from now on, the term lock and spin lock will
-	   be synonymous.  These are locks that are used for SMP as well
-	   as turning off preemption to protect areas of code on SMP machines.
+lock     - In this document from now on, I will use the term lock when refering
+           to spin locks that are used to protect parts of the PI algorithm.
+           These locks disable preemption for UP (when CONFIG_PREEMPT is
+           enabled) and on SMP prevents multiple CPUs from entering critical
+           sections simultaneously.

 spin lock - Same as lock above.

