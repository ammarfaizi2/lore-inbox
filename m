Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWGXLjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWGXLjg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWGXLjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:39:35 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:16314 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932122AbWGXLjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:39:35 -0400
Date: Mon, 24 Jul 2006 13:39:14 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/3] kconfig/lxdialog: add bluetitle color scheme
Message-ID: <20060724113914.GD22806@mars.ravnborg.org>
References: <20060724113641.GA22806@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724113641.GA22806@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 911310907eca1e8c1feea41d9e1e3860f4eb3815 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Mon, 24 Jul 2006 13:30:05 +0200
Subject: [PATCH] kconfig/lxdialog: add bluetitle color scheme

Originally from -mm but modofied to the new color scheme support

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/util.c |   14 ++++++++++++++
 scripts/kconfig/mconf.c         |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index e3b1462..99f88b4 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -102,6 +102,18 @@ static void set_blackbg_theme(void)
 	DLG_MODIFY(darrow, COLOR_RED, COLOR_BLACK, false);
 }
 
+static void set_bluetitle_theme(void)
+{
+	DLG_MODIFY(title, COLOR_BLUE, COLOR_WHITE,  true);
+	DLG_MODIFY(button_label_active, COLOR_BLUE, COLOR_BLUE,   true);
+	DLG_MODIFY(searchbox_title,     COLOR_BLUE, COLOR_WHITE,  true);
+	DLG_MODIFY(position_indicator,  COLOR_BLUE, COLOR_WHITE,  true);
+	DLG_MODIFY(tag,                 COLOR_BLUE, COLOR_WHITE,  true);
+	DLG_MODIFY(tag_selected,        COLOR_BLUE, COLOR_BLUE,   true);
+	DLG_MODIFY(tag_key,             COLOR_BLUE, COLOR_WHITE,  true);
+	DLG_MODIFY(tag_key_selected,    COLOR_BLUE, COLOR_BLUE,   true);
+}
+
 static void init_one_color(struct dialog_color *color)
 {
 	static int pair = 0;
@@ -153,6 +165,8 @@ static int set_color_theme(const char *t
 	int use_color = 1;
 	if (!strncasecmp (theme, "blackbg", sizeof("blackbg")))
 		set_blackbg_theme();
+	if (!strncasecmp (theme, "bluetitle", sizeof("bluetitle")))
+		set_bluetitle_theme();
 	else if (!strncasecmp(theme, "mono", sizeof("mono")))
 		use_color = 0;
 	return use_color;
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index d518161..ce36eaa 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -171,6 +171,7 @@ static const char mconf_readme[] = N_(
 "Available themes are\n"
 " mono    => selects colors suitable for monochrome displays\n"
 " blackbg => selects a color scheme with black background\n"
+" bluetitle => replace yellow titles with blue in classic scheme\n"
 "\n"),
 menu_instructions[] = N_(
 	"Arrow keys navigate the menu.  "
-- 
1.4.1.rc2.gfc04

