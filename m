Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbTF3SVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 14:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTF3SVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 14:21:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:49196 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S265855AbTF3SVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 14:21:53 -0400
Date: Mon, 30 Jun 2003 14:36:09 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Patch for sys_pciconfig_read|write in cond_syscall
Message-ID: <20030630143609.J13329@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Christoph,

did you send this anywhere? It is not in 2.5.73-bk7.

-- Pete

diff -urN -X dontdiff linux-2.5.73-bk7/kernel/sys.c linux-2.5.73-bk7-sparc/kernel/sys.c
--- linux-2.5.73-bk7/kernel/sys.c	2003-06-23 22:23:18.000000000 -0700
+++ linux-2.5.73-bk7-sparc/kernel/sys.c	2003-06-29 21:27:26.000000000 -0700
@@ -231,6 +231,8 @@
 cond_syscall(sys_epoll_create)
 cond_syscall(sys_epoll_ctl)
 cond_syscall(sys_epoll_wait)
+cond_syscall(sys_pciconfig_read)
+cond_syscall(sys_pciconfig_write)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
