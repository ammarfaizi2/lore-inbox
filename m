Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbUKLQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUKLQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUKLQyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:54:47 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:61203 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262569AbUKLQwX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:52:23 -0500
Message-ID: <4194EA45.90800@tebibyte.org>
Date: Fri, 12 Nov 2004 17:52:21 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org>
In-Reply-To: <4193E056.6070100@tebibyte.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Ross escreveu:
> It seems good.

Sorry Marcelo, I spoke to soon. The oom killer still goes haywire even 
with your new patch. I even got this one whilst the machine was booting!

Ignore the big numbers, they are cured by Kame's patch. I haven't 
applied that to this kernel. This tree is pure 2.6.10-rc1-mm2 with only 
your recent oom patch applied.

Regards,
Chris R.


Nov 12 17:32:21 sleepy Free pages:         268kB (0kB HighMem)
Nov 12 17:32:21 sleepy Active:7853 inactive:4921 dirty:0 writeback:0 
unstable:0
free:67 slab:1243 mapped:5773 pagetables:103
Nov 12 17:32:21 sleepy DMA free:60kB min:60kB low:120kB high:180kB 
active:6436kB
  inactive:5624kB present:16384kB pages_scanned:7108 all_unreclaimable? no
Nov 12 17:32:21 sleepy protections[]: 0 0 0
Nov 12 17:32:21 sleepy Normal free:208kB min:188kB low:376kB high:564kB 
active:2
4976kB inactive:14060kB present:49144kB pages_scanned:19668 
all_unreclaimable? n
o
Nov 12 17:32:21 sleepy protections[]: 0 0 0
Nov 12 17:32:21 sleepy HighMem free:0kB min:128kB low:256kB high:384kB 
active:0k
B inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Nov 12 17:32:21 sleepy protections[]: 0 0 0
Nov 12 17:32:21 sleepy DMA: 4294944789*4kB 4294964727*8kB 
4294966668*16kB 429496
7076*32kB 4294967238*64kB 4294967233*128kB 4294967253*256kB 
4294967284*512kB 429
4967290*1024kB 4294967293*2048kB 4294967294*4096kB = 4294790220kB
Nov 12 17:32:21 sleepy Normal: 4294803738*4kB 4294928464*8kB 
4294957447*16kB 429
4964898*32kB 4294966867*64kB 4294967050*128kB 4294967186*256kB 
4294967246*512kB
4294967268*1024kB 4294967283*2048kB 4294967286*4096kB = 4293559128kB
Nov 12 17:32:21 sleepy HighMem: empty
Nov 12 17:32:21 sleepy Swap cache: add 13796, delete 10099, find 
2839/3488, race
  0+0
Nov 12 17:32:21 sleepy Out of Memory: Killed process 6806 (qmgr).
