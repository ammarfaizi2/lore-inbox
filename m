Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280669AbRKYDM7>; Sat, 24 Nov 2001 22:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280670AbRKYDMt>; Sat, 24 Nov 2001 22:12:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:8967 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280669AbRKYDMe>;
	Sat, 24 Nov 2001 22:12:34 -0500
Date: Sun, 25 Nov 2001 01:12:14 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [kdb:PATCH] small update to latest kdb
Message-ID: <20011125011214.D1581@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

	I had to apply this patch on top of v1.9-2.4.15-pre5 to get it
compiling with 2.4.16-pre1 (its needed for 2.4.15 too, but I haven't tasted
that duck, luckily :-) ).

- Arnaldo

``"90% of everything is crap", Its called Sturgeon's law 8)
One of the problems is indeed finding the good bits''
    - Alan Cox

--- kdb/kdbmain.c.orig	Sun Nov 25 01:04:08 2001
+++ kdb/kdbmain.c	Sun Nov 25 01:04:36 2001
@@ -2360,7 +2360,7 @@
 	for_each_task(p) {
 		kdb_printf("0x%p %08d %08d  %1.1d  %3.3d  %s  0x%p%c%s\n",
 			   (void *)p, p->pid, p->p_pptr->pid,
-			   p->has_cpu, p->processor,
+			   task_has_cpu(p), p->processor,
 			   (p->state == 0)?"run ":(p->state>0)?"stop":"unrn",
 			   (void *)(&p->thread),
 			   (p == current) ? '*': ' ',
