Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUHPOwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUHPOwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 10:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUHPOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 10:52:45 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:14914 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265805AbUHPOwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 10:52:41 -0400
Date: Mon, 16 Aug 2004 16:55:19 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: kbuild/ia64: Fix breakage in arch/ia64/kernel/Makefile
Message-ID: <20040816145519.GA7629@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040815201224.GI7682@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815201224.GI7682@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown paperbag time :-(
The *.lds changes that I added to ia64 introduced an error.
Fix it so ia64 build againg.

Pushed to bk://linux-sam.bkbits.net/kbuild

	Sam
	
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/16 16:51:51+02:00 sam@mars.ravnborg.org 
#   kbuild/ia64: Fix breakage in arch/ia64/kernel/Makefile
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# arch/ia64/kernel/Makefile
#   2004/08/16 16:51:35+02:00 sam@mars.ravnborg.org +1 -1
#   Fix breakage
# 
diff -Nru a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
--- a/arch/ia64/kernel/Makefile	2004-08-16 16:52:33 +02:00
+++ b/arch/ia64/kernel/Makefile	2004-08-16 16:52:33 +02:00
@@ -21,7 +21,7 @@
 # The gate DSO image is built using a special linker script.
 targets += gate.so gate-syms.o
 
-extra-y := gate.so gate-syms.o gate.lds gate.o
+extra-y += gate.so gate-syms.o gate.lds gate.o
 
 # fp_emulate() expects f2-f5,f16-f31 to contain the user-level state.
 CFLAGS_traps.o  += -mfixed-range=f2-f5,f16-f31
