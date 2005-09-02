Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbVIBVYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbVIBVYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbVIBVYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:24:50 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23563 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161050AbVIBVYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:24:49 -0400
Date: Fri, 2 Sep 2005 23:24:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/atm/ioctl.c should #include "common.h"
Message-ID: <20050902212439.GX3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions.

common.h contains the prototype for vcc_ioctl().


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-mm1-full/net/atm/ioctl.c.old	2005-09-02 23:01:46.000000000 +0200
+++ linux-2.6.13-mm1-full/net/atm/ioctl.c	2005-09-02 23:17:06.000000000 +0200
@@ -21,6 +21,7 @@
 
 #include "resources.h"
 #include "signaling.h"		/* for WAITING and sigd_attach */
+#include "common.h"
 
 
 static DECLARE_MUTEX(ioctl_mutex);

