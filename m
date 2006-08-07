Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWHGXhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWHGXhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHGXhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:37:34 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1187 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932417AbWHGXhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:37:33 -0400
Date: Tue, 8 Aug 2006 01:37:15 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net
Subject: [PATCH] pr_debug() should not be used in drivers
Message-ID: <20060807233715.GL2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492242899-git-send-email-multinymous@gmail.com> <20060807134440.GD4032@ucw.cz> <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com> <20060807231557.GA2759@elf.ucw.cz> <20060807232330.GA16540@suse.de> <20060807232520.GF2759@elf.ucw.cz> <20060807232906.GA16922@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807232906.GA16922@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pr_debug() should not be used from drivers, add comment saying that.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 181c69c..1b5f238 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -210,6 +210,7 @@ extern enum system_states {
 extern void dump_stack(void);
 
 #ifdef DEBUG
+/* If you are writing a driver, please use dev_dbg, instead */
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
 #else

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
