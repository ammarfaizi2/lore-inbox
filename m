Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTBIMK6>; Sun, 9 Feb 2003 07:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbTBIMJU>; Sun, 9 Feb 2003 07:09:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20154 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267259AbTBIMIT>;
	Sun, 9 Feb 2003 07:08:19 -0500
Date: Sun, 9 Feb 2003 13:23:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>, Arjan van de Ven <arjanv@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <Pine.LNX.4.44.0302091305180.5085-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302091322460.5637-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arjan pointed out that this one is needed as well:

--- linux/kernel/ksyms.c.orig
+++ linux/kernel/ksyms.c
@@ -604,6 +604,7 @@
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(find_task_by_pid);
 EXPORT_SYMBOL(next_thread);
+EXPORT_SYMBOL_GPL(set_special_pids);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif

