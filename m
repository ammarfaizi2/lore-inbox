Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDHSfY>; Sun, 8 Apr 2001 14:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRDHSfN>; Sun, 8 Apr 2001 14:35:13 -0400
Received: from pc57-cam4.cable.ntl.com ([62.253.135.57]:58764 "EHLO
	kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S132584AbRDHSe5>; Sun, 8 Apr 2001 14:34:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: 2.2.19: cross-compile patch for drivers/net/Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 08 Apr 2001 19:34:44 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14mK1M-0001AI-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cross-compiles need to use the target linker here.

p.

--- linux/drivers/net/Makefile~	Sun Apr  8 17:48:31 2001
+++ linux/drivers/net/Makefile	Sun Apr  8 19:31:29 2001
@@ -1445,7 +1445,7 @@
 	rm -f core *.o *.a *.s
 
 wanpipe.o: $(WANPIPE_OBJS)
-	ld -r -o $@ $(WANPIPE_OBJS)
+	$(LD) -r -o $@ $(WANPIPE_OBJS)
 
 rcpci.o: rcpci45.o rclanmtl.o
 	$(LD) -r -o rcpci.o rcpci45.o rclanmtl.o


