Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUGRTud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUGRTud (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUGRTud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:50:33 -0400
Received: from web53801.mail.yahoo.com ([206.190.36.196]:31893 "HELO
	web53801.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262772AbUGRTua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:50:30 -0400
Message-ID: <20040718195030.32683.qmail@web53801.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:50:30 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from net/atm files
To: lkml <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com, chas@cmf.nrl.navy.mil
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/net/atm/common.h linux-2.6.7-new/net/atm/common.h
--- linux-2.6.7-orig/net/atm/common.h   2004-06-15 22:19:43.000000000 -0700
+++ linux-2.6.7-new/net/atm/common.h    2004-07-18 08:52:50.000000000 -0700
@@ -24,11 +24,6 @@
 int vcc_getsockopt(struct socket *sock, int level, int optname,
                   char __user *optval, int __user *optlen);

-void atm_shutdown_dev(struct atm_dev *dev);
-
-void pppoatm_ioctl_set(int (*hook)(struct atm_vcc *, unsigned int, unsigned long));
-void br2684_ioctl_set(int (*hook)(struct atm_vcc *, unsigned int, unsigned long));
-
 int atmpvc_init(void);
 void atmpvc_exit(void);
 int atmsvc_init(void);
@@ -50,12 +45,6 @@
 #endif /* CONFIG_PROC_FS */

 /* SVC */
-
-void svc_callback(struct atm_vcc *vcc);
 int svc_change_qos(struct atm_vcc *vcc,struct atm_qos *qos);

-/* p2mp */
-
-int create_leaf(struct socket *leaf,struct socket *session);
-
 #endif
diff -ru linux-2.6.7-orig/net/atm/lec.h linux-2.6.7-new/net/atm/lec.h
--- linux-2.6.7-orig/net/atm/lec.h      2004-06-15 22:19:10.000000000 -0700
+++ linux-2.6.7-new/net/atm/lec.h       2004-07-18 08:50:35.000000000 -0700
@@ -151,7 +151,6 @@
 int lec_vcc_attach(struct atm_vcc *vcc, void __user *arg);
 int lec_mcast_attach(struct atm_vcc *vcc, int arg);
 struct net_device *get_dev_lec(int itf);
-int make_lec(struct atm_vcc *vcc);
 int send_to_lecd(struct lec_priv *priv,
                  atmlec_msg_type type, unsigned char *mac_addr,
                  unsigned char *atm_addr, struct sk_buff *data);

