Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316830AbSE1Pqc>; Tue, 28 May 2002 11:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316831AbSE1Pqb>; Tue, 28 May 2002 11:46:31 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:33457 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316830AbSE1Pq3>; Tue, 28 May 2002 11:46:29 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        paul.mckenney@us.ibm.com, andrea@suse.de
Subject: Re: 8-CPU (SMP) #s for lockfree rtcache
In-Reply-To: <20020528171104.D19734@in.ibm.com> <20020528.042514.92633856.davem@redhat.com> <20020528182806.A21303@in.ibm.com> <20020528.054043.06045639.davem@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 28 May 2002 17:45:56 +0200
Message-ID: <m3bsb06zt7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Tue, 28 May 2002 18:28:06 +0530
>    
>    Well, the last time RCU was discussed, Linus said that he would
>    like to see someplace where RCU clearly helps.
> 
> Alexey and I are in firm agreement that the routing cache
> clearly benefits from RCU.

The next obvious benefitor IMHO is module unloading. Just putting 
a synchronize_kernel() somewhere at the end of sys_delete_modules()
after the destructor makes module unloading much less nasty than it 
used to be (yes it doesn't fix all possible module unload races, but a 
large share of them and it makes the problem much more controllable) 

-Andi
