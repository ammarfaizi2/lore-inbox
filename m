Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTKKAVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbTKKAVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:21:10 -0500
Received: from aneto.able.es ([212.97.163.22]:56271 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264169AbTKKAVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:21:07 -0500
Date: Tue, 11 Nov 2003 01:20:53 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031111002053.GA676@werewolf.able.es>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> (from marcelo.tosatti@cyclades.com on Mon, Nov 10, 2003 at 20:28:14 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11.10, Marcelo Tosatti wrote:
> 
> Hi, 
> 
> Here goes -rc1.
> 
> It contains network driver fixes (b44, tg3, 8139cp), several x86-64
> bugfixes, amongst others.
> 
> 
> Please help testing!
> 

Sorry to send this so late, but it is trivial.
This patch kills a redundant (and diferent from include/linux/kernel.h)
prototype for printk.

--- linux/include/asm-i386/spinlock.h.orig    2002-10-15 10:12:25.000000000 +0100
+++ linux/include/asm-i386/spinlock.h 2002-10-15 10:12:35.000000000 +0100
@@ -6,9 +6,6 @@
 #include <asm/page.h>
 #include <linux/config.h>
 
-extern int printk(const char * fmt, ...)
-	__attribute__ ((format (printf, 1, 2)));
-
 /* It seems that people are forgetting to
  * initialize their spinlocks properly, tsk tsk.
  * Remember to turn this off in 2.4. -ben

(it is asmlinkage instead of extern in kernel.h)

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.4.23-pre9-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
