Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUCCV5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbUCCV5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:57:55 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:64223 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261172AbUCCVz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:55:57 -0500
Date: Wed, 3 Mar 2004 22:55:49 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Hunold <hunold@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DVB stv0299.c: remove unused variable
Message-ID: <20040303215549.GJ24510@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The stv0299 DVB frontend update in Linus' 2.6 tree introduced a 
completely unused variable:

<--  snip  -->

...
  CC      drivers/media/dvb/frontends/stv0299.o
drivers/media/dvb/frontends/stv0299.c: In function `tsa5059_set_tv_freq':
drivers/media/dvb/frontends/stv0299.c:356: warning: unused variable `i'
...

<--  snip  -->


The following patch removes this variable:


--- linux-2.6.4-rc1-mm2/drivers/media/dvb/frontends/stv0299.c.old	2004-03-03 22:51:19.000000000 +0100
+++ linux-2.6.4-rc1-mm2/drivers/media/dvb/frontends/stv0299.c	2004-03-03 22:52:57.000000000 +0100
@@ -353,7 +353,7 @@
 	u8 addr;
 	u32 div;
 	u8 buf[4];
-        int i, divisor, regcode;
+	int divisor, regcode;
 
 	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
 


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

