Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271226AbRHTN7X>; Mon, 20 Aug 2001 09:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271231AbRHTN7P>; Mon, 20 Aug 2001 09:59:15 -0400
Received: from [203.161.228.202] ([203.161.228.202]:44306 "EHLO
	spf1.hq.outblaze.com") by vger.kernel.org with ESMTP
	id <S271226AbRHTN7K>; Mon, 20 Aug 2001 09:59:10 -0400
Date: Mon, 20 Aug 2001 22:09:43 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Your ext2 optimisation for readdir+stat
Message-ID: <20010820220942.A18903@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The patch won't work for the 2.2 kernels or 2.4 ext3, since it
> requires that the directories-in-page-cache change.  It's
> theoretically possible to rewrite the change for the old-style
> ext2/3_find_entry code, but (a) the ext2_find_entry() function before
> it was modified to use the page cache is rather icky, and (b) I don't
> particularly care about 2.2 at this point.
> 
> The only reason why I might try to do this work is if we really want
> this optimization in ext3 before we add support for putting
> directories in the page cache (which isn't going to happen before the
> ext3 1.0 release), but as I said, it would require messing with a
> complicated bit of code, and it's not high on my priority list at the
> moment.

I think it would be great to have this for ext3. Andrew Morton has done
a lot of work to make ext3 very usable for MTA applications.
Postfix/qmail use 'find' either in their control script or whilst
providing queue statistics. Your optimisations would greatly speed these
operations up. I believe tarring directory trees might also get a
speedup and maybe cvs operations

Regards, Yusuf

-- 
Yusuf Goolamabbas
yusufg@outblaze.com
