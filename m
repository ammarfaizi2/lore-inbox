Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274598AbRITSaq>; Thu, 20 Sep 2001 14:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274602AbRITSag>; Thu, 20 Sep 2001 14:30:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274598AbRITSaX>;
	Thu, 20 Sep 2001 14:30:23 -0400
Date: Thu, 20 Sep 2001 11:30:37 -0700 (PDT)
Message-Id: <20010920.113037.59650292.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre12 fails to compile: wakeup_bdflush issues
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BAA2BA8.34873B27@candelatech.com>
In-Reply-To: <3BAA2BA8.34873B27@candelatech.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Thu, 20 Sep 2001 10:47:20 -0700

   I get this error:
   
   sysrq.c:35: conflicting types for 'wakeup_bdflush'
   /root/linux/include/linux/fs.h:1347: previous declaration of 'wakeup_bdflush'
   
   One says it takes a void argument, the other  an int......

The fix is simple:

--- drivers/char/sysrq.c.~1~	Wed Sep 19 14:30:53 2001
+++ drivers/char/sysrq.c	Thu Sep 20 11:29:30 2001
@@ -32,7 +32,6 @@
 
 #include <asm/ptrace.h>
 
-extern void wakeup_bdflush(int);
 extern void reset_vc(unsigned int);
 extern struct list_head super_blocks;
 
