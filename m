Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSFQU0H>; Mon, 17 Jun 2002 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSFQU0E>; Mon, 17 Jun 2002 16:26:04 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:45725 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316978AbSFQUZK>;
	Mon, 17 Jun 2002 16:25:10 -0400
Subject: [PATCH] 2.5.22: elevator exports.
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Jun 2002 00:23:54 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17K4ug-0000KB-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
the dasd driver as a module needs to call elevator_init/elavator_exit to
change the elevator algorithm to elevator_noop.

blue skies,
  Martin.

diff -urN linux-2.5.22/drivers/block/elevator.c linux-2.5.22-s390/drivers/block/elevator.c
--- linux-2.5.22/drivers/block/elevator.c	Mon Jun 17 04:31:35 2002
+++ linux-2.5.22-s390/drivers/block/elevator.c	Tue Jun 11 17:15:10 2002
@@ -424,3 +424,5 @@
 EXPORT_SYMBOL(__elv_add_request);
 EXPORT_SYMBOL(__elv_next_request);
 EXPORT_SYMBOL(elv_remove_request);
+EXPORT_SYMBOL(elevator_exit);
+EXPORT_SYMBOL(elevator_init);
