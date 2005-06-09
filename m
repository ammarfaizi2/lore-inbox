Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVFIAQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVFIAQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbVFIAQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:16:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:6027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262224AbVFIAQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:16:01 -0400
Date: Wed, 8 Jun 2005 17:14:13 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, pete@phraxos.nildram.co.uk,
       zhilla@bigfoot.com, kraxel@bytesex.org
Subject: [patch 06/09] Fix for bttv driver (v0.9.15) for Leadtek WinFast VC100 XP capture cards
Message-ID: <20050609001413.GM13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a tiny patch that fixes bttv-cards.c so that Leadtek WinFast
VC100 XP video capture cards work. I've been advised to post it here
after having already posted it to the v4l mailing list.

Acked-by: Gerd Knorr <kraxel@bytesex.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

--- ./drivers/media/video/bttv-cards.c.orig	2005-04-24 23:39:41.000000000 +0100
+++ ./drivers/media/video/bttv-cards.c	2005-04-25 19:59:27.000000000 +0100
@@ -1939,7 +1939,6 @@
         .no_tda9875     = 1,
         .no_tda7432     = 1,
         .tuner_type     = TUNER_ABSENT,
-        .no_video       = 1,
 	.pll            = PLL_28,
 },{
 	.name           = "Teppro TEV-560/InterVision IV-560",
