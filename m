Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143421AbREKXYk>; Fri, 11 May 2001 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143422AbREKXYb>; Fri, 11 May 2001 19:24:31 -0400
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:18695 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S143420AbREKXYO>;
	Fri, 11 May 2001 19:24:14 -0400
Date: Fri, 11 May 2001 16:24:12 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: alan@lxorguk.ukuu.org.uk
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Enable IP PNP for 2.4.4-ac8
Message-ID: <20010511162412.A11896@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.4-ac8 disables IP auto config by default even if CONFIG_IP_PNP is
defined.  Here is a patch.


H.J.
---
--- linux-2.4.4-ac8/net/ipv4/ipconfig.c.auto	Fri May 11 14:02:32 2001
+++ linux-2.4.4-ac8/net/ipv4/ipconfig.c	Fri May 11 15:26:25 2001
@@ -100,7 +100,11 @@
  */
 int ic_set_manually __initdata = 0;		/* IPconfig parameters set manually */
 
+#if defined(CONFIG_IP_PNP)
+int ic_enable __initdata = 1;			/* IP config enabled? */
+#else
 int ic_enable __initdata = 0;			/* IP config enabled? */
+#endif
 
 /* Protocol choice */
 int ic_proto_enabled __initdata = 0
