Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136393AbRD2WPR>; Sun, 29 Apr 2001 18:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136391AbRD2WPI>; Sun, 29 Apr 2001 18:15:08 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:40975 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136393AbRD2WOx>;
	Sun, 29 Apr 2001 18:14:53 -0400
Date: Mon, 30 Apr 2001 00:14:53 +0200
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
Message-ID: <20010430001453.I11681@unternet.org>
In-Reply-To: <001001c0d0f8$bf5ec5e0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001001c0d0f8$bf5ec5e0$5517fea9@local>; from manfred@colorfullife.com on Mon, Apr 30, 2001 at 12:06:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 12:06:52AM +0200, Manfred Spraul wrote:
> You could enable STATS in mm/slab.c, then the number of alloc and free
> calls would be printed in /proc/slabinfo.
> 
> > Yeah, those as well. I kinda guessed they were related...
> 
> Could you check /proc/sys/net/core/hot_list_length and skb_head_pool
> (not available in /proc, use gdb --core /proc/kcore)? I doubt that this
> causes your problems, but the skb_head code uses a special per-cpu
> linked list for even faster allocations.
> 
> Which network card do you use? Perhaps a bug in the zero-copy code of
> the driver?

I'll give it a go once I reboot into 2.4.4 again (now in 2.4.3 to get some
'work' done). Using the dreaded ne2k cards (two of them), which have caused me
more than one headache already...

I'll have a look at the driver for these cards.

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
