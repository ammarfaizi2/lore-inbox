Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWDKRhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWDKRhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWDKRhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:37:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:13263 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750842AbWDKRhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:37:20 -0400
Date: Tue, 11 Apr 2006 10:33:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.4
Message-ID: <20060411173345.GB29965@kroah.com>
References: <20060411173323.GA29965@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411173323.GA29965@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 1450dfe..29efaa1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .3
+EXTRAVERSION = .4
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/kernel/signal.c b/kernel/signal.c
index ea15410..bc8f80b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -975,7 +975,6 @@ __group_complete_signal(int sig, struct 
 		if (t == NULL)
 			/* restart balancing at this thread */
 			t = p->signal->curr_target = p;
-		BUG_ON(t->tgid != p->tgid);
 
 		while (!wants_signal(sig, t)) {
 			t = next_thread(t);
