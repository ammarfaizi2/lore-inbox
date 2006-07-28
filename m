Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752039AbWG1Q30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbWG1Q30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWG1Q30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:29:26 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:19134 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752039AbWG1Q3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:29:25 -0400
Date: Fri, 28 Jul 2006 18:29:05 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] kconfig/lxdialog: color theme support
In-Reply-To: <Pine.LNX.4.64.0607270223220.6761@scrub.home>
Message-ID: <Pine.LNX.4.61.0607281826200.4972@yvahk01.tjqt.qr>
References: <20060725065640.GA2685@mars.ravnborg.org>
 <Pine.LNX.4.64.0607270223220.6761@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Second iteration of the patchset to add color theme support to lxdialog.
> This patchset allow the menuconfig user to select between a number of
> different color themes for menuconfig:
> blackbg, classic, mono and bluetitle

Ain't nobody say the kernel lacks customization!

It would have been nice to do the following,

diff --fast -Ndpru -x '*.cmd' lxdialog~/util.c lxdialog/util.c
--- lxdialog~/util.c	2006-07-28 16:37:28.499577000 +0200
+++ lxdialog/util.c	2006-07-28 16:52:09.929577000 +0200
@@ -63,6 +63,42 @@ do {                               \
 	dlg.dialog.hl = (h);       \
 } while (0)
 
+static void set_classiciv_theme(void)
+{
+	dlg = (const struct dialog_info){
+		.screen                = {0, COLOR_CYAN,   COLOR_BLUE,  true},
+		.shadow                = {0, COLOR_BLACK,  COLOR_BLACK, true},
...
+		.uarrow                = {0, COLOR_GREEN,  COLOR_WHITE, true},
+ 		.darrow                = {0, COLOR_GREEN,  COLOR_WHITE, true},
+	};
+	return;
+}

Which uses a nice memcpy call rather than tons of MOVs (assembler insns). 
Unfortuantely it truncates ->title.




Jan Engelhardt
-- 
