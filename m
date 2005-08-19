Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVHSPCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVHSPCM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVHSPCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:02:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964952AbVHSPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:02:11 -0400
Date: Fri, 19 Aug 2005 17:02:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Raghavendra Koushik <raghavendra.koushik@neterion.com>,
       jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: 2.6.13-rc6-mm1: drivers/net/s2io.c: compile error with gcc 4.0
Message-ID: <20050819150209.GD3682@stusta.de>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 04:33:31AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.13-rc5-mm1:
>...
> -git-netdev-chelsio.patch
> -git-netdev-e100.patch
> -git-netdev-sis190.patch
> -git-netdev-smc91x-eeprom.patch
> -git-netdev-ieee80211-wifi.patch
> -git-netdev-upstream.patch
> +git-netdev-all.patch
> 
>  And a consolidated netdev tree
>...

This patch causes the following compile error with gcc 4.0:

<--  snip  -->

...
  CC      drivers/net/s2io.o
In file included from drivers/net/s2io.c:65:
drivers/net/s2io.h: In function 'readq':
drivers/net/s2io.h:765: error: invalid lvalue in assignment
drivers/net/s2io.h:766: error: invalid lvalue in assignment
drivers/net/s2io.c: In function 'init_shared_mem':
drivers/net/s2io.c:541: warning: cast from pointer to integer of different size
drivers/net/s2io.c:544: warning: cast to pointer from integer of different size
drivers/net/s2io.c:550: warning: cast from pointer to integer of different size
drivers/net/s2io.c:553: warning: cast to pointer from integer of different size
make[2]: *** [drivers/net/s2io.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

