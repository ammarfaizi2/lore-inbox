Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVAaHXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVAaHXB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVAaHXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:23:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:42726 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261932AbVAaHWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:22:55 -0500
Date: Sun, 30 Jan 2005 23:22:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: sneakums@zork.net, linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
Message-Id: <20050130232251.7ad649c4.akpm@osdl.org>
In-Reply-To: <1107155510.5905.2.camel@gaston>
References: <20050129163117.1626d404.akpm@osdl.org>
	<1107155510.5905.2.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> It seems -mm2 definitely has some problems regarding loading of modules,

--- 25/include/linux/stop_machine.h~fix-kallsyms-insmod-rmmod-race-fix-fix-fix	2005-01-29 16:17:47.936137064 -0800
+++ 25-akpm/include/linux/stop_machine.h	2005-01-29 16:18:09.493859792 -0800
@@ -57,7 +57,7 @@ static inline int stop_machine_run(int (
 static inline int stop_machine_run(int (*fn)(void *), void *data,
 				   unsigned int cpu)
 {
-	return 0;
+	return fn(data);
 }
 
 #endif	/* CONFIG_STOP_MACHINE */
_

