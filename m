Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUCZMgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 07:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUCZMgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 07:36:13 -0500
Received: from math.ut.ee ([193.40.5.125]:15591 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264044AbUCZMgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 07:36:10 -0500
Date: Fri, 26 Mar 2004 14:36:00 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: whiteheat USB serial compile failure on PPC (2.6)
In-Reply-To: <20040319010015.GE19053@kroah.com>
Message-ID: <Pine.GSO.4.44.0403261429520.2460-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bah, looks like PPC doesn't ever define CMSPAR :(
>
> How about adding something like:
> 	#ifndef CMSPAR
> 	#define CMSPAR 0
> 	#endif
> To the beginning of the driver like the cdc-acm.c driver does?  If that
> works, care to send me a patch?

Yes, it compiles.

===== drivers/usb/serial/whiteheat.c 1.43 vs edited =====
--- 1.43/drivers/usb/serial/whiteheat.c	Fri Jan 23 17:55:41 2004
+++ edited/drivers/usb/serial/whiteheat.c	Fri Mar 26 14:10:26 2004
@@ -91,6 +91,10 @@
 #include "whiteheat_fw.h"		/* firmware for the ConnectTech WhiteHEAT device */
 #include "whiteheat.h"			/* WhiteHEAT specific commands */

+#ifndef CMSPAR
+#define CMSPAR 0
+#endif
+
 /*
  * Version Information
  */

-- 
Meelis Roos (mroos@linux.ee)

