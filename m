Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSKHNYJ>; Fri, 8 Nov 2002 08:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSKHNYJ>; Fri, 8 Nov 2002 08:24:09 -0500
Received: from stingr.net ([212.193.32.15]:2830 "EHLO hq.stingr.net")
	by vger.kernel.org with ESMTP id <S261900AbSKHNYI>;
	Fri, 8 Nov 2002 08:24:08 -0500
Date: Fri, 8 Nov 2002 16:30:47 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: trivial@rustcorp.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: improve signal-to-noise ratio in atm code
Message-ID: <20021108133047.GE29935@stingr.net>
Mail-Followup-To: trivial@rustcorp.com.au,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/net/atm/common.c b/net/atm/common.c
--- a/net/atm/common.c	Fri Nov  8 16:27:27 2002
+++ b/net/atm/common.c	Fri Nov  8 16:27:27 2002
@@ -288,7 +288,7 @@
 	if (vpi != ATM_VPI_UNSPEC && vci != ATM_VCI_UNSPEC)
 		clear_bit(ATM_VF_PARTIAL,&vcc->flags);
 	else if (test_bit(ATM_VF_PARTIAL,&vcc->flags)) return -EINVAL;
-	printk(KERN_DEBUG "atm_connect (TX: cl %d,bw %d-%d,sdu %d; "
+	DPRINTK("atm_connect (TX: cl %d,bw %d-%d,sdu %d; "
 	    "RX: cl %d,bw %d-%d,sdu %d,AAL %s%d)\n",
 	    vcc->qos.txtp.traffic_class,vcc->qos.txtp.min_pcr,
 	    vcc->qos.txtp.max_pcr,vcc->qos.txtp.max_sdu,

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
  When you're invisible, the only one really watching you is you (my keychain)
