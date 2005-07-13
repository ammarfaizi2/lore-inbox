Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVGMR3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVGMR3s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVGMR21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:28:27 -0400
Received: from mta01.mail.t-online.hu ([195.228.240.50]:58833 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261326AbVGMR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:26:12 -0400
Subject: [PATCH 13/19] Kconfig I18N: menuconfig: answering
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:26:09 +0200
Message-Id: <1121275570.2975.38.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for answering in menuconfig. This patch is useful for 
non-latin based languages.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/mconf.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -puN scripts/kconfig/mconf.c~kconfig-i18n-13-menuconfig-key scripts/kconfig/mconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/mconf.c~kconfig-i18n-13-menuconfig-key	2005-07-13 18:32:19.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/mconf.c	2005-07-13 18:36:44.000000000 +0200
@@ -564,7 +564,7 @@ static void build_conf(struct menu *menu
 	struct menu *child;
 	int type, tmp, doint = 2;
 	tristate val;
-	char ch;
+	const char *ch;
 
 	if (!menu_is_visible(menu))
 		return;
@@ -622,11 +622,11 @@ static void build_conf(struct menu *menu
 				break;
 			case S_TRISTATE:
 				switch (val) {
-				case yes: ch = '*'; break;
-				case mod: ch = 'M'; break;
-				default:  ch = ' '; break;
+				case yes: ch = "*"; break;
+				case mod: ch = _("M"); break;
+				default:  ch = " "; break;
 				}
-				cprint1("<%c>", ch);
+				cprint1("<%s>", ch);
 				break;
 			}
 		} else {
@@ -673,12 +673,12 @@ static void build_conf(struct menu *menu
 			case S_TRISTATE:
 				cprint("t%p", menu);
 				switch (val) {
-				case yes: ch = '*'; break;
-				case mod: ch = 'M'; break;
-				default:  ch = ' '; break;
+				case yes: ch = "*"; break;
+				case mod: ch = _("M"); break;
+				default:  ch = " "; break;
 				}
 				if (sym_is_changable(sym))
-					cprint1("<%c>", ch);
+					cprint1("<%s>", ch);
 				else
 					cprint1("---");
 				break;
_


