Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUHFQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUHFQDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268173AbUHFQCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:02:32 -0400
Received: from s-und-t-linnich.de ([217.160.180.132]:40675 "HELO
	s-und-t-linnich.de") by vger.kernel.org with SMTP id S268156AbUHFP6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:58:07 -0400
Date: Fri, 6 Aug 2004 19:57:09 +0200
From: "admin@wodkahexe.de" <admin@wodkahexe.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with OOMKiller 2.6.8-rc3
Message-Id: <20040806195709.160722fa.admin@wodkahexe.de>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

today i tried to burn a cd (bin+cue image) that was located on an
nfs share.

- boot 2.6.8-rc3
- startx
- start k3b
- burn image

after ~50% of burning the mouse stopped moving over the screen. the
keyboard was dead.

the maschine was reachable via network, so i ssh'd and saw the
following in dmesg:

laptop oom-killer: gfp_mask=0x1d2
laptop DMA per-cpu:
laptop cpu 0 hot: low 2, high 6, batch 1 
laptop cpu 0 cold: low 0, high 2, batch 1 
laptop Normal per-cpu:
laptop cpu 0 hot: low 32, high 96, batch 16
laptop cpu 0 cold: low 0, high 32, batch 16
laptop HighMem per-cpu: empty
laptop  
laptop Free pages:        2192kB (0kB HighMem)
laptop Active:2113 inactive:643 dirty:0 writeback:0 unstable:0 free:548 slab:2233 mapped:1518 pagetables:210
laptop DMA free:1376kB min:20kB low:40kB high:60kB active:0kB inactive:0kB present:16384kB
laptop protections[]: 10 354 354 
laptop Normal free:816kB min:688kB low:1376kB high:2064kB active:8452kB inactive:2572kB present:491456kB
laptop protections[]: 0 344 344 
laptop HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
laptop protections[]: 0 0 0
laptop DMA: 0*4kB 0*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1376kB
laptop Normal: 30*4kB 1*8kB 1*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 816kB 
laptop HighMem: empty
laptop Swap cache: add 11150, delete 11054, find 684/873, race 0+0
laptop Out of Memory: Killed process 3990 (k3b).
laptop Out of Memory: Killed process 4048 (k3b).
laptop oom-killer: gfp_mask=0x1d2
laptop DMA per-cpu:
laptop cpu 0 hot: low 2, high 6, batch 1 
laptop cpu 0 cold: low 0, high 2, batch 1 
laptop Normal per-cpu:
laptop cpu 0 hot: low 32, high 96, batch 16
laptop cpu 0 cold: low 0, high 32, batch 16
laptop HighMem per-cpu: empty
laptop  
laptop Free pages:        2076kB (0kB HighMem)
laptop Active:1764 inactive:991 dirty:0 writeback:0 unstable:0 free:519 slab:2028 mapped:1518 pagetables:198
laptop DMA free:1388kB min:20kB low:40kB high:60kB active:0kB inactive:0kB present:16384kB
laptop protections[]: 10 354 354 
laptop Normal free:688kB min:688kB low:1376kB high:2064kB active:7056kB inactive:3964kB present:491456kB
laptop protections[]: 0 344 344 
laptop HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
laptop protections[]: 0 0 0
laptop DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 0*512kB 1*1024kB 0*2048kB 0*4096kB = 1388kB
laptop Normal: 0*4kB 0*8kB 1*16kB 1*32kB 0*64kB 1*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 688kB 
laptop HighMem: empty
laptop Swap cache: add 11164, delete 11068, find 684/881, race 1+0
laptop Out of Memory: Killed process 4051 (kdeinit).

The maschine in an acer travelmate 291lci with 512 mb ram.

i saved the output of /proc/{slapinfo,meminfo,vmstat} and rebooted.
i'll let you know,  if i can reproduce it

please let me know, if you need any other information and output.

thanks, sebastian
