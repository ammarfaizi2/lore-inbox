Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTBPTWe>; Sun, 16 Feb 2003 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTBPTWe>; Sun, 16 Feb 2003 14:22:34 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:7439 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267339AbTBPTWd>;
	Sun, 16 Feb 2003 14:22:33 -0500
Date: Sun, 16 Feb 2003 20:32:29 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] aic7xxx/aicasm makefile - fix make clean
Message-ID: <20030216193229.GA22723@mars.ravnborg.org>
Mail-Followup-To: "Justin T. Gibbs" <gibbs@scsiguy.com>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest change to aic7xxx/aicasm/makefile broke make clean.
The following patch re-enable "make-clean" and keep the clean: target.

	Sam

===== drivers/scsi/aic7xxx/aicasm/Makefile 1.8 vs edited =====
--- 1.8/drivers/scsi/aic7xxx/aicasm/Makefile	Tue Dec 10 20:02:52 2002
+++ edited/drivers/scsi/aic7xxx/aicasm/Makefile	Sun Feb 16 20:29:45 2003
@@ -45,8 +45,9 @@
 		echo "*** Install db development libraries";	\
 	 fi
 
+clean-files := $(CLEANFILES) $(PROG)
 clean:
-	rm -f $(CLEANFILES) $(PROG)
+	rm -f $(clean-files)
 
 aicasm_gram.c aicasm_gram.h: aicasm_gram.y
 	$(YACC) $(YFLAGS) -b $(<:.y=) $<
