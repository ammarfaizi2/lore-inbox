Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSJDNlM>; Fri, 4 Oct 2002 09:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSJDNlL>; Fri, 4 Oct 2002 09:41:11 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:16768 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261666AbSJDNlL>;
	Fri, 4 Oct 2002 09:41:11 -0400
Message-ID: <3D9D9BC0.9070801@colorfullife.com>
Date: Fri, 04 Oct 2002 15:46:40 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander.Riesen@synopsys.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe bugfix /cleanup
References: <Pine.LNX.4.44.0210031514230.19230-100000@dbl.q-ag.de> <20021004074008.GB941@riesen-pc.gr05.synopsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:
> 
> This makes 2.4.19 + Con Kolivas patch behave very bad.
> The system goes slow, freeze, than wakes up, freeze again, etc.
> 
> I did "cat /dev/zero | grep nothing".
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  0  0 124592 292056  60624  70488   0   1    27    19    7     2   5   1   2
[snip]
>  0  2  1 437440   3168  52796  70132   4 20392     4 20392  493   542   0   5  95
>  0  2  2 437328   3144  52760  70168   0 19976     0 20180  602   341   1   1  98
> 10  0  6 143432 294816  52384  70168   8 128296     8 128436 2961   502   0   5  95
>  1  0  0 133448 307256  52320  70168 352   0   356    44  225   330   0   1  99

As I wrote, this is a grep problem. I assume that regexp are more 
efficient over long chunks, but there must be a limit - regexp over 
swapped out memory are slow ;-)

I'll send a bugreport to the grep maintainers.

> 
> doesn't apply to 2.4.19
> 

Yes. likely/unlikely changes, and one additional change log entry.


--
	Manfred

