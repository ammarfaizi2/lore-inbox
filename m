Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277285AbRJEB3k>; Thu, 4 Oct 2001 21:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277296AbRJEB3a>; Thu, 4 Oct 2001 21:29:30 -0400
Received: from dot.cygnus.com ([205.180.230.224]:3844 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S277285AbRJEB3S>;
	Thu, 4 Oct 2001 21:29:18 -0400
Date: Thu, 4 Oct 2001 18:29:40 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.11-pre3: misc fixes
Message-ID: <20011004182940.A6318@dot.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Jay Estabrook:

(1) apecs_iounmap prototype wrong.
(2) RTC_IRQ properly defined in arch/alpha/kernel/irq_impl.h.


r~


diff -rup 2.4.10-dist/include/asm-alpha/core_apecs.h 2.4.10/include/asm-alpha/core_apecs.h
--- 2.4.10-dist/include/asm-alpha/core_apecs.h	Thu Sep 13 15:21:32 2001
+++ 2.4.10/include/asm-alpha/core_apecs.h	Thu Oct  4 16:12:05 2001
@@ -502,7 +502,7 @@ __EXTERN_INLINE unsigned long apecs_iore
 	return addr + APECS_DENSE_MEM;
 }
 
-__EXTERN_INLINE void apecs_iounmap(unsigned addr)
+__EXTERN_INLINE void apecs_iounmap(unsigned long addr)
 {
 	return;
 }
diff -rup 2.4.10-dist/include/asm-alpha/mc146818rtc.h 2.4.10/include/asm-alpha/mc146818rtc.h
--- 2.4.10-dist/include/asm-alpha/mc146818rtc.h	Tue Jul 18 23:05:08 2000
+++ 2.4.10/include/asm-alpha/mc146818rtc.h	Thu Oct  4 16:14:53 2001
@@ -24,6 +24,4 @@ outb_p((addr),RTC_PORT(0)); \
 outb_p((val),RTC_PORT(1)); \
 })
 
-#define RTC_IRQ 0		/* Don't support interrupt features.  */
-
 #endif /* __ASM_ALPHA_MC146818RTC_H */
