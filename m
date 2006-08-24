Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWHXSkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWHXSkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030464AbWHXSkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 14:40:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:15676 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030462AbWHXSkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 14:40:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=lrutTrECtO6AyXzg3oqOji9hHjp8lg3g6+Rn4qn1qr+I5FCZdwJ4T0kbYwPvTVN1h13dEVZsqOYXNW1poARXZMi9MGjILhm+UHi89Q9vqRDmOjV5KwoQ2PEcm3M/2Lpo4P6R6PkOcLQ1qUI2AVFi49HMmOuuA1N/u6FPYcHNuDg=
Date: Thu, 24 Aug 2006 22:44:47 +0400
From: Andrew Brukhov <pingved@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] boot: small change of halt method
Message-ID: <20060824184447.GA3346@windows95>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm new here.
After reading boot code i'm immidiatly change this string:

--- ./linux-2.6.17.11/arch/i386/boot/compressed/misc.c	2006-08-24 01:16:33.000000000 +0400
+++ /usr/src/linux-2.6.17.11/arch/i386/boot/compressed/misc.c	2006-08-24 22:36:10.000000000 +0400
@@ -7,6 +7,7 @@
  * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
  * puts by Nick Holloway 1993, better puts by Martin Mares 1995
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+ * Small fix of halt method Andrew Brukhov, Aug. 2006               
  */
 
 #include <linux/linkage.h>
@@ -289,8 +290,7 @@ static void error(char *x)
 	putstr("\n\n");
 	putstr(x);
 	putstr("\n\n -- System halted");
-
-	while(1);	/* Halt */
+      	asm( "hlt" );
 }

It's becouse this code is platform depended and therefore there is no resons to write infinity cycle.

--------------
Andrew Brukhov
