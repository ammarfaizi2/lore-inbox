Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133008AbRDREnb>; Wed, 18 Apr 2001 00:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRDREnV>; Wed, 18 Apr 2001 00:43:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48360 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S133008AbRDREnQ>;
	Wed, 18 Apr 2001 00:43:16 -0400
Date: Wed, 18 Apr 2001 00:43:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: 2.4.4-pre4 nfsd.o unresolved symbol
In-Reply-To: <Pine.LNX.4.33.0104181224060.7126-100000@boston.corp.fedex.com>
Message-ID: <Pine.GSO.4.21.0104180040050.9930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Apr 2001, Jeff Chua wrote:

> depmod: *** Unresolved symbols in /lib/modules/2.4.4-pre4/kernel/fs/nfsd/nfsd.o
> depmod:         nfsd_linkage_Rb56858ea

Grrr...

Add #include <linux/module.h> to fs/filesystems.c. My apologies.

--- fs/filesystems.c    Tue Apr 17 23:40:32 2001
+++ /tmp/filesystems.c  Wed Apr 18 00:41:01 2001
@@ -7,6 +7,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/kmod.h>


