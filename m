Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312608AbSDOM3U>; Mon, 15 Apr 2002 08:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSDOM3T>; Mon, 15 Apr 2002 08:29:19 -0400
Received: from [195.137.26.28] ([195.137.26.28]:53197 "EHLO
	shami.gointernet.co.uk") by vger.kernel.org with ESMTP
	id <S312608AbSDOM3S>; Mon, 15 Apr 2002 08:29:18 -0400
Message-ID: <3CBAC6B3.2040002@gointernet.co.uk>
Date: Mon, 15 Apr 2002 13:25:23 +0100
From: Eugenio Mastroviti <eugeniom@gointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010923
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: ivan <ivan@es.usyd.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory Leaking. Help!
In-Reply-To: <Pine.LNX.4.33.0204151017480.20961-100000@dipole.es.usyd.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ivan wrote:

> This top at 11am
> 10:19am  up 13:23,  6 users,  load average: 0.07, 0.03, 0.01
> 143 processes: 142 sleeping, 1 running, 0 zombie, 0 stopped
> CPU0 states:  0.0% user,  5.0% system,  0.0% nice, 94.0% idle
> CPU1 states:  0.0% user,  1.0% system,  0.0% nice, 98.0% idle
> Mem:  3799080K av, 2215132K used, 1583948K free,    1580K shrd,  377916K 
> buff
> Swap: 8192992K av,       0K used, 8192992K free                 1515392K 
> cached
> 
> Mashine is doing NFS and DNS, not much load?
> 


Perhaps it's worth noting that of those 2.2 GB in use, 1.5 GB are used 
as cache; seems to me there's no leak, your system is just caching as 
much data as it can in memory. The actual memory in use (check with 
'free') is total-(buffers+cache)= 2.2-(0.37+1.51)GB=about 320 MB, which 
seems reasonable enough

Eugenio
-- 
Laissez Faire Economics is the theory that if each acts like a vulture,
all will end as doves.

