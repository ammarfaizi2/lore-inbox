Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTJ2VL1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 16:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJ2VL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 16:11:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:13985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbTJ2VL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 16:11:26 -0500
Date: Wed, 29 Oct 2003 13:11:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: alpha@steudten.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.0-test 9: ALPHA:  missing asm/mca.h
Message-Id: <20031029131132.422cb65a.akpm@osdl.org>
In-Reply-To: <3FA02762.2070304@steudten.com>
References: <3FA02762.2070304@steudten.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Steudten <alpha@steudten.com> wrote:
>
> This problem ist still there in -test9..
> 
> In file included from drivers/net/3c509.c:77:
> include/linux/mca.h:15:21: asm/mca.h: No such file or directory

--- 25/drivers/net/3c509.c~3c509-mca-fix	Wed Oct 29 13:11:02 2003
+++ 25-akpm/drivers/net/3c509.c	Wed Oct 29 13:11:02 2003
@@ -74,7 +74,9 @@ static int max_interrupt_work = 10;
 
 #include <linux/config.h>
 #include <linux/module.h>
+#ifdef CONFIG_MCA
 #include <linux/mca.h>
+#endif
 #include <linux/isapnp.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>

_

