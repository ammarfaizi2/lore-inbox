Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbTASODM>; Sun, 19 Jan 2003 09:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267027AbTASODM>; Sun, 19 Jan 2003 09:03:12 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11393 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S266999AbTASODL>; Sun, 19 Jan 2003 09:03:11 -0500
Date: Sun, 19 Jan 2003 14:08:40 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Randy Hwron <rhwron@earthlink.net>,
       Geller Sandor <wildy@petra.hos.u-szeged.hu>,
       Michael Madore <mmadore@aslab.com>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       Bertrand Vieille <Bertrand.Vieille@crans.org>,
       Phil Oester <kernel@theoesters.com>,
       Tupshin Harper <tupshin@tupshin.com>,
       Bryan Andersen <bryan@bogonomicon.net>,
       Horacio de Oro <hgdeoro@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.21-pre3-ac oops
Message-ID: <Pine.LNX.4.44.0301191347310.2280-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you got 2.4.21-pre3-ac __free_pages_ok oops, please try this patch.

Hugh

--- 2.4.21-pre3-ac4/kernel/fork.c	Mon Jan 13 18:56:12 2003
+++ linux/kernel/fork.c	Sun Jan 19 13:39:37 2003
@@ -688,6 +688,8 @@
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
 
+	INIT_LIST_HEAD(&p->local_pages);
+
 	retval = -ENOMEM;
 	/* copy all the process information */
 	if (copy_files(clone_flags, p))

