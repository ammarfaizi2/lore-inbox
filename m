Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSL0QBn>; Fri, 27 Dec 2002 11:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSL0QBn>; Fri, 27 Dec 2002 11:01:43 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:21308 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S264983AbSL0QBm>; Fri, 27 Dec 2002 11:01:42 -0500
Date: Fri, 27 Dec 2002 17:09:16 +0100
Message-Id: <200212271609.gBRG9GjA007893@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Rusty Trivial Russell <trivial@rustcorp.com.au>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] NCR5380 unbalanced curly brace
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inbalance of curly braces if AUTOSENSE is not defined.

--- linux-2.5.53/drivers/scsi/NCR5380.c	Tue Dec 10 13:41:29 2002
+++ linux-m68k-2.5.53/drivers/scsi/NCR5380.c	Sun Dec  1 21:45:41 2002
@@ -2489,8 +2489,9 @@
 						    hostdata->issue_queue;
 						hostdata->issue_queue = (Scsi_Cmnd *) cmd;
 						dprintk(NDEBUG_QUEUES, ("scsi%d : REQUEST SENSE added to head of issue queue\n", instance->host_no));
-					} else {
+					} else
 #endif				/* def AUTOSENSE */
+					{
 						collect_stats(hostdata, cmd);
 						cmd->scsi_done(cmd);
 					}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
