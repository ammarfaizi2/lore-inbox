Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWHTXAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWHTXAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 19:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWHTXAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 19:00:09 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:65295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751789AbWHTXAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 19:00:06 -0400
Date: Mon, 21 Aug 2006 01:00:06 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/atm/: proper prototypes
Message-ID: <20060820230006.GW7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds proper prototypes in net/atm/mpc.h for two global 
functions in net/atm/mpoa_proc.c

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 net/atm/mpc.c |    5 -----
 net/atm/mpc.h |    3 +++
 2 files changed, 3 insertions(+), 5 deletions(-)

--- linux-2.6.18-rc4-mm2/net/atm/mpc.h.old	2006-08-20 23:24:37.000000000 +0200
+++ linux-2.6.18-rc4-mm2/net/atm/mpc.h	2006-08-20 23:25:13.000000000 +0200
@@ -50,4 +50,7 @@
 struct seq_file;
 void atm_mpoa_disp_qos(struct seq_file *m);
 
+int mpc_proc_init(void);
+void mpc_proc_clean(void);
+
 #endif /* _MPC_H_ */
--- linux-2.6.18-rc4-mm2/net/atm/mpc.c.old	2006-08-20 23:25:26.000000000 +0200
+++ linux-2.6.18-rc4-mm2/net/atm/mpc.c	2006-08-20 23:25:49.000000000 +0200
@@ -98,11 +98,6 @@
 	0
 };
 
-#ifdef CONFIG_PROC_FS
-extern int mpc_proc_init(void);
-extern void mpc_proc_clean(void);
-#endif
-
 struct mpoa_client *mpcs = NULL; /* FIXME */
 static struct atm_mpoa_qos *qos_head = NULL;
 static DEFINE_TIMER(mpc_timer, NULL, 0, 0);

