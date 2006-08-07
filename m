Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWHGW4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWHGW4q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 18:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWHGW4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 18:56:22 -0400
Received: from xenotime.net ([66.160.160.81]:24497 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750853AbWHGW4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 18:56:16 -0400
Date: Mon, 7 Aug 2006 15:50:44 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, dhowells@redhat.com
Subject: [PATCH -mm 2/5] cachefiles: printk format warning
Message-Id: <20060807155044.a8eee456.rdunlap@xenotime.net>
In-Reply-To: <20060807154750.5a268055.rdunlap@xenotime.net>
References: <20060807154750.5a268055.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk format warning(s):
fs/cachefiles/cf-proc.c:247: warning: int format, different type arg (arg 4)

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 fs/cachefiles/cf-proc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2618-rc3mm2.orig/fs/cachefiles/cf-proc.c
+++ linux-2618-rc3mm2/fs/cachefiles/cf-proc.c
@@ -244,7 +244,7 @@ static ssize_t cachefiles_proc_write(str
 
 error:
 	kfree(data);
-	_leave(" = %d", ret);
+	_leave(" = %Zd", ret);
 	return ret;
 
 found_command:


---
