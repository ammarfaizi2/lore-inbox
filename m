Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSJAXpV>; Tue, 1 Oct 2002 19:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbSJAXpU>; Tue, 1 Oct 2002 19:45:20 -0400
Received: from u212-239-148-129.freedom.planetinternet.be ([212.239.148.129]:12294
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S262871AbSJAXpT>; Tue, 1 Oct 2002 19:45:19 -0400
Message-Id: <200210012349.g91NnN8Z005848@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aha152x.c 2.5.40 queue_task compile failure
Date: Wed, 02 Oct 2002 01:49:23 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unless I utterly misunderstood something, the following should 
be obviously correct:

--- linux.orig/drivers/scsi/aha152x.c   Wed Oct  2 01:39:42 2002
+++ linux/drivers/scsi/aha152x.c        Wed Oct  2 01:40:05 2002
@@ -1941,8 +1941,7 @@
        /* Poke the BH handler */
        HOSTDATA(shpnt)->service++;
        aha152x_tq.routine = (void *) run;
-       queue_task(&aha152x_tq, &tq_immediate);
-       mark_bh(IMMEDIATE_BH);
+       schedule_task(&aha152x_tq);
 }
 
 /*

