Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270690AbTGNSZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270706AbTGNSZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:25:39 -0400
Received: from [213.4.129.129] ([213.4.129.129]:46276 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S270690AbTGNSZ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:25:28 -0400
Date: Mon, 14 Jul 2003 20:37:50 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] Remove mtrr version printk
Message-Id: <20030714203750.0598dd36.diegocg@teleline.es>
In-Reply-To: <20030713102543.B24901@infradead.org>
References: <200307131132.46522.arvidjaar@mail.ru>
	<20030713102543.B24901@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 13 Jul 2003 10:25:43 +0100 Christoph Hellwig <hch@infradead.org> escribió:

> Just rip out the whole printk then.  Componentes that are maintained inside
> the kernel tree don't need version numbers.



So I guess this would be right.


diff -puN arch/i386/kernel/cpu/mtrr/main.c~nuke_mtrrver arch/i386/kernel/cpu/mtrr/main.c
--- unsta.moo/arch/i386/kernel/cpu/mtrr/main.c~nuke_mtrrver	2003-07-14 20:29:53.000000000 +0200
+++ unsta.moo-diego/arch/i386/kernel/cpu/mtrr/main.c	2003-07-14 20:34:28.000000000 +0200
@@ -44,8 +44,6 @@
 #include <asm/msr.h>
 #include "mtrr.h"
 
-#define MTRR_VERSION            "2.0 (20020519)"
-
 u32 num_var_ranges = 0;
 
 unsigned int *usage_table;
@@ -677,7 +675,6 @@ static int __init mtrr_init(void)
 			break;
 		}
 	}
-	printk("mtrr: v%s\n",MTRR_VERSION);
 
 	if (mtrr_if) {
 		set_num_var_ranges();

_
