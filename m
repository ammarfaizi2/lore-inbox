Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276516AbRI2Ony>; Sat, 29 Sep 2001 10:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276517AbRI2Ono>; Sat, 29 Sep 2001 10:43:44 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:6785 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S276516AbRI2Onc>;
	Sat, 29 Sep 2001 10:43:32 -0400
From: arjan@fenrus.demon.nl
To: ookhoi@dds.nl
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine)
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010929162224.E9327@humilis>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15nLLO-00027M-00@fenrus.demon.nl>
Date: Sat, 29 Sep 2001 15:43:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010929162224.E9327@humilis> you wrote:
> Hi Justin, Alan,

> aic7xxx_old.c:11965: parse error before string constant
> aic7xxx_old.c:11965: warning: type defaults to `int' in declaration of `MODULE_LICENSE'
> aic7xxx_old.c:11965: warning: function declaration isn't a prototype
> aic7xxx_old.c:11965: warning: data definition has no type or storage class


Yet another driver with bogus #ifdef around the module.h include.. sigh


--- linux/drivers/scsi/aic7xxx/aic7xxx_linux.c~	Fri Sep 28 13:02:13 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux.c	Sat Sep 29 15:41:52 2001
@@ -120,9 +120,7 @@
  * under normal conditions.
  */
 
-#if defined(MODULE)
 #include <linux/module.h>
-#endif
 
 #include "aic7xxx_osm.h"
 #include "aic7xxx_inline.h"
