Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVF1Q5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVF1Q5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVF1Qyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:54:43 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:16895 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262153AbVF1Qxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:53:38 -0400
Message-ID: <42C18031.50206@nodivisions.com>
Date: Tue, 28 Jun 2005 12:52:01 -0400
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oom-killings, but I'm not out of memory!
References: <42C179D5.3040603@nodivisions.com> <1119977073.1723.2.camel@localhost.localdomain>
In-Reply-To: <1119977073.1723.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:
>>I'm running a 2.6.11 kernel.  I have 1 gig of RAM and 1 gig of swap.  Lately 
>>when my RAM gets full, the oom-killer takes out either Mozilla or 
>>Thunderbird (my two biggest memory hogs), even though my swap space is only 
>>20% full.  I still have ~800 MB of free swap space, so shouldn't the kernel 
>>push Moz or T-bird into swap instead of oom-killing it?  At their maximum 
>>memory-hogging capacity, neither Moz nor T-bird is ever using more than 200 MB.
>>
>>Jun 28 12:09:09 soma oom-killer: gfp_mask=0x80d2
>>...
>>Jun 28 12:09:09 soma Free swap  = 781012kB
>>Jun 28 12:09:09 soma Total swap = 987988kB
>>Jun 28 12:09:09 soma Out of Memory: Killed process 30787 (thunderbird-bin).
>>Jun 28 12:09:09 soma Out of Memory: Killed process 18112 (thunderbird-bin).
>>Jun 28 12:09:09 soma Out of Memory: Killed process 18116 (thunderbird-bin).
>>Jun 28 12:09:09 soma Out of Memory: Killed process 18117 (thunderbird-bin).
>>Jun 28 12:09:09 soma Out of Memory: Killed process 18119 (thunderbird-bin).
>>Jun 28 12:09:09 soma Out of Memory: Killed process 8857 (thunderbird-bin).
>>
> 
> You cut out the important part where it printed out memory usage
> information at the time of the OOM, please post it
> 

Oops.  I left that out because it line-wrapped so bad, and I didn't realize 
it was important.  Here it is:

... oom-killer: gfp_mask=0x80d2
... DMA per-cpu:
... cpu 0 hot: low 2, high 6, batch 1
... cpu 0 cold: low 0, high 2, batch 1
... Normal per-cpu:
... cpu 0 hot: low 32, high 96, batch 16
... cpu 0 cold: low 0, high 32, batch 16
... HighMem per-cpu:
... cpu 0 hot: low 14, high 42, batch 7
... cpu 0 cold: low 0, high 14, batch 7
...
... Free pages:       12536kB (112kB HighMem)
... Active:240797 inactive:2399 dirty:0 writeback:0 unstable:0 free:3134 
slab:7144 mapped:240597 pagetables:1073
... DMA free:4096kB min:68kB low:84kB high:100kB active:8260kB inactive:0kB 
present:16384kB pages_scanned:9052 all_unreclaimable? yes
... lowmem_reserve[]: 0 880 1007
... Normal free:8328kB min:3756kB low:4692kB high:5632kB active:827084kB 
inactive:9468kB present:901120kB pages_scanned:23361 all_unreclaimable? no
... lowmem_reserve[]: 0 0 1023
... HighMem free:112kB min:128kB low:160kB high:192kB active:127844kB 
inactive:128kB present:131008kB pages_scanned:135459 all_unreclaimable? yes
... lowmem_reserve[]: 0 0 0
... DMA: 0*4kB 28*8kB 16*16kB 1*32kB 0*64kB 0*128kB 0*256kB 1*512kB 1*1024kB 
1*2048kB 0*4096kB = 4096kB
... Normal: 98*4kB 16*8kB 216*16kB 18*32kB 1*64kB 1*128kB 0*256kB 1*512kB 
1*1024kB 1*2048kB 0*4096kB = 8328kB
... HighMem: 0*4kB 2*8kB 2*16kB 0*32kB 1*64kB 0*128kB 0*256kB 0*512kB 
0*1024kB 0*2048kB 0*4096kB = 112kB
... Swap cache: add 166973, delete 149202, find 1714386/1723885, race 0+0
... Free swap  = 781012kB
... Total swap = 987988kB
... Out of Memory: Killed process 30787 (thunderbird-bin).
... Out of Memory: Killed process 18112 (thunderbird-bin).
... Out of Memory: Killed process 18116 (thunderbird-bin).
... Out of Memory: Killed process 18117 (thunderbird-bin).
... Out of Memory: Killed process 18119 (thunderbird-bin).
... Out of Memory: Killed process 8857 (thunderbird-bin).

-Anthony DiSante
http://nodivisions.com/
