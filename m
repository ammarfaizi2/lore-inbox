Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267391AbSLLAoE>; Wed, 11 Dec 2002 19:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267392AbSLLAoE>; Wed, 11 Dec 2002 19:44:04 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:11663 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267391AbSLLAoC>; Wed, 11 Dec 2002 19:44:02 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 11 Dec 2002 16:53:37 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch/trvial^3] epoll bits forgot a nasty printk() ...
Message-ID: <Pine.LNX.4.50.0212111650390.2279-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, Robert made me notice that I forgot an explicit debugging printk()
inside the epoll module.


o Make the printk() to be debugging




- Davide



diff -Nru linux-2.5.51.vanilla/fs/eventpoll.c linux-2.5.51.epoll/fs/eventpoll.c
--- linux-2.5.51.vanilla/fs/eventpoll.c	Wed Dec 11 16:28:11 2002
+++ linux-2.5.51.epoll/fs/eventpoll.c	Wed Dec 11 16:31:46 2002
@@ -1573,7 +1573,7 @@
 	if (IS_ERR(eventpoll_mnt))
 		goto eexit_4;

-	printk(KERN_INFO "[%p] eventpoll: successfully initialized.\n", current);
+	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: successfully initialized.\n", current));

 	return 0;

