Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVJAPCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVJAPCY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVJAPCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:02:24 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:41312 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750718AbVJAPCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:02:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=n7yeDp7gUo9FYXBSVsgKFFRbZ8nLWA9qMnn0/NNvppuUJKCpQEpVzl1JAArTLQ6NksEiz1VFtZLKkrWpTkcDMCTnB1kbArTXRZ6yYO9VcVSNzpjrY8hsaNYZ1pMSmr169UbhGHQdc6cgwhpH5wtNe1bBOKXVe9MlzTRLZO9QLEI=
Date: Sat, 1 Oct 2005 17:00:48 +0200
From: Diego Calleja <diegocg@gmail.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] trivial #if -> #ifdef
Message-Id: <20051001170048.354e2bdb.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Self-explanatory patch fixing bug #5340 (isn't easier to send a fix than 
report the bug?!)


Signed-off-by: Diego Calleja <diegocg@gmail.com>

--- stable/include/linux/mod_devicetable.h.BAK	2005-10-01 16:11:39.000000000 +0200
+++ stable/include/linux/mod_devicetable.h	2005-10-01 16:22:15.000000000 +0200
@@ -183,7 +183,7 @@ struct of_device_id
 	char	name[32];
 	char	type[32];
 	char	compatible[128];
-#if __KERNEL__
+#ifdef __KERNEL__
 	void	*data;
 #else
 	kernel_ulong_t data;
