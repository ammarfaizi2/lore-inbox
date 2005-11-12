Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVKLEQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVKLEQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVKLEQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:16:54 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59912 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751252AbVKLEQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:16:54 -0500
Date: Sat, 12 Nov 2005 05:16:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: drivers/video/nvidia/ compile error with PPC_OF=y, FB_OF=n
Message-ID: <20051112041649.GU5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.14-mm2 that seems to come from 
Linus' tree:

<--  snip  -->

...
  CC [M]  drivers/video/nvidia/nv_of.o
drivers/video/nvidia/nv_of.c:33: error: redefinition of 'nvidia_probe_of_connector'
drivers/video/nvidia/nv_proto.h:51: error: previous definition of 'nvidia_probe_of_connector' was here
make[3]: *** [drivers/video/nvidia/nv_of.o] Error 1

<--  snip  -->

The problem is that nv_proto.h thinks nv_of.o is only built with 
CONFIG_FB_OF=y, but it's actually built when CONFIG_PPC_OF=y.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

