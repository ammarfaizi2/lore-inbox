Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317762AbSFLSxh>; Wed, 12 Jun 2002 14:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317763AbSFLSxg>; Wed, 12 Jun 2002 14:53:36 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:3826 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317762AbSFLSxg>;
	Wed, 12 Jun 2002 14:53:36 -0400
Date: Wed, 12 Jun 2002 11:53:36 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir251_expiry_fix.diff
Message-ID: <20020612115336.A23918@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Jeff,

	Could you add this trivial patch to the batch of patches I've
already sent you for 2.5.22 ?
	Thanks,

	Jean


ir251_expiry_fix.diff :
---------------------
	o [CORRECT] Make discovery expiry work properly for non default
		discovery period/timeout



diff -u -p linux/include/net/irda/discovery.d1.h linux/include/net/irda/discovery.h
--- linux/include/net/irda/discovery.d1.h	Wed Jun 12 10:55:58 2002
+++ linux/include/net/irda/discovery.h	Wed Jun 12 10:56:42 2002
@@ -38,7 +38,7 @@
 #include <net/irda/irqueue.h>		/* irda_queue_t */
 #include <net/irda/irlap_event.h>	/* LAP_REASON */
 
-#define DISCOVERY_EXPIRE_TIMEOUT 6*HZ
+#define DISCOVERY_EXPIRE_TIMEOUT (2*sysctl_discovery_timeout*HZ)
 #define DISCOVERY_DEFAULT_SLOTS  0
 
 /*

