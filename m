Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbRFKP1e>; Mon, 11 Jun 2001 11:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261217AbRFKP1Z>; Mon, 11 Jun 2001 11:27:25 -0400
Received: from diamond.waii.com ([198.3.192.201]:50961 "EHLO diamond.waii.com")
	by vger.kernel.org with ESMTP id <S261289AbRFKP1X>;
	Mon, 11 Jun 2001 11:27:23 -0400
Date: Mon, 11 Jun 2001 10:27:19 -0500 (CDT)
From: Art Haas <arthur.haas@westerngeco.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] #endif warnings cleanup
Message-ID: <Pine.SOL.4.02A.10106111024060.3429-100000@uhura.wg.waii.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a trivial patch that changes ...

#endif BLAH

to

#endif /* BLAH */

gcc-3.0 will flag this. Patch is relative to 2.4.5-ac13.

Thanks to everyone working on the kernel!

Art Haas

==============================================
--- linux-2.4.5-ac13/include/asm-mips/watch.h.orig	Sat May 13 10:31:25 2000
+++ linux-2.4.5-ac13/include/asm-mips/watch.h	Mon Jun 11 10:15:56 2001
@@ -35,4 +35,4 @@
 	if (watch_available)					\
 		__watch_reenable()
 
-#endif __ASM_WATCH_H
+#endif /* __ASM_WATCH_H */
--- linux-2.4.5-ac13/include/asm-m68k/pgtable.h.orig	Mon Nov 27 20:00:49 2000
+++ linux-2.4.5-ac13/include/asm-m68k/pgtable.h	Mon Jun 11 10:15:56 2001
@@ -160,7 +160,7 @@
 #define pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#endif CONFIG_SUN3
+#endif /* CONFIG_SUN3 */
 
 #endif /* !__ASSEMBLY__ */
 
--- linux-2.4.5-ac13/include/asm-m68k/sun3-head.h.orig	Sat Sep  4 15:06:41 1999
+++ linux-2.4.5-ac13/include/asm-m68k/sun3-head.h	Mon Jun 11 10:15:56 2001
@@ -9,4 +9,4 @@
 #define FC_SUPERD    5
 #define FC_CPU      7
 
-#endif __SUN3_HEAD_H
+#endif /* __SUN3_HEAD_H */
--- linux-2.4.5-ac13/include/asm-arm/arch-sa1100/SA-1101.h.orig	Tue Feb 13 16:13:44 2001
+++ linux-2.4.5-ac13/include/asm-arm/arch-sa1100/SA-1101.h	Mon Jun 11 10:25:37 2001
@@ -143,7 +143,7 @@
 #define VMCCR_SDTCTest	    Fld(7,24)	  /* stale data timeout counter */
 #define VMCCR_ForceSelfRef  (1<<31)	  /* Force self refresh */
 
-#endif LANGUAGE == C
+#endif /* LANGUAGE == C */
 
 
 /* Update FIFO
--- linux-2.4.5-ac13/include/asm-ia64/sn/hcl_util.h.orig	Thu Jan  4 15:00:15 2001
+++ linux-2.4.5-ac13/include/asm-ia64/sn/hcl_util.h	Mon Jun 11 10:16:03 2001
@@ -21,4 +21,4 @@
 extern void *device_info_get(devfs_handle_t);
 
 
-#endif _ASM_SN_HCL_UTIL_H
+#endif /* _ASM_SN_HCL_UTIL_H */
--- linux-2.4.5-ac13/include/asm-ia64/sn/synergy.h.orig	Thu Apr 12 14:16:36 2001
+++ linux-2.4.5-ac13/include/asm-ia64/sn/synergy.h	Mon Jun 11 10:16:03 2001
@@ -165,4 +165,4 @@
 
 /* Temporary defintions for testing: */
 
-#endif ASM_IA64_SN_SYNERGY_H
+#endif /* ASM_IA64_SN_SYNERGY_H */
--- linux-2.4.5-ac13/include/asm-mips64/smp.h.orig	Fri Mar  2 13:30:15 2001
+++ linux-2.4.5-ac13/include/asm-mips64/smp.h	Mon Jun 11 10:15:56 2001
@@ -46,4 +46,4 @@
 
 #define NO_PROC_ID	(-1)
 
-#endif __ASM_SMP_H
+#endif /* __ASM_SMP_H */
--- linux-2.4.5-ac13/include/asm-s390/sigp.h.orig	Wed Apr 11 21:02:28 2001
+++ linux-2.4.5-ac13/include/asm-s390/sigp.h	Mon Jun 11 10:15:56 2001
@@ -154,6 +154,6 @@
    return ccode;
 }
 
-#endif __SIGP__
+#endif /* __SIGP__ */
 
 
--- linux-2.4.5-ac13/include/asm-cris/eshlibld.h.orig	Fri Apr  6 12:51:19 2001
+++ linux-2.4.5-ac13/include/asm-cris/eshlibld.h	Mon Jun 11 10:15:56 2001
@@ -109,6 +109,6 @@
 # define shlibmod_fork(x) 1
 #endif /* ! SHARE_LIB_CORE */
 
-#endif _cris_relocate_h
+#endif /* _cris_relocate_h */
 /********************** END OF FILE eshlibld.h *****************************/
 
--- linux-2.4.5-ac13/include/asm-s390x/sigp.h.orig	Wed Apr 11 21:02:29 2001
+++ linux-2.4.5-ac13/include/asm-s390x/sigp.h	Mon Jun 11 10:15:57 2001
@@ -153,6 +153,6 @@
    return ccode;
 }
 
-#endif __SIGP__
+#endif /* __SIGP__ */
 
 
--- linux-2.4.5-ac13/drivers/net/pcmcia/wavelan_cs.c.orig	Wed Apr 25 16:36:23 2001
+++ linux-2.4.5-ac13/drivers/net/pcmcia/wavelan_cs.c	Mon Jun 11 10:16:04 2001
@@ -22,7 +22,7 @@
 #ifdef WAVELAN_ROAMING	
  * Roaming support added 07/22/98 by Justin Seger (jseger@media.mit.edu)
  * based on patch by Joe Finney from Lancaster University.
-#endif :-)
+#endif /* :-) */
  *
  * Lucent (formerly AT&T GIS, formerly NCR) WaveLAN PCMCIA card: An
  * Ethernet-like radio transceiver controlled by an Intel 82593 coprocessor.
--- linux-2.4.5-ac13/drivers/net/myri_code.h.orig	Wed Apr 23 21:01:20 1997
+++ linux-2.4.5-ac13/drivers/net/myri_code.h	Mon Jun 11 10:15:58 2001
@@ -6284,4 +6284,4 @@
 #define MYRI_NetReceiveBadCrcs       0xB8D4
 #define MYRI_NetReceiveBytes         0xB8DC
 
-#endif SYMBOL_DEFINES_COMPILED
+#endif /* SYMBOL_DEFINES_COMPILED */
--- linux-2.4.5-ac13/drivers/char/pcxx.c.orig	Tue May 22 12:23:16 2001
+++ linux-2.4.5-ac13/drivers/char/pcxx.c	Mon Jun 11 10:15:59 2001
@@ -122,7 +122,7 @@
 MODULE_PARM(numports,    "1-4i");
 # endif
 
-#endif MODULE
+#endif /* MODULE */
 
 static int numcards = 1;
 static int nbdevs = 0;
--- linux-2.4.5-ac13/drivers/ide/pdc4030.h.orig	Sat Feb 26 22:32:14 2000
+++ linux-2.4.5-ac13/drivers/ide/pdc4030.h	Mon Jun 11 10:16:02 2001
@@ -41,4 +41,4 @@
 	u8	pad[SECTOR_WORDS*4 - 32];
 };
 
-#endif IDE_PROMISE_H
+#endif /* IDE_PROMISE_H */
--- linux-2.4.5-ac13/drivers/s390/char/tape.c.orig	Wed Apr 11 21:02:28 2001
+++ linux-2.4.5-ac13/drivers/s390/char/tape.c	Mon Jun 11 10:16:06 2001
@@ -637,7 +637,7 @@
 #endif
 #ifdef CONFIG_DEVFS_FS
         tape_devfs_root_entry=devfs_mk_dir (NULL, "tape", NULL);
-#endif CONFIG_DEVFS_FS
+#endif /* CONFIG_DEVFS_FS */
 
 #ifdef TAPE_DEBUG
         debug_text_event (tape_debug_area,3,"dev detect");
@@ -778,7 +778,7 @@
 	}
 #ifdef CONFIG_DEVFS_FS
         devfs_unregister (tape_devfs_root_entry);
-#endif CONFIG_DEVFS_FS
+#endif /* CONFIG_DEVFS_FS */
 #ifdef CONFIG_PROC_FS
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,3,98))
 	remove_proc_entry ("devices", &proc_root);
--- linux-2.4.5-ac13/drivers/s390/net/ctcmain.c.orig	Wed Apr 18 16:40:07 2001
+++ linux-2.4.5-ac13/drivers/s390/net/ctcmain.c	Mon Jun 11 10:16:06 2001
@@ -2819,7 +2819,7 @@
 	proc_net_unregister(ctc_dir.low_ino);
 #endif
 }
-#endif MODULE
+#endif /* MODULE */
 
 /**
  * Create a device specific subdirectory in /proc/net/ctc/ with the
@@ -2875,7 +2875,7 @@
 			privptr->proc_dentry->low_ino);
 #endif
 }
-#endif MODULE
+#endif /* MODULE */
 
 /**
  * Setup related routines
@@ -2992,7 +2992,7 @@
 static param parms_array[MAX_STATIC_DEVICES];
 static param *next_param = parms_array;
 #define alloc_param() ((next_param<parms_array+MAX_STATIC_DEVICES)?next_param++:NULL)
-#endif MODULE
+#endif /* MODULE */
 
 /**
  * Returns commandline parameter using device name as key.
@@ -3059,7 +3059,7 @@
      static int __init ctc_setup(char *setup)
 #    define ctc_setup_return return(1)
 #  endif
-#endif MODULE
+#endif /* MODULE */
 {
 	int write_dev;
 	int read_dev;
@@ -3077,7 +3077,7 @@
 		       "ctc: ctc_setup(): setup='%s' dev_name='%s',"
 		       " ints[0]=%d)\n",
 		       setup, dev_name, ints[0]);
-#endif DEBUG
+#endif /* DEBUG */
 		if (dev_name == NULL) {
 			/**
 			 * happens if device name is not specified in
@@ -3368,7 +3368,7 @@
 }
 
 #define ctc_init init_module
-#endif MODULE
+#endif /* MODULE */
 
 /**
  * Initialize module.
--- linux-2.4.5-ac13/arch/sparc/kernel/ioport.c.orig	Sun Feb 18 21:49:44 2001
+++ linux-2.4.5-ac13/arch/sparc/kernel/ioport.c	Mon Jun 11 10:16:07 2001
@@ -703,7 +703,7 @@
 		}
 	}
 }
-#endif CONFIG_PCI
+#endif /* CONFIG_PCI */
 
 #ifdef CONFIG_PROC_FS
 
@@ -725,7 +725,7 @@
 	return p-buf;
 }
 
-#endif CONFIG_PROC_FS
+#endif /* CONFIG_PROC_FS */
 
 /*
  * This is a version of find_resource and it belongs to kernel/resource.c.
--- linux-2.4.5-ac13/arch/ppc/mm/init.c.orig	Mon Jun 11 07:51:31 2001
+++ linux-2.4.5-ac13/arch/ppc/mm/init.c	Mon Jun 11 10:16:08 2001
@@ -553,7 +553,7 @@
 		flush_hash_segments(0xd, 0xf);
 #else
 		flush_hash_segments(0xc, 0xf);
-#endif CONFIG_PPC64BRIDGE
+#endif /* CONFIG_PPC64BRIDGE */
 		_tlbia();
 		return;
 	}
--- linux-2.4.5-ac13/arch/um/include/kern.h.orig	Mon Jun 11 07:51:31 2001
+++ linux-2.4.5-ac13/arch/um/include/kern.h	Mon Jun 11 10:16:09 2001
@@ -28,7 +28,7 @@
 extern int kill(int pid, int sig);
 extern int getuid(void);
 
-#endif __KERN_H__
+#endif /* __KERN_H__ */
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.

