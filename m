Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbUJ1FSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbUJ1FSX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 01:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262777AbUJ1FSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 01:18:22 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:21720 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S262790AbUJ1FRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 01:17:51 -0400
Date: Wed, 27 Oct 2004 22:17:49 -0700
From: Randolph Chung <randolph@tausq.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch/Makefile] Fix cc-option call for xcompiles
Message-ID: <20041028051749.GH12356@tausq.org>
Reply-To: Randolph Chung <randolph@tausq.org>
References: <20041027231814.GF12356@tausq.org> <Pine.LNX.4.58.0410271813310.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410271813310.28839@ppc970.osdl.org>
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you please make your patches be -p1 based? With CVS, I think just 
> using "cvs diff -u ." should do it.

well, cvs diff is what i use... but ok, i'll make it -p1...

Index: Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/Makefile,v
retrieving revision 1.281
diff -u -p -r1.281 Makefile
--- linux-2.6/Makefile	27 Oct 2004 21:23:19 -0000	1.281
+++ linux-2.6/Makefile	27 Oct 2004 23:16:30 -0000
@@ -494,10 +494,10 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
+include $(srctree)/arch/$(ARCH)/Makefile
+
 # warn about C99 declaration after statement
 CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
-
-include $(srctree)/arch/$(ARCH)/Makefile
 
 # Default kernel image to build when no specific target is given.
 # KBUILD_IMAGE may be overruled on the commandline or
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
