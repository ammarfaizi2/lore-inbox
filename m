Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRKVQQj>; Thu, 22 Nov 2001 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279984AbRKVQQ3>; Thu, 22 Nov 2001 11:16:29 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:59307 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S279981AbRKVQQW>;
	Thu, 22 Nov 2001 11:16:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: OOM killer in 2.4.15pre1 still not 100% ok
Date: Thu, 22 Nov 2001 08:15:18 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <01112217224700.01298@manta>
In-Reply-To: <01112217224700.01298@manta>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E166wVS-0004Vk-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 22, 2001 11:22, vda wrote:
> Today I saw OOM killer in action for the very fist time.
> Just want to inform that it still not 100% ok (IMHO):
>
> I reconfigured my text box for NFS root fs operation
> and turned off swap. The box has 128M RAM.
...

> 5:01pm  up  1:08,  3 users,  load average: 0.18, 0.10, 0.06
> 61 processes: 58 sleeping, 2 running, 1 zombie, 0 stopped
> CPU states:  1.9% user, 15.6% system,  0.0% nice, 82.3% idle
> Mem:  126272K av, 123428K used,   2844K free,      0K shrd,     16K buff
>Swap:      0K av,      0K used,      0K free                 47748K cached

Er, with almost 3megs of free memory and -47megs- of cache, the problem isn't 
with the OOM killer's selection, but the fact it was triggered with nearly 
half the RAM still usable. Do you actually know the OOM killer was triggered? 
Or did top just mysteriously exit?

Personally, I've found the new 2.4.14+ OOM killer to be highly accurate, I've 
run ext3's shared mappings torture test on my 384meg RAM (256meg swap) box 
repeatedly, and it pushes my computer to OOM every 60 seconds or so. It 
always kills the correct process, with my box remaining absolutely stable, 
even with less swap space than RAM. 

-Ryan
