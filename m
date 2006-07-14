Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWGNSs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWGNSs2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbWGNSs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:48:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36871 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161274AbWGNSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:48:27 -0400
Date: Fri, 14 Jul 2006 20:48:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, netdev@vger.kernel.org
Subject: 2.6.18-rc1-mm2: drivers/char/*synclink* compile errors
Message-ID: <20060714184825.GB3633@stusta.de>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof, the following compile errors are caused by your commit 
c2ce920468624d87ec5f91f080ea99681dae6d88 in Linus' tree:

<--  snip  -->

...
  CC      drivers/char/pcmcia/synclink_cs.o
drivers/char/pcmcia/synclink_cs.c: In function ‘dcd_change’:
drivers/char/pcmcia/synclink_cs.c:1171: error: implicit declaration of function ‘hdlc_set_carrier’
...
  CC      drivers/char/synclink.o
drivers/char/synclink.c: In function ‘mgsl_isr_io_pin’:
drivers/char/synclink.c:1348: error: implicit declaration of function ‘hdlc_set_carrier’
...
  CC      drivers/char/synclinkmp.o
drivers/char/synclinkmp.c: In function ‘hdlcdev_open’:
drivers/char/synclinkmp.c:1755: error: implicit declaration of function ‘hdlc_set_carrier’
...
  CC      drivers/char/synclink_gt.o
drivers/char/synclink_gt.c: In function ‘hdlcdev_open’:
drivers/char/synclink_gt.c:1500: error: implicit declaration of function ‘hdlc_set_carrier’

<--   snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

