Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263328AbUJ2NjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbUJ2NjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263326AbUJ2Nhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:37:40 -0400
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:53765 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S263321AbUJ2Ngm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:36:42 -0400
Message-ID: <41824760.7010703@tebibyte.org>
Date: Fri, 29 Oct 2004 15:36:32 +0200
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       javier@marcet.info, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       barry <barry@disus.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com> <20041028120650.GD5741@logos.cnet>
In-Reply-To: <20041028120650.GD5741@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo & co.,

Testing again: on plain 2.6.10-rc1-mm2 (i.e. without Rik's patch) 
building umlsim fails on my 64MB P2 350MHz Gentoo box exactly as before.

Regards,
Chris R.

Oct 29 15:25:19 sleepy oom-killer: gfp_mask=0xd0
Oct 29 15:25:19 sleepy DMA per-cpu:
Oct 29 15:25:19 sleepy cpu 0 hot: low 2, high 6, batch 1
Oct 29 15:25:19 sleepy cpu 0 cold: low 0, high 2, batch 1
Oct 29 15:25:19 sleepy Normal per-cpu:
Oct 29 15:25:19 sleepy cpu 0 hot: low 4, high 12, batch 2
Oct 29 15:25:19 sleepy cpu 0 cold: low 0, high 4, batch 2
Oct 29 15:25:19 sleepy HighMem per-cpu: empty
Oct 29 15:25:19 sleepy
Oct 29 15:25:19 sleepy Free pages:         244kB (0kB HighMem)
Oct 29 15:25:19 sleepy Active:12269 inactive:596 dirty:0 writeback:0 
unstable:0 free:61 slab:1117 mapped:12368 pagetables:140
Oct 29 15:25:19 sleepy DMA free:60kB min:60kB low:120kB high:180kB 
active:12304kB inactive:0kB present:16384kB pages_scanned:15252 
all_unreclaimable? yes
Oct 29 15:25:19 sleepy protections[]: 0 0 0
Oct 29 15:25:19 sleepy Normal free:184kB min:188kB low:376kB high:564kB 
active:36772kB inactive:2384kB present:49144kB pages_scanned:41571 
all_unreclaimable
? yes
Oct 29 15:25:19 sleepy protections[]: 0 0 0
Oct 29 15:25:19 sleepy HighMem free:0kB min:128kB low:256kB high:384kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Oct 29 15:25:19 sleepy protections[]: 0 0 0
Oct 29 15:25:19 sleepy DMA: 4294567735*4kB 4294792863*8kB 
4294895642*16kB 4294943555*32kB 4294962724*64kB 4294966891*128kB 
4294967255*256kB 4294967283*512kB
  4294967290*1024kB 4294967293*2048kB 4294967294*4096kB = 4289685332kB
Oct 29 15:25:19 sleepy Normal: 4293893066*4kB 4294583823*8kB 
4294849819*16kB 4294950038*32kB 4294966291*64kB 4294966753*128kB 
4294967182*256kB 4294967238*51
2kB 4294967265*1024kB 4294967278*2048kB 4294967281*4096kB = 4284847952kB
Oct 29 15:25:19 sleepy HighMem: empty
Oct 29 15:25:19 sleepy Swap cache: add 9372, delete 7530, find 
1491/1835, race 0+0
Oct 29 15:25:19 sleepy Out of Memory: Killed process 12157 (ld).
