Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSDCPpQ>; Wed, 3 Apr 2002 10:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312104AbSDCPoz>; Wed, 3 Apr 2002 10:44:55 -0500
Received: from nogapok.sgu.ru ([212.193.32.15]:56519 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S311885AbSDCPox>;
	Wed, 3 Apr 2002 10:44:53 -0500
Date: Wed, 3 Apr 2002 19:44:40 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: missing spinlock declaration in one of watchdogs
Message-ID: <20020403154440.GA24914@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of watchdog drivers won't compile without it

Applies to -ac and latest marcelo tree.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.226   -> 1.227  
#	drivers/char/w83877f_wdt.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/03	stingray@proxy.sgu.ru	1.227
# w83877 missing spinlock
# --------------------------------------------
#
diff -Nru a/drivers/char/w83877f_wdt.c b/drivers/char/w83877f_wdt.c
--- a/drivers/char/w83877f_wdt.c	Wed Apr  3 19:38:49 2002
+++ b/drivers/char/w83877f_wdt.c	Wed Apr  3 19:38:49 2002
@@ -92,6 +92,7 @@
 static unsigned long wdt_is_open;
 static int wdt_expect_close;
 static spinlock_t wdt_spinlock;
+static spinlock_t fop_spinlock;
 
 /*
  *	Whack the dog


-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
