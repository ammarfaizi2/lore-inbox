Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132829AbRDDO0c>; Wed, 4 Apr 2001 10:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDDO0Y>; Wed, 4 Apr 2001 10:26:24 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:65215 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S132828AbRDDOZL>;
	Wed, 4 Apr 2001 10:25:11 -0400
Date: Wed, 4 Apr 2001 16:24:23 +0200
From: David Weinehall <tao@acc.umu.se>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PIDs
Message-ID: <20010404162423.C24478@khan.acc.umu.se>
In-Reply-To: <27525795B28BD311B28D00500481B7601F115A@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <27525795B28BD311B28D00500481B7601F115A@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Wed, Apr 04, 2001 at 04:17:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 04:17:45PM +0200, Heusden, Folkert van wrote:
> Finished & tested my random PID kernel/fork.c:get_pid() replacement.
> This one keeps track of the last N (default is 64) pids who have exited.
> These are then not used. So, one cannot have more then 32767 - (64 + 1
> (init) + 1 (idle)) = 32761 processes :o)

Huh, should be 32701, right?!

> I know that it was all implemented before, but this patch is very small 
> and I couldn't stand the idea the fact that my last announcement was for
> a patch which didn't work at all :o)
> 
> One can find it at: http://www.vanheusden.com/Linux/kernel_patches.php3
> (or: http://www.vanheusden.com/Linux/fp-2.2.19.patch.gz but then you
> miss the list of other patches ;-])
> Patch is against kernel 2.2.19.
> 
> I did not do any performance tests, but the machine I tested it on
> (300MHz dec alpha) felt (felt?) as smooth as before :o)
> 
> 
> Folkert van Heusden
> 
> [ www.vanheusden.com ]
> 
> p.s. the patch mentioned above also raises the number of pool-words
> from 128 to 2048, adds code to do_exit which tells you if the idle
> task is killed (as in 2.4.x), and replaces
> net/core/utils.c:net_[s]random() with something which uses
> get_random_bytes().


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
