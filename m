Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVIRWAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVIRWAi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVIRWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 18:00:38 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:35217 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932225AbVIRWAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 18:00:37 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] driver: char: n_hdlc.c - remove unused declaration
Date: Mon, 19 Sep 2005 08:00:12 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <47ori11vlqsl88ih5mhsofuaj9ur3rc00b@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Alan,

Tripped over this while testing something else with make allmodconfig, 
14-rc1-mm1 has the declared function removed (compared with 2.6.14-rc1-git4).  

Grant.

This patch silences a warning: "drivers/char/n_hdlc.c:194: warning: 
`n_hdlc_tty_room' declared `static' but never defined", the associated 
function is gone already.
 
Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 n_hdlc.c |    1 -
 1 files changed, 1 deletion(-)

--- linux-2.6.14-rc1-mm1/drivers/char/n_hdlc.c	2005-09-18 08:51:11.000000000 +1000
+++ linux-2.6.14-rc1-mm1b/drivers/char/n_hdlc.c	2005-09-19 07:40:49.000000000 +1000
@@ -191,7 +191,6 @@
 				    poll_table *wait);
 static int n_hdlc_tty_open(struct tty_struct *tty);
 static void n_hdlc_tty_close(struct tty_struct *tty);
-static int n_hdlc_tty_room(struct tty_struct *tty);
 static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *cp,
 			       char *fp, int count);
 static void n_hdlc_tty_wakeup(struct tty_struct *tty);
