Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129364AbRBIOfZ>; Fri, 9 Feb 2001 09:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129292AbRBIOfQ>; Fri, 9 Feb 2001 09:35:16 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:19986 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S129234AbRBIOfC>; Fri, 9 Feb 2001 09:35:02 -0500
Date: Fri, 9 Feb 2001 14:34:59 +0000 (GMT)
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: ctags
Message-ID: <Pine.LNX.4.21.0102091430110.336-100000@mrworry.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On the system here, ctags is called ctags-exuberant.
Against 2.4.1ac8

thanks
john

--- Makefile.old	Fri Feb  9 14:24:29 2001
+++ Makefile	Fri Feb  9 14:06:08 2001
@@ -33,6 +33,7 @@
 STRIP		= $(CROSS_COMPILE)strip
 OBJCOPY		= $(CROSS_COMPILE)objcopy
 OBJDUMP		= $(CROSS_COMPILE)objdump
+CTAGS		= ctags
 MAKEFILES	= $(TOPDIR)/.config
 GENKSYMS	= /sbin/genksyms
 DEPMOD		= /sbin/depmod
@@ -334,10 +335,10 @@
 
 # Exuberant ctags works better with -I
 tags: dummy
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
-	ctags $$CTAGSF `find include/asm-$(ARCH) -name '*.h'` && \
-	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs ctags $$CTAGSF -a && \
-	find $(SUBDIRS) init -name '*.[ch]' | xargs ctags $$CTAGSF -a
+	CTAGSF=`$(CTAGS) --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
+	$(CTAGS) $$CTAGSF `find include/asm-$(ARCH) -name '*.h'` && \
+	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs $(CTAGS) $$CTAGSF -a && \
+	find $(SUBDIRS) init -name '*.[ch]' | xargs $(CTAGS) $$CTAGSF -a
 
 ifdef CONFIG_MODULES
 ifdef CONFIG_MODVERSIONS


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
