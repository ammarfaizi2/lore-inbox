Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUIFTOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUIFTOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268487AbUIFTOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:14:40 -0400
Received: from nl-ams-slo-l4-01-pip-6.chellonetwork.com ([213.46.243.23]:42591
	"EHLO amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S268479AbUIFTJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:09:30 -0400
Date: Mon, 6 Sep 2004 21:09:27 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] Re: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409062109020.8377@anakin>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
 <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
 <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert all in-kernel users of the deprecated EXPORT_SYMBOL_NOVERS() to
EXPORT_SYMBOL().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.9-rc1/arch/alpha/kernel/alpha_ksyms.c	2004-04-28 15:48:59.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/alpha/kernel/alpha_ksyms.c	2004-09-06 18:20:03.000000000 +0200
@@ -183,8 +183,8 @@
 /*
  * The following are specially called from the uaccess assembly stubs.
  */
-EXPORT_SYMBOL_NOVERS(__copy_user);
-EXPORT_SYMBOL_NOVERS(__do_clear_user);
+EXPORT_SYMBOL(__copy_user);
+EXPORT_SYMBOL(__do_clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);

@@ -243,17 +243,17 @@
  */
 # undef memcpy
 # undef memset
-EXPORT_SYMBOL_NOVERS(__divl);
-EXPORT_SYMBOL_NOVERS(__divlu);
-EXPORT_SYMBOL_NOVERS(__divq);
-EXPORT_SYMBOL_NOVERS(__divqu);
-EXPORT_SYMBOL_NOVERS(__reml);
-EXPORT_SYMBOL_NOVERS(__remlu);
-EXPORT_SYMBOL_NOVERS(__remq);
-EXPORT_SYMBOL_NOVERS(__remqu);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memchr);
+EXPORT_SYMBOL(__divl);
+EXPORT_SYMBOL(__divlu);
+EXPORT_SYMBOL(__divq);
+EXPORT_SYMBOL(__divqu);
+EXPORT_SYMBOL(__reml);
+EXPORT_SYMBOL(__remlu);
+EXPORT_SYMBOL(__remq);
+EXPORT_SYMBOL(__remqu);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memchr);

 EXPORT_SYMBOL(get_wchan);

--- linux-2.6.9-rc1/arch/arm/kernel/armksyms.c	2004-05-24 11:13:17.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/arm/kernel/armksyms.c	2004-09-06 18:20:06.000000000 +0200
@@ -57,7 +57,7 @@
 EXPORT_SYMBOL_ALIAS(fp_printk,printk);
 EXPORT_SYMBOL_ALIAS(fp_send_sig,send_sig);

-EXPORT_SYMBOL_NOVERS(__backtrace);
+EXPORT_SYMBOL(__backtrace);

 	/* platform dependent support */
 EXPORT_SYMBOL(udelay);
@@ -69,43 +69,43 @@

 	/* io */
 #ifndef __raw_readsb
-EXPORT_SYMBOL_NOVERS(__raw_readsb);
+EXPORT_SYMBOL(__raw_readsb);
 #endif
 #ifndef __raw_readsw
-EXPORT_SYMBOL_NOVERS(__raw_readsw);
+EXPORT_SYMBOL(__raw_readsw);
 #endif
 #ifndef __raw_readsl
-EXPORT_SYMBOL_NOVERS(__raw_readsl);
+EXPORT_SYMBOL(__raw_readsl);
 #endif
 #ifndef __raw_writesb
-EXPORT_SYMBOL_NOVERS(__raw_writesb);
+EXPORT_SYMBOL(__raw_writesb);
 #endif
 #ifndef __raw_writesw
-EXPORT_SYMBOL_NOVERS(__raw_writesw);
+EXPORT_SYMBOL(__raw_writesw);
 #endif
 #ifndef __raw_writesl
-EXPORT_SYMBOL_NOVERS(__raw_writesl);
+EXPORT_SYMBOL(__raw_writesl);
 #endif

 	/* string / mem functions */
-EXPORT_SYMBOL_NOVERS(strcpy);
-EXPORT_SYMBOL_NOVERS(strncpy);
-EXPORT_SYMBOL_NOVERS(strcat);
-EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(strcmp);
-EXPORT_SYMBOL_NOVERS(strncmp);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strlen);
-EXPORT_SYMBOL_NOVERS(strnlen);
-EXPORT_SYMBOL_NOVERS(strpbrk);
-EXPORT_SYMBOL_NOVERS(strrchr);
-EXPORT_SYMBOL_NOVERS(strstr);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(__memzero);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strncpy);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strncat);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(strpbrk);
+EXPORT_SYMBOL(strrchr);
+EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(__memzero);

 	/* user mem (segment) */
 EXPORT_SYMBOL(__arch_copy_from_user);
@@ -114,30 +114,30 @@
 EXPORT_SYMBOL(__arch_strnlen_user);
 EXPORT_SYMBOL(__arch_strncpy_from_user);

-EXPORT_SYMBOL_NOVERS(__get_user_1);
-EXPORT_SYMBOL_NOVERS(__get_user_2);
-EXPORT_SYMBOL_NOVERS(__get_user_4);
-EXPORT_SYMBOL_NOVERS(__get_user_8);
-
-EXPORT_SYMBOL_NOVERS(__put_user_1);
-EXPORT_SYMBOL_NOVERS(__put_user_2);
-EXPORT_SYMBOL_NOVERS(__put_user_4);
-EXPORT_SYMBOL_NOVERS(__put_user_8);
+EXPORT_SYMBOL(__get_user_1);
+EXPORT_SYMBOL(__get_user_2);
+EXPORT_SYMBOL(__get_user_4);
+EXPORT_SYMBOL(__get_user_8);
+
+EXPORT_SYMBOL(__put_user_1);
+EXPORT_SYMBOL(__put_user_2);
+EXPORT_SYMBOL(__put_user_4);
+EXPORT_SYMBOL(__put_user_8);

 	/* gcc lib functions */
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-EXPORT_SYMBOL_NOVERS(__divsi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(__modsi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
-EXPORT_SYMBOL_NOVERS(__ucmpdi2);
-EXPORT_SYMBOL_NOVERS(__udivdi3);
-EXPORT_SYMBOL_NOVERS(__umoddi3);
-EXPORT_SYMBOL_NOVERS(__udivmoddi4);
-EXPORT_SYMBOL_NOVERS(__udivsi3);
-EXPORT_SYMBOL_NOVERS(__umodsi3);
-EXPORT_SYMBOL_NOVERS(__do_div64);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__divsi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__modsi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__ucmpdi2);
+EXPORT_SYMBOL(__udivdi3);
+EXPORT_SYMBOL(__umoddi3);
+EXPORT_SYMBOL(__udivmoddi4);
+EXPORT_SYMBOL(__udivsi3);
+EXPORT_SYMBOL(__umodsi3);
+EXPORT_SYMBOL(__do_div64);

 	/* bitops */
 EXPORT_SYMBOL(_set_bit_le);
--- linux-2.6.9-rc1/arch/arm/kernel/semaphore.c	2004-05-24 11:13:17.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/arm/kernel/semaphore.c	2004-09-06 18:20:07.000000000 +0200
@@ -214,7 +214,7 @@
 	ldmfd	sp!, {r0 - r3, pc}		\n\
 	");

-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_interruptible_failed);
-EXPORT_SYMBOL_NOVERS(__down_trylock_failed);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_interruptible_failed);
+EXPORT_SYMBOL(__down_trylock_failed);
+EXPORT_SYMBOL(__up_wakeup);
--- linux-2.6.9-rc1/arch/arm/kernel/traps.c	2004-08-04 12:13:31.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/arm/kernel/traps.c	2004-09-06 18:20:08.000000000 +0200
@@ -562,7 +562,7 @@
 	printk("Division by zero in kernel.\n");
 	dump_stack();
 }
-EXPORT_SYMBOL_NOVERS(__div0);
+EXPORT_SYMBOL(__div0);

 void abort(void)
 {
--- linux-2.6.9-rc1/arch/arm/mm/proc-syms.c	2004-06-09 14:50:35.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/arm/mm/proc-syms.c	2004-09-06 18:20:09.000000000 +0200
@@ -22,10 +22,10 @@
 #endif

 #ifndef MULTI_CACHE
-EXPORT_SYMBOL_NOVERS(__cpuc_flush_kern_all);
-EXPORT_SYMBOL_NOVERS(__cpuc_flush_user_all);
-EXPORT_SYMBOL_NOVERS(__cpuc_flush_user_range);
-EXPORT_SYMBOL_NOVERS(__cpuc_coherent_kern_range);
+EXPORT_SYMBOL(__cpuc_flush_kern_all);
+EXPORT_SYMBOL(__cpuc_flush_user_all);
+EXPORT_SYMBOL(__cpuc_flush_user_range);
+EXPORT_SYMBOL(__cpuc_coherent_kern_range);
 #else
 EXPORT_SYMBOL(cpu_cache);
 #endif
--- linux-2.6.9-rc1/arch/arm26/kernel/armksyms.c	2004-04-28 15:48:59.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/arm26/kernel/armksyms.c	2004-09-06 18:21:09.000000000 +0200
@@ -95,7 +95,7 @@
 EXPORT_SYMBOL(kd_mksound);
 #endif

-EXPORT_SYMBOL_NOVERS(__do_softirq);
+EXPORT_SYMBOL(__do_softirq);

 	/* platform dependent support */
 EXPORT_SYMBOL(dump_thread);
@@ -125,71 +125,71 @@

 	/* io */
 #ifndef __raw_readsb
-EXPORT_SYMBOL_NOVERS(__raw_readsb);
+EXPORT_SYMBOL(__raw_readsb);
 #endif
 #ifndef __raw_readsw
-EXPORT_SYMBOL_NOVERS(__raw_readsw);
+EXPORT_SYMBOL(__raw_readsw);
 #endif
 #ifndef __raw_readsl
-EXPORT_SYMBOL_NOVERS(__raw_readsl);
+EXPORT_SYMBOL(__raw_readsl);
 #endif
 #ifndef __raw_writesb
-EXPORT_SYMBOL_NOVERS(__raw_writesb);
+EXPORT_SYMBOL(__raw_writesb);
 #endif
 #ifndef __raw_writesw
-EXPORT_SYMBOL_NOVERS(__raw_writesw);
+EXPORT_SYMBOL(__raw_writesw);
 #endif
 #ifndef __raw_writesl
-EXPORT_SYMBOL_NOVERS(__raw_writesl);
+EXPORT_SYMBOL(__raw_writesl);
 #endif

 	/* string / mem functions */
-EXPORT_SYMBOL_NOVERS(strcpy);
-EXPORT_SYMBOL_NOVERS(strncpy);
-EXPORT_SYMBOL_NOVERS(strcat);
-EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(strcmp);
-EXPORT_SYMBOL_NOVERS(strncmp);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strlen);
-EXPORT_SYMBOL_NOVERS(strnlen);
-EXPORT_SYMBOL_NOVERS(strpbrk);
-EXPORT_SYMBOL_NOVERS(strrchr);
-EXPORT_SYMBOL_NOVERS(strstr);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(__memzero);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strncpy);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strncat);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(strpbrk);
+EXPORT_SYMBOL(strrchr);
+EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(__memzero);

 	/* user mem (segment) */
 EXPORT_SYMBOL(uaccess_kernel);
 EXPORT_SYMBOL(uaccess_user);

-EXPORT_SYMBOL_NOVERS(__get_user_1);
-EXPORT_SYMBOL_NOVERS(__get_user_2);
-EXPORT_SYMBOL_NOVERS(__get_user_4);
-EXPORT_SYMBOL_NOVERS(__get_user_8);
-
-EXPORT_SYMBOL_NOVERS(__put_user_1);
-EXPORT_SYMBOL_NOVERS(__put_user_2);
-EXPORT_SYMBOL_NOVERS(__put_user_4);
-EXPORT_SYMBOL_NOVERS(__put_user_8);
+EXPORT_SYMBOL(__get_user_1);
+EXPORT_SYMBOL(__get_user_2);
+EXPORT_SYMBOL(__get_user_4);
+EXPORT_SYMBOL(__get_user_8);
+
+EXPORT_SYMBOL(__put_user_1);
+EXPORT_SYMBOL(__put_user_2);
+EXPORT_SYMBOL(__put_user_4);
+EXPORT_SYMBOL(__put_user_8);

 	/* gcc lib functions */
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-EXPORT_SYMBOL_NOVERS(__divsi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(__modsi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
-EXPORT_SYMBOL_NOVERS(__ucmpdi2);
-EXPORT_SYMBOL_NOVERS(__udivdi3);
-EXPORT_SYMBOL_NOVERS(__umoddi3);
-EXPORT_SYMBOL_NOVERS(__udivmoddi4);
-EXPORT_SYMBOL_NOVERS(__udivsi3);
-EXPORT_SYMBOL_NOVERS(__umodsi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__divsi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__modsi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__ucmpdi2);
+EXPORT_SYMBOL(__udivdi3);
+EXPORT_SYMBOL(__umoddi3);
+EXPORT_SYMBOL(__udivmoddi4);
+EXPORT_SYMBOL(__udivsi3);
+EXPORT_SYMBOL(__umodsi3);

 	/* bitops */
 EXPORT_SYMBOL(_set_bit_le);
@@ -214,10 +214,10 @@
 EXPORT_SYMBOL(sys_wait4);

 	/* semaphores */
-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_interruptible_failed);
-EXPORT_SYMBOL_NOVERS(__down_trylock_failed);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_interruptible_failed);
+EXPORT_SYMBOL(__down_trylock_failed);
+EXPORT_SYMBOL(__up_wakeup);

 EXPORT_SYMBOL(get_wchan);

--- linux-2.6.9-rc1/arch/cris/kernel/crisksyms.c	2004-06-09 14:50:36.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/cris/kernel/crisksyms.c	2004-09-06 18:20:27.000000000 +0200
@@ -91,8 +91,8 @@
 #undef memset
 extern void * memset(void *, int, __kernel_size_t);
 extern void * memcpy(void *, const void *, __kernel_size_t);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);

 #ifdef CONFIG_ETRAX_FAST_TIMER
 /* Fast timer functions */
--- linux-2.6.9-rc1/arch/h8300/kernel/h8300_ksyms.c	2004-06-09 14:50:36.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/h8300/kernel/h8300_ksyms.c	2004-09-06 18:21:02.000000000 +0200
@@ -50,13 +50,13 @@
    explicitly (the C compiler generates them).  Fortunately,
    their interface isn't gonna change any time soon now, so
    it's OK to leave it out of version control.  */
-//EXPORT_SYMBOL_NOVERS(__ashrdi3);
-//EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(memmove);
+//EXPORT_SYMBOL(__ashrdi3);
+//EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(memmove);

 EXPORT_SYMBOL(get_wchan);

@@ -85,29 +85,29 @@
 extern void __umodsi3(void);

         /* gcc lib functions */
-EXPORT_SYMBOL_NOVERS(__gcc_bcmp);
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-EXPORT_SYMBOL_NOVERS(__cmpdi2);
-EXPORT_SYMBOL_NOVERS(__divdi3);
-EXPORT_SYMBOL_NOVERS(__divsi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(__moddi3);
-EXPORT_SYMBOL_NOVERS(__modsi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
-EXPORT_SYMBOL_NOVERS(__mulsi3);
-EXPORT_SYMBOL_NOVERS(__negdi2);
-EXPORT_SYMBOL_NOVERS(__ucmpdi2);
-EXPORT_SYMBOL_NOVERS(__udivdi3);
-EXPORT_SYMBOL_NOVERS(__udivmoddi4);
-EXPORT_SYMBOL_NOVERS(__udivsi3);
-EXPORT_SYMBOL_NOVERS(__umoddi3);
-EXPORT_SYMBOL_NOVERS(__umodsi3);
+EXPORT_SYMBOL(__gcc_bcmp);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__cmpdi2);
+EXPORT_SYMBOL(__divdi3);
+EXPORT_SYMBOL(__divsi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__moddi3);
+EXPORT_SYMBOL(__modsi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__mulsi3);
+EXPORT_SYMBOL(__negdi2);
+EXPORT_SYMBOL(__ucmpdi2);
+EXPORT_SYMBOL(__udivdi3);
+EXPORT_SYMBOL(__udivmoddi4);
+EXPORT_SYMBOL(__udivsi3);
+EXPORT_SYMBOL(__umoddi3);
+EXPORT_SYMBOL(__umodsi3);

 #ifdef MAGIC_ROM_PTR
-EXPORT_SYMBOL_NOVERS(is_in_rom);
+EXPORT_SYMBOL(is_in_rom);
 #endif

-EXPORT_SYMBOL_NOVERS(h8300_reserved_gpio);
-EXPORT_SYMBOL_NOVERS(h8300_free_gpio);
-EXPORT_SYMBOL_NOVERS(h8300_set_gpio_dir);
+EXPORT_SYMBOL(h8300_reserved_gpio);
+EXPORT_SYMBOL(h8300_free_gpio);
+EXPORT_SYMBOL(h8300_set_gpio_dir);
--- linux-2.6.9-rc1/arch/i386/kernel/i386_ksyms.c	2004-07-12 09:47:50.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/i386/kernel/i386_ksyms.c	2004-09-06 18:20:00.000000000 +0200
@@ -87,10 +87,10 @@
 EXPORT_SYMBOL(cpu_khz);
 EXPORT_SYMBOL(apm_info);

-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_failed_interruptible);
+EXPORT_SYMBOL(__down_failed_trylock);
+EXPORT_SYMBOL(__up_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_generic);
 /* Delay loops */
@@ -99,9 +99,9 @@
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);

-EXPORT_SYMBOL_NOVERS(__get_user_1);
-EXPORT_SYMBOL_NOVERS(__get_user_2);
-EXPORT_SYMBOL_NOVERS(__get_user_4);
+EXPORT_SYMBOL(__get_user_1);
+EXPORT_SYMBOL(__get_user_2);
+EXPORT_SYMBOL(__get_user_4);

 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
@@ -142,8 +142,8 @@
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_callout_map);
-EXPORT_SYMBOL_NOVERS(__write_lock_failed);
-EXPORT_SYMBOL_NOVERS(__read_lock_failed);
+EXPORT_SYMBOL(__write_lock_failed);
+EXPORT_SYMBOL(__read_lock_failed);

 /* Global SMP stuff */
 EXPORT_SYMBOL(synchronize_irq);
@@ -175,7 +175,7 @@

 #undef memcmp
 extern int memcmp(const void *,const void *,__kernel_size_t);
-EXPORT_SYMBOL_NOVERS(memcmp);
+EXPORT_SYMBOL(memcmp);

 #ifdef CONFIG_HAVE_DEC_LOCK
 EXPORT_SYMBOL(atomic_dec_and_lock);
--- linux-2.6.9-rc1/arch/i386/lib/memcpy.c	2004-07-12 09:47:50.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/i386/lib/memcpy.c	2004-09-06 18:19:45.000000000 +0200
@@ -13,13 +13,13 @@
 	return __memcpy(to, from, n);
 #endif
 }
-EXPORT_SYMBOL_NOVERS(memcpy);
+EXPORT_SYMBOL(memcpy);

 void *memset(void *s, int c, size_t count)
 {
 	return __memset(s, c, count);
 }
-EXPORT_SYMBOL_NOVERS(memset);
+EXPORT_SYMBOL(memset);

 void *memmove(void *dest, const void *src, size_t n)
 {
@@ -41,4 +41,4 @@
 	}
 	return dest;
 }
-EXPORT_SYMBOL_NOVERS(memmove);
+EXPORT_SYMBOL(memmove);
--- linux-2.6.9-rc1/arch/m68k/kernel/m68k_ksyms.c	2004-04-27 20:42:51.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/m68k/kernel/m68k_ksyms.c	2004-09-06 18:20:05.000000000 +0200
@@ -72,18 +72,18 @@
    explicitly (the C compiler generates them).  Fortunately,
    their interface isn't gonna change any time soon now, so
    it's OK to leave it out of version control.  */
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(__muldi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(__muldi3);

-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_failed_interruptible);
+EXPORT_SYMBOL(__down_failed_trylock);
+EXPORT_SYMBOL(__up_wakeup);

 EXPORT_SYMBOL(get_wchan);
--- linux-2.6.9-rc1/arch/m68knommu/kernel/m68k_ksyms.c	2004-04-30 15:34:48.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/m68knommu/kernel/m68k_ksyms.c	2004-09-06 18:20:59.000000000 +0200
@@ -50,16 +50,16 @@
    explicitly (the C compiler generates them).  Fortunately,
    their interface isn't gonna change any time soon now, so
    it's OK to leave it out of version control.  */
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(memmove);
-
-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(memmove);
+
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_failed_interruptible);
+EXPORT_SYMBOL(__down_failed_trylock);
+EXPORT_SYMBOL(__up_wakeup);

 EXPORT_SYMBOL(get_wchan);

@@ -79,27 +79,27 @@
 extern void __umodsi3(void);

         /* gcc lib functions */
-EXPORT_SYMBOL_NOVERS(__ashldi3);
-EXPORT_SYMBOL_NOVERS(__ashrdi3);
-EXPORT_SYMBOL_NOVERS(__divsi3);
-EXPORT_SYMBOL_NOVERS(__lshrdi3);
-EXPORT_SYMBOL_NOVERS(__modsi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
-EXPORT_SYMBOL_NOVERS(__mulsi3);
-EXPORT_SYMBOL_NOVERS(__udivsi3);
-EXPORT_SYMBOL_NOVERS(__umodsi3);
+EXPORT_SYMBOL(__ashldi3);
+EXPORT_SYMBOL(__ashrdi3);
+EXPORT_SYMBOL(__divsi3);
+EXPORT_SYMBOL(__lshrdi3);
+EXPORT_SYMBOL(__modsi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__mulsi3);
+EXPORT_SYMBOL(__udivsi3);
+EXPORT_SYMBOL(__umodsi3);

-EXPORT_SYMBOL_NOVERS(is_in_rom);
+EXPORT_SYMBOL(is_in_rom);

 #ifdef CONFIG_COLDFIRE
 extern unsigned int *dma_device_address;
 extern unsigned long dma_base_addr, _ramend;
-EXPORT_SYMBOL_NOVERS(dma_base_addr);
-EXPORT_SYMBOL_NOVERS(dma_device_address);
-EXPORT_SYMBOL_NOVERS(_ramend);
+EXPORT_SYMBOL(dma_base_addr);
+EXPORT_SYMBOL(dma_device_address);
+EXPORT_SYMBOL(_ramend);

 extern asmlinkage void trap(void);
 extern void	*_ramvec;
-EXPORT_SYMBOL_NOVERS(trap);
-EXPORT_SYMBOL_NOVERS(_ramvec);
+EXPORT_SYMBOL(trap);
+EXPORT_SYMBOL(_ramvec);
 #endif /* CONFIG_COLDFIRE */
--- linux-2.6.9-rc1/arch/mips/kernel/mips_ksyms.c	2004-05-24 11:13:23.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/mips/kernel/mips_ksyms.c	2004-09-06 18:20:04.000000000 +0200
@@ -26,36 +26,36 @@
 /*
  * String functions
  */
-EXPORT_SYMBOL_NOVERS(memchr);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(strcat);
-EXPORT_SYMBOL_NOVERS(strchr);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strchr);
 #ifdef CONFIG_MIPS64
-EXPORT_SYMBOL_NOVERS(strncmp);
+EXPORT_SYMBOL(strncmp);
 #endif
-EXPORT_SYMBOL_NOVERS(strlen);
-EXPORT_SYMBOL_NOVERS(strpbrk);
-EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(strnlen);
-EXPORT_SYMBOL_NOVERS(strrchr);
-EXPORT_SYMBOL_NOVERS(strstr);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(strpbrk);
+EXPORT_SYMBOL(strncat);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(strrchr);
+EXPORT_SYMBOL(strstr);

 EXPORT_SYMBOL(kernel_thread);

 /*
  * Userspace access stuff.
  */
-EXPORT_SYMBOL_NOVERS(__copy_user);
-EXPORT_SYMBOL_NOVERS(__bzero);
-EXPORT_SYMBOL_NOVERS(__strncpy_from_user_nocheck_asm);
-EXPORT_SYMBOL_NOVERS(__strncpy_from_user_asm);
-EXPORT_SYMBOL_NOVERS(__strlen_user_nocheck_asm);
-EXPORT_SYMBOL_NOVERS(__strlen_user_asm);
-EXPORT_SYMBOL_NOVERS(__strnlen_user_nocheck_asm);
-EXPORT_SYMBOL_NOVERS(__strnlen_user_asm);
+EXPORT_SYMBOL(__copy_user);
+EXPORT_SYMBOL(__bzero);
+EXPORT_SYMBOL(__strncpy_from_user_nocheck_asm);
+EXPORT_SYMBOL(__strncpy_from_user_asm);
+EXPORT_SYMBOL(__strlen_user_nocheck_asm);
+EXPORT_SYMBOL(__strlen_user_asm);
+EXPORT_SYMBOL(__strnlen_user_nocheck_asm);
+EXPORT_SYMBOL(__strnlen_user_asm);

 EXPORT_SYMBOL(csum_partial);

--- linux-2.6.9-rc1/arch/ppc64/kernel/ppc_ksyms.c	2004-07-12 09:47:55.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/ppc64/kernel/ppc_ksyms.c	2004-09-06 18:20:28.000000000 +0200
@@ -148,12 +148,12 @@
 EXPORT_SYMBOL(get_property);
 #endif

-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memchr);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memchr);

 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
--- linux-2.6.9-rc1/arch/s390/kernel/ebcdic.c	2004-04-27 16:25:12.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/s390/kernel/ebcdic.c	2004-09-06 18:20:24.000000000 +0200
@@ -391,10 +391,10 @@
 	0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF
 };

-EXPORT_SYMBOL_NOVERS(_ascebc_500);
-EXPORT_SYMBOL_NOVERS(_ebcasc_500);
-EXPORT_SYMBOL_NOVERS(_ascebc);
-EXPORT_SYMBOL_NOVERS(_ebcasc);
-EXPORT_SYMBOL_NOVERS(_ebc_tolower);
-EXPORT_SYMBOL_NOVERS(_ebc_toupper);
+EXPORT_SYMBOL(_ascebc_500);
+EXPORT_SYMBOL(_ebcasc_500);
+EXPORT_SYMBOL(_ascebc);
+EXPORT_SYMBOL(_ebcasc);
+EXPORT_SYMBOL(_ebc_tolower);
+EXPORT_SYMBOL(_ebc_toupper);

--- linux-2.6.9-rc1/arch/s390/kernel/s390_ksyms.c	2004-07-12 09:47:56.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/s390/kernel/s390_ksyms.c	2004-09-06 18:20:25.000000000 +0200
@@ -23,15 +23,15 @@
 /*
  * memory management
  */
-EXPORT_SYMBOL_NOVERS(_oi_bitmap);
-EXPORT_SYMBOL_NOVERS(_ni_bitmap);
-EXPORT_SYMBOL_NOVERS(_zb_findmap);
-EXPORT_SYMBOL_NOVERS(_sb_findmap);
-EXPORT_SYMBOL_NOVERS(__copy_from_user_asm);
-EXPORT_SYMBOL_NOVERS(__copy_to_user_asm);
-EXPORT_SYMBOL_NOVERS(__clear_user_asm);
-EXPORT_SYMBOL_NOVERS(__strncpy_from_user_asm);
-EXPORT_SYMBOL_NOVERS(__strnlen_user_asm);
+EXPORT_SYMBOL(_oi_bitmap);
+EXPORT_SYMBOL(_ni_bitmap);
+EXPORT_SYMBOL(_zb_findmap);
+EXPORT_SYMBOL(_sb_findmap);
+EXPORT_SYMBOL(__copy_from_user_asm);
+EXPORT_SYMBOL(__copy_to_user_asm);
+EXPORT_SYMBOL(__clear_user_asm);
+EXPORT_SYMBOL(__strncpy_from_user_asm);
+EXPORT_SYMBOL(__strnlen_user_asm);
 EXPORT_SYMBOL(diag10);

 /*
@@ -60,6 +60,6 @@
 EXPORT_SYMBOL(console_mode);
 EXPORT_SYMBOL(console_devno);
 EXPORT_SYMBOL(console_irq);
-EXPORT_SYMBOL_NOVERS(do_call_softirq);
+EXPORT_SYMBOL(do_call_softirq);
 EXPORT_SYMBOL(sys_wait4);
 EXPORT_SYMBOL(cpcmd);
--- linux-2.6.9-rc1/arch/s390/lib/string.c	2004-08-04 12:13:40.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/s390/lib/string.c	2004-09-06 18:20:26.000000000 +0200
@@ -46,7 +46,7 @@
 {
 	return __strend(s) - s;
 }
-EXPORT_SYMBOL_NOVERS(strlen);
+EXPORT_SYMBOL(strlen);

 /**
  * strnlen - Find the length of a length-limited string
@@ -59,7 +59,7 @@
 {
 	return __strnend(s, n) - s;
 }
-EXPORT_SYMBOL_NOVERS(strnlen);
+EXPORT_SYMBOL(strnlen);

 /**
  * strcpy - Copy a %NUL terminated string
@@ -79,7 +79,7 @@
 		      : "cc", "memory" );
 	return ret;
 }
-EXPORT_SYMBOL_NOVERS(strcpy);
+EXPORT_SYMBOL(strcpy);

 /**
  * strlcpy - Copy a %NUL terminated string into a sized buffer
@@ -103,7 +103,7 @@
 	}
 	return ret;
 }
-EXPORT_SYMBOL_NOVERS(strlcpy);
+EXPORT_SYMBOL(strlcpy);

 /**
  * strncpy - Copy a length-limited, %NUL-terminated string
@@ -121,7 +121,7 @@
 	__builtin_memcpy(dest, src, len);
 	return dest;
 }
-EXPORT_SYMBOL_NOVERS(strncpy);
+EXPORT_SYMBOL(strncpy);

 /**
  * strcat - Append one %NUL-terminated string to another
@@ -144,7 +144,7 @@
 		      : "d" (r0), "0" (0UL) : "cc", "memory" );
 	return ret;
 }
-EXPORT_SYMBOL_NOVERS(strcat);
+EXPORT_SYMBOL(strcat);

 /**
  * strlcat - Append a length-limited, %NUL-terminated string to another
@@ -168,7 +168,7 @@
 	}
 	return res;
 }
-EXPORT_SYMBOL_NOVERS(strlcat);
+EXPORT_SYMBOL(strlcat);

 /**
  * strncat - Append a length-limited, %NUL-terminated string to another
@@ -190,7 +190,7 @@
 	__builtin_memcpy(p, src, len);
 	return dest;
 }
-EXPORT_SYMBOL_NOVERS(strncat);
+EXPORT_SYMBOL(strncat);

 /**
  * strcmp - Compare two strings
@@ -217,7 +217,7 @@
 		      : : "cc" );
 	return ret;
 }
-EXPORT_SYMBOL_NOVERS(strcmp);
+EXPORT_SYMBOL(strcmp);

 /**
  * strrchr - Find the last occurrence of a character in a string
@@ -235,7 +235,7 @@
 	       } while (--len > 0);
        return 0;
 }
-EXPORT_SYMBOL_NOVERS(strrchr);
+EXPORT_SYMBOL(strrchr);

 /**
  * strstr - Find the first substring in a %NUL terminated string
@@ -269,7 +269,7 @@
 	}
 	return 0;
 }
-EXPORT_SYMBOL_NOVERS(strstr);
+EXPORT_SYMBOL(strstr);

 /**
  * memchr - Find a character in an area of memory.
@@ -293,7 +293,7 @@
 		      : "+a" (ret), "+&a" (s) : "d" (r0) : "cc" );
 	return (void *) ret;
 }
-EXPORT_SYMBOL_NOVERS(memchr);
+EXPORT_SYMBOL(memchr);

 /**
  * memcmp - Compare two areas of memory
@@ -319,7 +319,7 @@
 		ret = *(char *) r2 - *(char *) r4;
 	return ret;
 }
-EXPORT_SYMBOL_NOVERS(memcmp);
+EXPORT_SYMBOL(memcmp);

 /**
  * memscan - Find a character in an area of memory.
@@ -340,7 +340,7 @@
 		      : "+a" (ret), "+&a" (s) : "d" (r0) : "cc" );
 	return (void *) ret;
 }
-EXPORT_SYMBOL_NOVERS(memscan);
+EXPORT_SYMBOL(memscan);

 /**
  * memcpy - Copy one area of memory to another
@@ -354,7 +354,7 @@
 {
 	return __builtin_memcpy(dest, src, n);
 }
-EXPORT_SYMBOL_NOVERS(memcpy);
+EXPORT_SYMBOL(memcpy);

 /**
  * bcopy - Copy one area of memory to another
@@ -369,7 +369,7 @@
 {
 	__builtin_memcpy(destp, srcp, n);
 }
-EXPORT_SYMBOL_NOVERS(bcopy);
+EXPORT_SYMBOL(bcopy);

 /**
  * memset - Fill a region of memory with the given value
@@ -393,4 +393,4 @@
 		} while (--n > 0);
 	return s;
 }
-EXPORT_SYMBOL_NOVERS(memset);
+EXPORT_SYMBOL(memset);
--- linux-2.6.9-rc1/arch/sh/kernel/sh_ksyms.c	2004-07-12 09:47:56.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/sh/kernel/sh_ksyms.c	2004-09-06 18:20:18.000000000 +0200
@@ -87,7 +87,7 @@
 EXPORT_SYMBOL(__ndelay);
 EXPORT_SYMBOL(__const_udelay);

-#define DECLARE_EXPORT(name) extern void name(void);EXPORT_SYMBOL_NOVERS(name)
+#define DECLARE_EXPORT(name) extern void name(void);EXPORT_SYMBOL(name)

 /* These symbols are generated by the compiler itself */
 DECLARE_EXPORT(__udivsi3);
--- linux-2.6.9-rc1/arch/sh64/kernel/sh_ksyms.c	2004-07-12 09:47:56.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/sh64/kernel/sh_ksyms.c	2004-09-06 18:21:10.000000000 +0200
@@ -59,17 +59,17 @@
 EXPORT_SYMBOL(screen_info);
 #endif

-EXPORT_SYMBOL_NOVERS(__down);
-EXPORT_SYMBOL_NOVERS(__down_trylock);
-EXPORT_SYMBOL_NOVERS(__up);
-EXPORT_SYMBOL_NOVERS(__put_user_asm_l);
-EXPORT_SYMBOL_NOVERS(__get_user_asm_l);
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strlen);
+EXPORT_SYMBOL(__down);
+EXPORT_SYMBOL(__down_trylock);
+EXPORT_SYMBOL(__up);
+EXPORT_SYMBOL(__put_user_asm_l);
+EXPORT_SYMBOL(__get_user_asm_l);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strlen);

 EXPORT_SYMBOL(flush_dcache_page);

@@ -78,7 +78,7 @@
 extern void __sdivsi3(void);
 extern void __muldi3(void);
 extern void __udivsi3(void);
-EXPORT_SYMBOL_NOVERS(__sdivsi3);
-EXPORT_SYMBOL_NOVERS(__muldi3);
-EXPORT_SYMBOL_NOVERS(__udivsi3);
+EXPORT_SYMBOL(__sdivsi3);
+EXPORT_SYMBOL(__muldi3);
+EXPORT_SYMBOL(__udivsi3);

--- linux-2.6.9-rc1/arch/sparc64/kernel/sparc64_ksyms.c	2004-08-24 13:33:34.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/sparc64/kernel/sparc64_ksyms.c	2004-09-06 18:20:05.000000000 +0200
@@ -142,7 +142,7 @@

 #if defined(CONFIG_MCOUNT)
 extern void _mcount(void);
-EXPORT_SYMBOL_NOVERS(_mcount);
+EXPORT_SYMBOL(_mcount);
 #endif

 /* CPU online map and active count.  */
@@ -363,18 +363,18 @@
 /* No version information on this, heavily used in inline asm,
  * and will always be 'void __ret_efault(void)'.
  */
-EXPORT_SYMBOL_NOVERS(__ret_efault);
+EXPORT_SYMBOL(__ret_efault);

 /* No version information on these, as gcc produces such symbols. */
-EXPORT_SYMBOL_NOVERS(memcmp);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(strncmp);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(strncmp);

 void VISenter(void);
 /* RAID code needs this */
-EXPORT_SYMBOL_NOVERS(VISenter);
+EXPORT_SYMBOL(VISenter);

 /* for input/keybdev */
 EXPORT_SYMBOL(sun_do_break);
--- linux-2.6.9-rc1/arch/um/kernel/ksyms.c	2004-04-27 20:36:40.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/um/kernel/ksyms.c	2004-09-06 18:20:29.000000000 +0200
@@ -75,10 +75,10 @@
 /* required for SMP */

 extern void FASTCALL( __write_lock_failed(rwlock_t *rw));
-EXPORT_SYMBOL_NOVERS(__write_lock_failed);
+EXPORT_SYMBOL(__write_lock_failed);

 extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
-EXPORT_SYMBOL_NOVERS(__read_lock_failed);
+EXPORT_SYMBOL(__read_lock_failed);

 #endif

--- linux-2.6.9-rc1/arch/v850/kernel/v850_ksyms.c	2004-04-28 10:58:42.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/v850/kernel/v850_ksyms.c	2004-09-06 18:21:00.000000000 +0200
@@ -37,29 +37,29 @@
 EXPORT_SYMBOL (ip_fast_csum);

 /* string / mem functions */
-EXPORT_SYMBOL_NOVERS (strcpy);
-EXPORT_SYMBOL_NOVERS (strncpy);
-EXPORT_SYMBOL_NOVERS (strcat);
-EXPORT_SYMBOL_NOVERS (strncat);
-EXPORT_SYMBOL_NOVERS (strcmp);
-EXPORT_SYMBOL_NOVERS (strncmp);
-EXPORT_SYMBOL_NOVERS (strchr);
-EXPORT_SYMBOL_NOVERS (strlen);
-EXPORT_SYMBOL_NOVERS (strnlen);
-EXPORT_SYMBOL_NOVERS (strpbrk);
-EXPORT_SYMBOL_NOVERS (strrchr);
-EXPORT_SYMBOL_NOVERS (strstr);
-EXPORT_SYMBOL_NOVERS (memset);
-EXPORT_SYMBOL_NOVERS (memcpy);
-EXPORT_SYMBOL_NOVERS (memmove);
-EXPORT_SYMBOL_NOVERS (memcmp);
-EXPORT_SYMBOL_NOVERS (memscan);
+EXPORT_SYMBOL (strcpy);
+EXPORT_SYMBOL (strncpy);
+EXPORT_SYMBOL (strcat);
+EXPORT_SYMBOL (strncat);
+EXPORT_SYMBOL (strcmp);
+EXPORT_SYMBOL (strncmp);
+EXPORT_SYMBOL (strchr);
+EXPORT_SYMBOL (strlen);
+EXPORT_SYMBOL (strnlen);
+EXPORT_SYMBOL (strpbrk);
+EXPORT_SYMBOL (strrchr);
+EXPORT_SYMBOL (strstr);
+EXPORT_SYMBOL (memset);
+EXPORT_SYMBOL (memcpy);
+EXPORT_SYMBOL (memmove);
+EXPORT_SYMBOL (memcmp);
+EXPORT_SYMBOL (memscan);

 /* semaphores */
-EXPORT_SYMBOL_NOVERS (__down);
-EXPORT_SYMBOL_NOVERS (__down_interruptible);
-EXPORT_SYMBOL_NOVERS (__down_trylock);
-EXPORT_SYMBOL_NOVERS (__up);
+EXPORT_SYMBOL (__down);
+EXPORT_SYMBOL (__down_interruptible);
+EXPORT_SYMBOL (__down_trylock);
+EXPORT_SYMBOL (__up);

 /*
  * libgcc functions - functions that are used internally by the
@@ -72,8 +72,8 @@
 extern void __muldi3 (void);
 extern void __negdi2 (void);

-EXPORT_SYMBOL_NOVERS (__ashldi3);
-EXPORT_SYMBOL_NOVERS (__ashrdi3);
-EXPORT_SYMBOL_NOVERS (__lshrdi3);
-EXPORT_SYMBOL_NOVERS (__muldi3);
-EXPORT_SYMBOL_NOVERS (__negdi2);
+EXPORT_SYMBOL (__ashldi3);
+EXPORT_SYMBOL (__ashrdi3);
+EXPORT_SYMBOL (__lshrdi3);
+EXPORT_SYMBOL (__muldi3);
+EXPORT_SYMBOL (__negdi2);
--- linux-2.6.9-rc1/arch/x86_64/kernel/x8664_ksyms.c	2004-07-12 09:47:57.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/arch/x86_64/kernel/x8664_ksyms.c	2004-09-06 18:20:28.000000000 +0200
@@ -63,10 +63,10 @@
 EXPORT_SYMBOL(pm_power_off);
 EXPORT_SYMBOL(get_cmos_time);

-EXPORT_SYMBOL_NOVERS(__down_failed);
-EXPORT_SYMBOL_NOVERS(__down_failed_interruptible);
-EXPORT_SYMBOL_NOVERS(__down_failed_trylock);
-EXPORT_SYMBOL_NOVERS(__up_wakeup);
+EXPORT_SYMBOL(__down_failed);
+EXPORT_SYMBOL(__down_failed_interruptible);
+EXPORT_SYMBOL(__down_failed_trylock);
+EXPORT_SYMBOL(__up_wakeup);
 /* Networking helper routines. */
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(ip_compute_csum);
@@ -76,14 +76,14 @@
 EXPORT_SYMBOL(__delay);
 EXPORT_SYMBOL(__const_udelay);

-EXPORT_SYMBOL_NOVERS(__get_user_1);
-EXPORT_SYMBOL_NOVERS(__get_user_2);
-EXPORT_SYMBOL_NOVERS(__get_user_4);
-EXPORT_SYMBOL_NOVERS(__get_user_8);
-EXPORT_SYMBOL_NOVERS(__put_user_1);
-EXPORT_SYMBOL_NOVERS(__put_user_2);
-EXPORT_SYMBOL_NOVERS(__put_user_4);
-EXPORT_SYMBOL_NOVERS(__put_user_8);
+EXPORT_SYMBOL(__get_user_1);
+EXPORT_SYMBOL(__get_user_2);
+EXPORT_SYMBOL(__get_user_4);
+EXPORT_SYMBOL(__get_user_8);
+EXPORT_SYMBOL(__put_user_1);
+EXPORT_SYMBOL(__put_user_2);
+EXPORT_SYMBOL(__put_user_4);
+EXPORT_SYMBOL(__put_user_8);

 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
@@ -118,8 +118,8 @@
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(cpu_online_map);
-EXPORT_SYMBOL_NOVERS(__write_lock_failed);
-EXPORT_SYMBOL_NOVERS(__read_lock_failed);
+EXPORT_SYMBOL(__write_lock_failed);
+EXPORT_SYMBOL(__read_lock_failed);

 EXPORT_SYMBOL(synchronize_irq);
 EXPORT_SYMBOL(smp_call_function);
@@ -164,23 +164,23 @@
 extern char * strcat(char *, const char *);
 extern int memcmp(const void * cs,const void * ct,size_t count);

-EXPORT_SYMBOL_NOVERS(memset);
-EXPORT_SYMBOL_NOVERS(strlen);
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(strcpy);
-EXPORT_SYMBOL_NOVERS(strncmp);
-EXPORT_SYMBOL_NOVERS(strncpy);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strcmp);
-EXPORT_SYMBOL_NOVERS(strcat);
-EXPORT_SYMBOL_NOVERS(strncat);
-EXPORT_SYMBOL_NOVERS(memchr);
-EXPORT_SYMBOL_NOVERS(strrchr);
-EXPORT_SYMBOL_NOVERS(strnlen);
-EXPORT_SYMBOL_NOVERS(memscan);
-EXPORT_SYMBOL_NOVERS(memcpy);
-EXPORT_SYMBOL_NOVERS(__memcpy);
-EXPORT_SYMBOL_NOVERS(memcmp);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(strncpy);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strncat);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(strrchr);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(memscan);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(__memcpy);
+EXPORT_SYMBOL(memcmp);

 /* syscall export needed for misdesigned sound drivers. */
 EXPORT_SYMBOL(sys_read);
@@ -201,7 +201,7 @@
 #endif

 extern void do_softirq_thunk(void);
-EXPORT_SYMBOL_NOVERS(do_softirq_thunk);
+EXPORT_SYMBOL(do_softirq_thunk);

 void out_of_line_bug(void);
 EXPORT_SYMBOL(out_of_line_bug);
--- linux-2.6.9-rc1/drivers/isdn/hardware/eicon/diva_didd.c	2004-04-28 11:03:47.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/drivers/isdn/hardware/eicon/diva_didd.c	2004-09-06 18:21:12.000000000 +0200
@@ -50,8 +50,8 @@
 static struct proc_dir_entry *proc_didd;
 struct proc_dir_entry *proc_net_eicon = NULL;

-EXPORT_SYMBOL_NOVERS(DIVA_DIDD_Read);
-EXPORT_SYMBOL_NOVERS(proc_net_eicon);
+EXPORT_SYMBOL(DIVA_DIDD_Read);
+EXPORT_SYMBOL(proc_net_eicon);

 static char *getrev(const char *revision)
 {
--- linux-2.6.9-rc1/drivers/usb/media/pwc-uncompress.c	2004-07-12 09:48:15.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/drivers/usb/media/pwc-uncompress.c	2004-09-06 18:21:13.000000000 +0200
@@ -175,6 +175,6 @@
    both when this code is compiled into the kernel or as as module.
  */

-EXPORT_SYMBOL_NOVERS(pwc_decompressor_version);
+EXPORT_SYMBOL(pwc_decompressor_version);
 EXPORT_SYMBOL(pwc_register_decompressor);
 EXPORT_SYMBOL(pwc_unregister_decompressor);
--- linux-2.6.9-rc1/lib/rwsem.c	2004-07-12 09:48:35.000000000 +0200
+++ linux-2.6.9-rc1-export-symbol/lib/rwsem.c	2004-09-06 18:21:27.000000000 +0200
@@ -255,10 +255,10 @@
 	return sem;
 }

-EXPORT_SYMBOL_NOVERS(rwsem_down_read_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_down_write_failed);
-EXPORT_SYMBOL_NOVERS(rwsem_wake);
-EXPORT_SYMBOL_NOVERS(rwsem_downgrade_wake);
+EXPORT_SYMBOL(rwsem_down_read_failed);
+EXPORT_SYMBOL(rwsem_down_write_failed);
+EXPORT_SYMBOL(rwsem_wake);
+EXPORT_SYMBOL(rwsem_downgrade_wake);
 #if RWSEM_DEBUG
 EXPORT_SYMBOL(rwsemtrace);
 #endif

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
