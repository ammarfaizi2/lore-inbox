Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292609AbSBPXUp>; Sat, 16 Feb 2002 18:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292610AbSBPXUg>; Sat, 16 Feb 2002 18:20:36 -0500
Received: from zero.tech9.net ([209.61.188.187]:14853 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292609AbSBPXUZ>;
	Sat, 16 Feb 2002 18:20:25 -0500
Subject: Re: [PATCH] Re: 2.5: further llseek cleanup (3/3)
From: Robert Love <rml@tech9.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <1013900429.855.3.camel@phantasy>
In-Reply-To: <3C6EDDCA.DAB884BD@colorfullife.com> 
	<1013900429.855.3.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 16 Feb 2002 18:20:23 -0500
Message-Id: <1013901624.851.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-16 at 18:00, Robert Love wrote:
> Indeed.  Thank you, Manfred.
> 
> Linus, patch against 2.5.5-pre1 is attached.  Please, apply.

Ugh, another one.  Linus, please apply.

	Robert Love

diff -urN linux-2.5.5-pre1/arch/cris/drivers/eeprom.c linux/arch/cris/drivers/eeprom.c
--- linux-2.5.5-pre1/arch/cris/drivers/eeprom.c	Wed Feb 13 18:18:43 2002
+++ linux/arch/cris/drivers/eeprom.c	Sat Feb 16 18:11:30 2002
@@ -470,17 +470,17 @@
   /* truncate position */
   if (file->f_pos < 0)
   {
-    file->f_pos = 0;    
-    unlock_kernel();
+    file->f_pos = 0;
     ret = -EOVERFLOW;
   }
-  
+
   if (file->f_pos >= eeprom.size)
   {
     file->f_pos = eeprom.size - 1;
     ret = -EOVERFLOW;
   }
 
+  unlock_kernel();
   return ( ret );
 }
 


