Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSIJVAU>; Tue, 10 Sep 2002 17:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSIJVAT>; Tue, 10 Sep 2002 17:00:19 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:50441 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318128AbSIJVAR>;
	Tue, 10 Sep 2002 17:00:17 -0400
Date: Tue, 10 Sep 2002 23:05:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] sound/oss: Files to be deleted during mrproper 3/6
Message-ID: <20020910230500.C18386@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020910225530.A17094@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020910225530.A17094@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Sep 10, 2002 at 10:55:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the sound makefile

	Sam

diff -Nru a/sound/oss/Makefile b/sound/oss/Makefile
--- a/sound/oss/Makefile	Tue Sep 10 22:37:49 2002
+++ b/sound/oss/Makefile	Tue Sep 10 22:37:49 2002
@@ -96,6 +96,10 @@
 
 host-progs	:= bin2hex hex2hex
 
+# Files generated that shall be removed upon make mrproper
+mrproper := maui_boot.h msndperm.c msndinit.c pndsperm.c pndspini.c \
+pss_boot.h trix_boot.h
+
 include $(TOPDIR)/Rules.make
 
 # Firmware files that need translation
