Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTE2T0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbTE2T0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:26:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:61902 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262547AbTE2T0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:26:52 -0400
Date: Thu, 29 May 2003 21:40:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, llinux-scsi@vger.kernel.org
Subject: [patch] 2.5.70-mm2: aha1740.c doesn't compile.
Message-ID: <20030529194003.GH5643@fs.tum.de>
References: <20030529012914.2c315dad.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems the following compile error comes from Linus' tree:

<--  snip  -->

...
  CC      drivers/scsi/aha1740.o
...
drivers/scsi/aha1740.c:613: syntax error at end of input
...
make[2]: *** [drivers/scsi/aha1740.o] Error 1

<--  snip  -->


The culprit is the following bogus part of a patch (please _revert_ it):


--- linux-2.5.70/drivers/scsi/aha1740.c	2003-05-26 19:16:33.000000000 -0700
+++ 25/drivers/scsi/aha1740.c	2003-05-28 23:52:00.000000000 -0700
@@ -108,7 +102,6 @@ static int aha1740_proc_info(char *buffe
     if (len > length)
 	len = length;
     return len;
-}
 
 
 static int aha1740_makecode(unchar *sense, unchar *status)



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

