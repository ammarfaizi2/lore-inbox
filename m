Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWGXNhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWGXNhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 09:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWGXNhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 09:37:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:46283 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932186AbWGXNhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 09:37:22 -0400
Date: Mon, 24 Jul 2006 15:37:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] kconfig/lxdialog: add bluetitle color scheme
In-Reply-To: <20060724131528.GB23210@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0607241529280.6761@scrub.home>
References: <20060724113641.GA22806@mars.ravnborg.org>
 <20060724113914.GD22806@mars.ravnborg.org> <Pine.LNX.4.64.0607241425440.6762@scrub.home>
 <20060724131528.GB23210@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Jul 2006, Sam Ravnborg wrote:

> I blindly replaced yellow with blue.
> New version looks like this:
> static void set_bluetitle_theme(void)
> {
>         DLG_MODIFY(title,   COLOR_BLUE, COLOR_WHITE,  true);
>         DLG_MODIFY(tag,     COLOR_BLUE, COLOR_WHITE,  true);
>         DLG_MODIFY(tag_key, COLOR_BLUE, COLOR_WHITE,  true);
> }

The theme below should be a bit better and more consistent, selected text
is always white on blue with a yellow key character.

> The classic color scheme is quite readable on my display.

On mnay displays (especially lcd's) the difference between yellow and 
white is very small, so that the text almost disappears.

bye, Roman

---
 scripts/kconfig/lxdialog/util.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-2.6-git/scripts/kconfig/lxdialog/util.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lxdialog/util.c	2006-07-24 15:00:16.000000000 +0200
+++ linux-2.6-git/scripts/kconfig/lxdialog/util.c	2006-07-24 15:27:20.000000000 +0200
@@ -104,14 +104,13 @@ static void set_blackbg_theme(void)
 
 static void set_bluetitle_theme(void)
 {
-	DLG_MODIFY(title, COLOR_BLUE, COLOR_WHITE,  true);
-	DLG_MODIFY(button_label_active, COLOR_BLUE, COLOR_BLUE,   true);
-	DLG_MODIFY(searchbox_title,     COLOR_BLUE, COLOR_WHITE,  true);
-	DLG_MODIFY(position_indicator,  COLOR_BLUE, COLOR_WHITE,  true);
-	DLG_MODIFY(tag,                 COLOR_BLUE, COLOR_WHITE,  true);
-	DLG_MODIFY(tag_selected,        COLOR_BLUE, COLOR_BLUE,   true);
-	DLG_MODIFY(tag_key,             COLOR_BLUE, COLOR_WHITE,  true);
-	DLG_MODIFY(tag_key_selected,    COLOR_BLUE, COLOR_BLUE,   true);
+	DLG_MODIFY(title, 		COLOR_BLUE,   COLOR_WHITE,  true);
+	DLG_MODIFY(button_key_active,	COLOR_YELLOW, COLOR_BLUE,   true);
+	DLG_MODIFY(button_label_active,	COLOR_WHITE,  COLOR_BLUE,   true);
+	DLG_MODIFY(searchbox_title,	COLOR_BLUE,   COLOR_WHITE,  true);
+	DLG_MODIFY(position_indicator,	COLOR_BLUE,   COLOR_WHITE,  true);
+	DLG_MODIFY(tag,			COLOR_BLUE,   COLOR_WHITE,  true);
+	DLG_MODIFY(tag_key,		COLOR_BLUE,   COLOR_WHITE,  true);
 }
 
 static void init_one_color(struct dialog_color *color)
