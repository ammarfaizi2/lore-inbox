Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272002AbTGYKQC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272003AbTGYKQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:16:02 -0400
Received: from AToulouse-105-1-29-241.w81-51.abo.wanadoo.fr ([81.51.111.241]:29701
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S272002AbTGYKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:15:59 -0400
Date: Fri, 25 Jul 2003 12:31:07 +0200
From: =?iso-8859-15?B?Suly9G1lIEF1Z+k=?= <eguaj@free.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix 2.6.0-test1 *** Warning: "llc_oui" [net/sched/sch_atm.ko] undefined!
Message-ID: <20030725103106.GB1670@satellite.workgroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: none
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in 'net/atm/Makefile' that gives a 'Warning: "llc_oui"
[net/sched/sch_atm.ko] undefined!' when building modules:

--- net/atm/Makefile.old	2003-07-24 16:36:47.000000000 +0200
+++ net/atm/Makefile	2003-07-24 16:36:55.000000000 +0200
@@ -10,7 +10,7 @@
 atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
 obj-$(CONFIG_ATM_BR2684) += br2684.o
 atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
-atm-$(subst m,y,$CONFIG_NET_SCH_ATM)) += ipcommon.o
+atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
 atm-$(CONFIG_PROC_FS) += proc.o
 
 obj-$(CONFIG_ATM_LANE) += lec.o

Regards,
Jérôme

--

