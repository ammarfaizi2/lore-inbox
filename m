Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSJUOrM>; Mon, 21 Oct 2002 10:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261485AbSJUOrM>; Mon, 21 Oct 2002 10:47:12 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:62375 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261486AbSJUOrK>;
	Mon, 21 Oct 2002 10:47:10 -0400
Date: Mon, 21 Oct 2002 16:53:16 +0200
From: bert hubert <ahu@ds9a.nl>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [PATCH] kallsyms leaves cruft behind
Message-ID: <20021021145316.GA14919@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, mingo@elte.hu,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arguably, this should be cleaned up just after making vmlinux but the rules
look complicated and I'm unsure it is worth the effort to complicate them
further.

--- linux-2.5.44/Makefile~	Mon Oct 21 16:10:58 2002
+++ linux-2.5.44/Makefile	Mon Oct 21 16:24:45 2002
@@ -675,7 +675,8 @@
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Files removed with 'make clean'
-CLEAN_FILES += vmlinux System.map MC*
+CLEAN_FILES += vmlinux System.map .tmp_vmlinux1 .tmp_kallsyms1.o \
+	.tmp_vmlinux2 .tmp_kallsyms2.o .tmpver.2 .tmpver.1 MC*
 
 # Files removed with 'make mrproper'
 MRPROPER_FILES += \


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
