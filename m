Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWACNcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWACNcU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWACNcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:32:18 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:38661 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932352AbWACNZg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:36 -0500
Subject: [PATCH 08/26] kconfig: truncate too long menu lines in menuconfig
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <1136294725440@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132610372 +0100

menu lines wrapped over too lines when too long - truncate them.
Also fixed a coding style issue

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/menubox.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

e067e1f98d54d62fd598126f95e7684e5b63e67f
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index d0bf32b..2d91880 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -70,7 +70,7 @@ static void do_print_item(WINDOW * win, 
 	int j;
 	char *menu_item = malloc(menu_width + 1);
 
-	strncpy(menu_item, item, menu_width);
+	strncpy(menu_item, item, menu_width - ITEM_IDENT);
 	menu_item[menu_width] = 0;
 	j = first_alpha(menu_item, "YyNnMmHh");
 
@@ -184,8 +184,8 @@ int dialog_menu(const char *title, const
                 const char *const *items)
 {
 	int i, j, x, y, box_x, box_y;
-	int key = 0, button = 0, scroll = 0, choice = 0, first_item =
-	    0, max_choice;
+	int key = 0, button = 0, scroll = 0, choice = 0;
+	int first_item =  0, max_choice;
 	WINDOW *dialog, *menu;
 	FILE *f;
 
-- 
1.0.6

