Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTLRO1I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbTLRO1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:27:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22410 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265178AbTLRO07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:26:59 -0500
Date: Thu, 18 Dec 2003 14:26:55 +0000
From: Matthew Wilcox <willy@debian.org>
To: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: [PATCH] Kconfig help text inaccessible
Message-ID: <20031218142655.GH15674@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch enables Kconfig help texts for string options to be printed
by the command line configuration program

--- linus-2.6/scripts/kconfig/conf.c	Thu Dec 18 06:10:12 2003
+++ parisc-2.6/scripts/kconfig/conf.c	Thu Dec 18 05:49:01 2003
@@ -175,7 +175,7 @@ int conf_string(struct menu *menu)
 			break;
 		case '?':
 			/* print help */
-			if (line[1] == 0) {
+			if (line[1] == '\n') {
 				help = nohelp_text;
 				if (menu->sym->help)
 					help = menu->sym->help;

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
