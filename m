Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276384AbRJKOgI>; Thu, 11 Oct 2001 10:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276452AbRJKOf6>; Thu, 11 Oct 2001 10:35:58 -0400
Received: from dns-cta.onda.com.br ([200.195.192.133]:4005 "EHLO
	rosa.onda.com.br") by vger.kernel.org with ESMTP id <S276384AbRJKOfk>;
	Thu, 11 Oct 2001 10:35:40 -0400
Date: Thu, 11 Oct 2001 11:28:37 -0300 (BRT)
From: "Alexandre P. Nunes" <alex@PolesApart.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.12 - ieee1284_ops.c
Message-ID: <Pine.LNX.4.33.0110111126030.9081-100000@PolesApart.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

parport module doesn't compile, at least when enabled ieee 1284 options...
the cause is a typo, the patch should make it clear.

Cheers,

Alexandre

--- ieee1284_ops.c~	Thu Oct 11 11:10:37 2001
+++ ieee1284_ops.c	Thu Oct 11 11:22:31 2001
@@ -362,7 +362,7 @@
 	} else {
 		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}

 	return retval;
@@ -394,7 +394,7 @@
 		DPRINTK (KERN_DEBUG
 			 "%s: ECP direction: failed to switch forward\n",
 			 port->name);
-		port->ieee1284.phase = IEEE1284_PH_DIR_UNKNOWN;
+		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}

-- 
Life would be so much easier if we could just look at the source code.

