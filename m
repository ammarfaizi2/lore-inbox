Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSHKKw7>; Sun, 11 Aug 2002 06:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHKKw6>; Sun, 11 Aug 2002 06:52:58 -0400
Received: from codepoet.org ([166.70.99.138]:39646 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S318264AbSHKKw6>;
	Sun, 11 Aug 2002 06:52:58 -0400
Date: Sun, 11 Aug 2002 04:56:45 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020811105645.GB19032@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 05, 2002 at 07:40:56PM -0300, Marcelo Tosatti wrote:
> <achirica@ttd.net> (02/05/31 1.445.1.13)
> 	airo wireless net driver update:

Doesn't this make more sense?

--- linux/drivers/net/wireless/airo.c.orig	Sun Aug 11 03:59:28 2002
+++ linux/drivers/net/wireless/airo.c	Sun Aug 11 03:59:46 2002
@@ -191,12 +191,6 @@
 #ifndef RUN_AT
 #define RUN_AT(x) (jiffies+(x))
 #endif
-#ifndef PDE
-static inline struct proc_dir_entry *PDE(const struct inode *inode)
-{
-	return inode->u.generic_ip;
-}
-#endif
 
 
 /* These variables are for insmod, since it seems that the rates

diff -urN linux-2.4.19.orig/include/linux/proc_fs.h linux-2.4.19/include/linux/proc_fs.h
--- linux-2.4.19.orig/include/linux/proc_fs.h	Fri Aug  2 18:39:45 2002
+++ linux-2.4.19/include/linux/proc_fs.h	Sun Aug 11 00:23:55 2002
@@ -209,4 +209,9 @@
 
 #endif /* CONFIG_PROC_FS */
 
+static inline struct proc_dir_entry *PDE(const struct inode *inode)
+{
+	return (struct proc_dir_entry *)inode->u.generic_ip;
+}
+

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
