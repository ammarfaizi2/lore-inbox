Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264091AbTFHA0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTFHA0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:26:53 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:29897
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S264091AbTFHA0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:26:51 -0400
Date: Sat, 7 Jun 2003 20:46:06 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kernel-janitor-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH][SPARSE] Use $(CC) consistently throughout the Makefile
Message-ID: <20030608004606.GH20872@michonline.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	kernel-janitor-discuss@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes compilation of sparse use the correct version of gcc
throughout.  (It doesn't seem to have caused any problems, but the
current situation isn't strictly correct, so...)

diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sat Jun  7 16:44:31 2003
+++ b/Makefile	Sat Jun  7 16:44:31 2003
@@ -41,7 +41,7 @@
 tokenize.o: $(LIB_H)
 
 pre-process.h:
-	echo "#define GCC_INTERNAL_INCLUDE \"`gcc -print-file-name=include`\"" > pre-process.h
+	echo "#define GCC_INTERNAL_INCLUDE \"`$(CC) -print-file-name=include`\"" > pre-process.h
 
 clean:
 	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS) pre-process.h

-- 

Ryan Anderson
  sometimes Pug Majere
