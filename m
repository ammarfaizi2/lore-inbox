Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271825AbRIWQt2>; Sun, 23 Sep 2001 12:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272212AbRIWQtR>; Sun, 23 Sep 2001 12:49:17 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:4366 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271825AbRIWQtD>; Sun, 23 Sep 2001 12:49:03 -0400
Subject: Re: Preemptible 2.4.10-pre15 compile error
From: Robert Love <rml@ufl.edu>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010923123812.62399.qmail@web10405.mail.yahoo.com>
In-Reply-To: <20010923123812.62399.qmail@web10405.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.21.20.26 (Preview Release)
Date: 23 Sep 2001 12:49:42 -0400
Message-Id: <1001263785.863.61.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-23 at 08:38, Steve Kieu wrote:
> Hi,
> 
> Exactly, make modules error

Please try the following patch, it should apply cleanly to any
2.4.10-pre or 2.4.9-ac -- it should fix the compile issue with
preemption.  Please report back if it is successful so I can merge the
patch into the preemption patch itself.


diff -urN linux-2.4.9-ac14-preempt/fs/adfs/map.c linux/fs/adfs/map.c
--- linux-2.4.9-ac14-preempt/fs/adfs/map.c	Sat Sep 22 23:20:09 2001
+++ linux/fs/adfs/map.c	Sun Sep 23 12:46:21 2001
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 
 #include "adfs.h"
 


-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

