Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTHYRa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTHYRa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:30:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44772 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261901AbTHYRaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:30:15 -0400
Date: Mon, 25 Aug 2003 19:30:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Fox Chen <mhchen@golf.ccl.itri.org.tw>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Gustavo Niemeyer <niemeyer@conectiva.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: 2.6.0-test4-mm1: wl3501_cs.c doesn't compile
Message-ID: <20030825173007.GT7038@fs.tum.de>
References: <20030824171318.4acf1182.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030824171318.4acf1182.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.0-test4-mm1:

<--  snip  -->

...
  CC      drivers/net/wireless/wl3501_cs.o
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_join':
drivers/net/wireless/wl3501_cs.c:641: unknown field `id' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:641: warning: missing braces around 
initializer
drivers/net/wireless/wl3501_cs.c:641: warning: (near initialization for 
`sig.ds_pset.el')
drivers/net/wireless/wl3501_cs.c:642: unknown field `el' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:643: unknown field `chan' specified in 
initializer
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_start':
drivers/net/wireless/wl3501_cs.c:658: unknown field `id' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:658: warning: missing braces around 
initializer
drivers/net/wireless/wl3501_cs.c:658: warning: (near initialization for 
`sig.ds_pset.el')
drivers/net/wireless/wl3501_cs.c:659: unknown field `el' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:660: unknown field `chan' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:663: unknown field `id' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:664: unknown field `el' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:665: unknown field `data_rate_labels' 
specified in initializer
drivers/net/wireless/wl3501_cs.c:673: unknown field `id' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:674: unknown field `el' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:675: unknown field `data_rate_labels' 
specified in initializer
drivers/net/wireless/wl3501_cs.c:683: unknown field `id' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:684: unknown field `el' specified in 
initializer
drivers/net/wireless/wl3501_cs.c:685: unknown field `atim_window' 
specified in initializer
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_mgmt_scan_confirm':
drivers/net/wireless/wl3501_cs.c:702: parse error before `)'
drivers/net/wireless/wl3501_cs.c:705: parse error before `)'
drivers/net/wireless/wl3501_cs.c:740: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_auth':
drivers/net/wireless/wl3501_cs.c:899: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_association':
drivers/net/wireless/wl3501_cs.c:913: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_mgmt_join_confirm':
drivers/net/wireless/wl3501_cs.c:923: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_md_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:982: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_get_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1038: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_start_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1050: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_assoc_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1062: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function 
`wl3501_auth_confirm_interrupt':
drivers/net/wireless/wl3501_cs.c:1074: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_rx_interrupt':
drivers/net/wireless/wl3501_cs.c:1090: parse error before `)'
drivers/net/wireless/wl3501_cs.c: In function `wl3501_exit_module':
drivers/net/wireless/wl3501_cs.c:2350: parse error before `)'
make[3]: *** [drivers/net/wireless/wl3501_cs.o] Error 1


<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

