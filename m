Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbRBIBFN>; Thu, 8 Feb 2001 20:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129505AbRBIBFD>; Thu, 8 Feb 2001 20:05:03 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:45066 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129068AbRBIBE4>;
	Thu, 8 Feb 2001 20:04:56 -0500
Date: Fri, 9 Feb 2001 02:04:53 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cosmetic: missing includes (net/sched)
Message-ID: <20010209020453.Q13984@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.4.2-pre1 adds a few includes I forgot in sch_atm.c and
sch_dsmark.c

Their absence didn't cause any kernel compilation problems, but it may
well in the future (or when compiling things in a different context,
that's why I, ehm ... finally, noticed the problem).

- Werner

------------------------------------ patch ------------------------------------

--- linux.orig/net/sched/sch_atm.c	Wed Mar 22 08:38:27 2000
+++ linux/net/sched/sch_atm.c	Fri Feb  9 01:56:07 2001
@@ -5,6 +5,8 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/interrupt.h>
 #include <linux/atmdev.h>
--- linux.orig/net/sched/sch_dsmark.c	Mon Jan 22 22:30:21 2001
+++ linux/net/sched/sch_dsmark.c	Fri Feb  9 01:56:58 2001
@@ -6,6 +6,8 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/string.h>
+#include <linux/errno.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h> /* for pkt_sched */
 #include <linux/rtnetlink.h>

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
