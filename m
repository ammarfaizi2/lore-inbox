Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVJCAVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVJCAVE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 20:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJCAVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 20:21:04 -0400
Received: from amun.rz.tu-clausthal.de ([139.174.2.12]:2010 "EHLO
	amun.rz.tu-clausthal.de") by vger.kernel.org with ESMTP
	id S932084AbVJCAVD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 20:21:03 -0400
From: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
To: linux-kernel@vger.kernel.org
Subject: please explain luser (me) oom-killer with free swap
Date: Mon, 3 Oct 2005 02:20:43 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510030220.44540.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an AMD64 box with 1gb of ram and approximatly 1gb of swap.

Distribution is gentoo, but the kernels are stock kernel.org kernels.


My problem: 
when I try to emerge kdepim-3.4.2 with the 'kdeenablefinal' useflag (which 
makes the whole thing extra memory hungry), I get a lot of oom-kills.
Usually it kills kwin, which is a little bit annyoing, but not always, as you 
can see below.

But always, there is still a lot of free swap:

[15204.500025] oom-killer: gfp_mask=0x480d2, order=0
[15204.500030] Mem-info:
[15204.500032] DMA per-cpu:
[15204.500034] cpu 0 hot: low 2, high 6, batch 1 used:4
[15204.500036] cpu 0 cold: low 0, high 2, batch 1 used:1
[15204.500038] Normal per-cpu:
[15204.500041] cpu 0 hot: low 62, high 186, batch 31 used:84
[15204.500043] cpu 0 cold: low 0, high 62, batch 31 used:44
[15204.500045] HighMem per-cpu: empty
[15204.500048] Free pages:        9092kB (0kB HighMem)
[15204.500052] Active:240481 inactive:1223 dirty:0 writeback:0 unstable:0 
free:2273 slab:7287 mapped:240616 pagetables:1389
[15204.500056] DMA free:4088kB min:60kB low:72kB high:88kB active:8440kB 
inactive:0kB present:15996kB pages_scanned:8931 all_unreclaimable? yes
[15204.500059] lowmem_reserve[]: 0 1007 1007
[15204.500064] Normal free:5004kB min:4028kB low:5032kB high:6040kB 
active:953484kB inactive:4892kB present:1031872kB pages_scanned:66 
all_unreclaimable? no
[15204.500067] lowmem_reserve[]: 0 0 0
[15204.500071] HighMem free:0kB min:128kB low:160kB high:192kB active:0kB 
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[15204.500073] lowmem_reserve[]: 0 0 0
[15204.500075] DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 
1*1024kB 1*2048kB 0*4096kB = 4088kB
[15204.500082] Normal: 123*4kB 44*8kB 8*16kB 2*32kB 0*64kB 1*128kB 1*256kB 
1*512kB 1*1024kB 1*2048kB 0*4096kB = 5004kB
[15204.500089] HighMem: empty
[15204.500092] Swap cache: add 314, delete 247, find 0/0, race 0+0
[15204.500094] Free swap  = 994764kB
[15204.500095] Total swap = 996020kB
[15204.500097] Free swap:       994764kB
[15204.505231] 262064 pages of RAM
[15204.505234] 5453 reserved pages
[15204.505236] 78099 pages shared
[15204.505237] 67 pages swap cached
[15204.505280] Out of Memory: Killed process 30010 (wesnoth).

this was with kernel 2.6.14-rc3, with 2.6.14-rc2 it does not look much 
different. Or 2.6.13-gentoo-rX.
 Luckily this time it killed wesnoth ;)

Would you please be so kind and explain me in not too heavy words, why the 
oom-killer was activated?
oh, and if you need/want more informations, please just say so.


Glück Auf
Volker

ps.
(it would be special kind to cc me)
