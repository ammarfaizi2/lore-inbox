Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSKNVPZ>; Thu, 14 Nov 2002 16:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSKNVPZ>; Thu, 14 Nov 2002 16:15:25 -0500
Received: from pasky.ji.cz ([62.44.12.54]:37870 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S265236AbSKNVPZ>;
	Thu, 14 Nov 2002 16:15:25 -0500
Date: Thu, 14 Nov 2002 22:22:18 +0100
From: Petr Baudis <pasky@ucw.cz>
To: torvalds@transmeta.com, zippel@linux-m68k.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] [kconfig] Merge error of singlemenu mconf patch
Message-ID: <20021114212218.GG2644@pasky.ji.cz>
Mail-Followup-To: torvalds@transmeta.com, zippel@linux-m68k.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  this patch (against 2.5.47) fixes apparent merge error of my menuconfig
singlemenu patch, accepted before 2.5.47 release. In that patch, following
modification to lxdialog was needed - without this change, the highlighting of
the menu items' hotkey is broken (the first '+' is highlighted).

  Please apply.

 scripts/lxdialog/util.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

  Kind regards,
                                Petr Baudis

diff -ru linux/scripts/lxdialog/util.c linux+pasky/scripts/lxdialog/util.c
--- linux/scripts/lxdialog/util.c	Wed Nov  6 21:50:00 2002
+++ linux+pasky/scripts/lxdialog/util.c	Thu Nov 14 22:15:55 2002
@@ -348,7 +348,7 @@
 		c = tolower(string[i]);
 
 		if (strchr("<[(", c)) ++in_paren;
-		if (strchr(">])", c)) --in_paren;
+		if (strchr(">])", c) && in_paren > 0) --in_paren;
 
 		if ((! in_paren) && isalpha(c) && 
 		     strchr(exempt, c) == 0)
