Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVDBQGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVDBQGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 11:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbVDBQGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 11:06:16 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:12501 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261613AbVDBQGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 11:06:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=I+GDB5zLDjfj1lxeypT6r5st3Vl45QCoAuW7sFpa4GlzcWg7oIdq9JCLqmG6wtuxc9ZfxJwzEkqXE9GZyDCxVxg98nbw14t9GqpRUnn9AVmViEehYJZSq4j/2K9EuM1OeoErfjQrelSfzMyPDABtbr/uTfbpMAg6eaLjkA0wjko=
Date: Sat, 2 Apr 2005 18:05:45 +0200
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: make OOM more "user friendly"
Message-Id: <20050402180545.29e10629.diegocg@gmail.com>
X-Mailer: Sylpheed version 1.9.7+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When people gets OOM messages, many of them don't know what is happening or what
OOM means. This brief message explains it.

--- stable/mm/oom_kill.c.orig	2005-04-02 17:44:14.000000000 +0200
+++ stable/mm/oom_kill.c	2005-04-02 18:01:02.000000000 +0200
@@ -189,7 +189,8 @@
 		return;
 	}
 	task_unlock(p);
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
+	printk(KERN_ERR "The system has run Out Of Memory (RAM + swap), a process will be killed to free some memory\n");
+	printk(KERN_ERR "OOM: Killed process %d (%s).\n", p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
