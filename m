Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUHAJsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUHAJsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 05:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUHAJsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 05:48:21 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:27335 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265517AbUHAJsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 05:48:19 -0400
Date: Sun, 1 Aug 2004 11:47:09 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040801094709.GA1108@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: VURwksZTgeP9RkKGIGrnTuGOPF0df1z+hX02kpKGORVQHgiYLSXmYY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied your patch to 2.6.8-rc-bk10 and the system survied 
three concurrent du -s started each started with a delay.

Conspicuous is that memory usage (xosview) does not go above 1.5GB now.
Here is a snapshoot of cat/proc/vmstat taken at a time when memory usage
has stagnated.

--
Klaus

nr_dirty 1294
nr_writeback 0
nr_unstable 0
nr_page_table_pages 425
nr_mapped 38811
nr_slab 211923
pgpgin 1157363
pgpgout 150328
pswpin 0
pswpout 0
pgalloc_high 295581
pgalloc_normal 716183
pgalloc_dma 5455
pgfree 1150071
pgactivate 115758
pgdeactivate 74788
pgfault 263245
pgmajfault 1441
pgrefill_high 0
pgrefill_normal 74461
pgrefill_dma 327
pgsteal_high 0
pgsteal_normal 97886
pgsteal_dma 527
pgscan_kswapd_high 0
pgscan_kswapd_normal 92301
pgscan_kswapd_dma 490
pgscan_direct_high 0
pgscan_direct_normal 22869
pgscan_direct_dma 180
pginodesteal 22206
slabs_scanned 6414979
kswapd_steal 79035
kswapd_inodesteal 32158
pageoutrun 535
allocstall 562
pgrotated 5286
