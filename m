Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbTFZXRH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 19:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbTFZXRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 19:17:07 -0400
Received: from aneto.able.es ([212.97.163.22]:46997 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262358AbTFZXRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 19:17:05 -0400
Date: Fri, 27 Jun 2003 01:31:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] kill extra printk prototype
Message-ID: <20030626233117.GO3827@werewolf.able.es>
References: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.55L.0306261858460.10651@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Jun 27, 2003 at 00:03:02 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.27, Marcelo Tosatti wrote:
> 
> Hello,
> 
> Here goes -pre2 with a big number of changes, including the new aic7xxx
> driver.
> 
> I wont accept any big changes after -pre4: I want 2.4.22 timecycle to be
> short.
> 

Alredy declared in kernel.h.

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


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
