Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266239AbUBLHSB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 02:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266299AbUBLHSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 02:18:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:10390 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266239AbUBLHRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 02:17:53 -0500
Subject: Re: PPC64 PowerMac G5 support available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, benh@ozlabs.org
In-Reply-To: <Pine.LNX.4.58.0402112223480.5816@home.osdl.org>
References: <1076563481.2285.167.camel@gaston>
	 <Pine.LNX.4.58.0402112223480.5816@home.osdl.org>
Content-Type: text/plain
Message-Id: <1076570096.873.193.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 12 Feb 2004 18:14:57 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually, there's another issue, which is that the default G5 config 
> enables drivers/serial/pmac_zilog.c, which has a
> 
> 	#include <asm/kgdb.h>
> 
> in it that will cause the build to fail.

So here's the patch :)

===== drivers/serial/pmac_zilog.c 1.3 vs edited =====
--- 1.3/drivers/serial/pmac_zilog.c	Thu Feb 12 15:50:41 2004
+++ edited/drivers/serial/pmac_zilog.c	Thu Feb 12 18:14:00 2004
@@ -59,7 +59,6 @@
 #include <asm/bitops.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
-#include <asm/kgdb.h>
 #include <asm/dbdma.h>
 #include <asm/macio.h>
 


