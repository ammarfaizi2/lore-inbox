Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUDHXgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 19:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbUDHXgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 19:36:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2797 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261780AbUDHXgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 19:36:07 -0400
Date: Thu, 08 Apr 2004 16:35:26 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>, gerg@snapgear.com, greg@kroah.com
Subject: Re: [PATCH 2.6 istallion.c] RFT added class support to istallion.c
Message-ID: <11160000.1081467326@w-hlinder.beaverton.ibm.com>
In-Reply-To: <129960000.1080093056@w-hlinder.beaverton.ibm.com>
References: <129960000.1080093056@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Realized I put a / in the filename of this device too.

Here is the fix:

diff -Nrup -Xdontdiff linux-2.6.5/drivers/char/istallion.c linux-2.6.5p/drivers/char/istallion.c
--- linux-2.6.5/drivers/char/istallion.c	2004-04-08 16:26:14.000000000 -0700
+++ linux-2.6.5p/drivers/char/istallion.c	2004-04-08 16:26:44.000000000 -0700
@@ -5323,7 +5323,7 @@ int __init stli_init(void)
 			       S_IFCHR | S_IRUSR | S_IWUSR,
 			       "staliomem/%d", i);
 		class_simple_device_add(istallion_class, MKDEV(STL_SIOMEMMAJOR, i), 
-				NULL, "staliomem/%d", i);
+				NULL, "staliomem%d", i);
 	}
 
 /*

