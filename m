Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTJOFc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 01:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTJOFc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 01:32:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:29417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261660AbTJOFc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 01:32:27 -0400
Date: Tue, 14 Oct 2003 22:34:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: eyal@eyal.emu.id.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7: saa7134 breaks on gcc 2.95
Message-Id: <20031014223425.6ee72e10.akpm@osdl.org>
In-Reply-To: <200310150716.58737.ioe-lkml@rameria.de>
References: <3F8C9705.26CA0B63@eyal.emu.id.au>
	<20031014175938.04d94087.akpm@osdl.org>
	<200310150716.58737.ioe-lkml@rameria.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ioe-lkml@rameria.de> wrote:
>
> GCC 2.95 doesn't like no space BEFORE AND AFTER the comma in the argument right
>  before the "## arg".

Yup.

--- 25/drivers/media/video/saa7134/saa7134-core.c~a	Tue Oct 14 22:29:09 2003
+++ 25-akpm/drivers/media/video/saa7134/saa7134-core.c	Tue Oct 14 22:29:25 2003
@@ -95,7 +95,7 @@ struct list_head  saa7134_devlist;
 unsigned int      saa7134_devcount;
 
 #define dprintk(fmt, arg...)	if (core_debug) \
-	printk(KERN_DEBUG "%s/core: " fmt, dev->name, ## arg)
+	printk(KERN_DEBUG "%s/core: " fmt, dev->name , ## arg)
 
 /* ------------------------------------------------------------------ */
 /* debug help functions                                               */

_

