Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTH3DVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 23:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTH3DVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 23:21:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49781 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S262364AbTH3DU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 23:20:59 -0400
Date: Fri, 29 Aug 2003 23:20:16 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]   2.4.23-pre1 - Missing include in kernel/panic.c
To: marcelo@conectiva.com.br
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3F5017F0.4090000@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_Md4xvPUPZ9mMRKuS4UaXJQ)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_Md4xvPUPZ9mMRKuS4UaXJQ)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Marcelo,

    the following patch removes a compile warning because 
 disable_console_blank()  is used without a prototype.

Stephane Ouellette


--Boundary_(ID_Md4xvPUPZ9mMRKuS4UaXJQ)
Content-type: text/plain; name=panic.c-2.4.23-pre1.patch; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=panic.c-2.4.23-pre1.patch

--- linux-2.4.23-pre1-orig/kernel/panic.c	Fri Aug 29 12:43:04 2003
+++ linux-2.4.23-pre1-fixed/kernel/panic.c	Fri Aug 29 13:18:51 2003
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
+#include <linux/console.h>
 
 asmlinkage void sys_sync(void);	/* it's really int */
 

--Boundary_(ID_Md4xvPUPZ9mMRKuS4UaXJQ)--
