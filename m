Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbUJ3PuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbUJ3PuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUJ3Ps0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:48:26 -0400
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:10503 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261277AbUJ3Pie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:38:34 -0400
Message-ID: <4183B572.60804@tebibyte.org>
Date: Sat, 30 Oct 2004 17:38:26 +0200
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com> <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org> <41834FE7.5060705@jp.fujitsu.com> <418354C0.3060207@tebibyte.org> <418357C5.4070304@jp.fujitsu.com> <41835F4D.2060508@tebibyte.org> <4183649C.7070601@jp.fujitsu.com>
In-Reply-To: <4183649C.7070601@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hiroyuki KAMEZAWA escreveu:
> Oh, Okay, my patch was wrong ;(.
> Very sorry for wrong hack.
> This one will be Okay.

That works, now my oom report looks like this...

Oct 30 17:32:22 sleepy oom-killer: gfp_mask=0x1d2
Oct 30 17:32:22 sleepy DMA per-cpu:
Oct 30 17:32:22 sleepy cpu 0 hot: low 2, high 6, batch 1
Oct 30 17:32:22 sleepy cpu 0 cold: low 0, high 2, batch 1
Oct 30 17:32:22 sleepy Normal per-cpu:
Oct 30 17:32:22 sleepy cpu 0 hot: low 4, high 12, batch 2
Oct 30 17:32:22 sleepy cpu 0 cold: low 0, high 4, batch 2
Oct 30 17:32:22 sleepy HighMem per-cpu: empty
Oct 30 17:32:22 sleepy
Oct 30 17:32:22 sleepy Free pages:         332kB (0kB HighMem)
Oct 30 17:32:22 sleepy Active:11887 inactive:517 dirty:0 writeback:0 
unstable:0 free:83 slab:1347 mapped:11930 pagetables:247
Oct 30 17:32:22 sleepy DMA free:60kB min:60kB low:120kB high:180kB 
active:11256kB inactive:436kB present:16384kB pages_scanned:11686 
all_unreclaimable? yes
Oct 30 17:32:22 sleepy protections[]: 0 0 0
Oct 30 17:32:22 sleepy Normal free:272kB min:188kB low:376kB high:564kB 
active:36292kB inactive:1632kB present:49144kB pages_scanned:6922 
all_unreclaimable? no
Oct 30 17:32:22 sleepy protections[]: 0 0 0
Oct 30 17:32:22 sleepy HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Oct 30 17:32:22 sleepy protections[]: 0 0 0
Oct 30 17:32:22 sleepy DMA: 1*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 60kB
Oct 30 17:32:22 sleepy Normal: 0*4kB 12*8kB 1*16kB 1*32kB 0*64kB 1*128kB 
0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 272kB
Oct 30 17:32:22 sleepy HighMem: empty
Oct 30 17:32:22 sleepy Swap cache: add 136776, delete 129314, find 
37853/51620, race 0+0
Oct 30 17:32:22 sleepy Out of Memory: Killed process 12395 (ld).


