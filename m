Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTDVMfF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTDVMfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:35:05 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:12001 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263125AbTDVMfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:35:04 -0400
Message-ID: <3EA539AD.90102@shemesh.biz>
Date: Tue, 22 Apr 2003 15:46:37 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en, he
MIME-Version: 1.0
To: irda-users@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] small IRDA compilation error
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against CVS tip.

Fixed a mismatch in declaration between "irport_interrupt" in the header 
files (returning void) and in the definition (returning irqreturn_t).

I'm not subscribed to irda-users, so please also reply in private.

Index: include/net/irda/irport.h
===================================================================
RCS file: /home/sun/sources/cvs/linux-2.5/include/net/irda/irport.h,v
retrieving revision 1.2
diff -u -r1.2 irport.h
--- include/net/irda/irport.h   5 Feb 2002 17:40:40 -0000       1.2
+++ include/net/irda/irport.h   22 Apr 2003 11:54:53 -0000
@@ -81,7 +81,7 @@
 void irport_start(struct irport_cb *self);
 void irport_stop(struct irport_cb *self);
 void irport_change_speed(void *priv, __u32 speed);
-void irport_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+irqreturn_t irport_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 int  irport_hard_xmit(struct sk_buff *skb, struct net_device *dev);
 int  irport_net_open(struct net_device *dev);
 int  irport_net_close(struct net_device *dev);

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


