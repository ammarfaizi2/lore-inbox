Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSDLAUj>; Thu, 11 Apr 2002 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313091AbSDLAUi>; Thu, 11 Apr 2002 20:20:38 -0400
Received: from [195.223.140.120] ([195.223.140.120]:22850 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313089AbSDLAUi>; Thu, 11 Apr 2002 20:20:38 -0400
Date: Fri, 12 Apr 2002 02:20:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Aviv Shavit <avivshavit@yahoo.com>
Cc: Ken Brownfield <ken@irridia.com>, linux-kernel@vger.kernel.org
Subject: Re: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
Message-ID: <20020412022046.B31905@dualathlon.random>
In-Reply-To: <20020411183443.A21005@asooo.flowerfire.com> <20020411235015.78405.qmail@web13203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 04:50:15PM -0700, Aviv Shavit wrote:
> This goes back to my previous post - 
> Applying only the vm patches didn't get me far.
> 
> I'm still trying to pin point what it is thats helping
> me out in -aa

For the level of cache during your workload (you mentioned that variable
in the previous email) what matters mostly is the vm-33 patch. Do you
get significantly different levels of cache with only the vm-33 patch
compared to the whole latest -aa? (there are other variables too that
could influence the level of cache, the readahead boost for example, but
they're much less likely to influence the cache levels than the vm-33
patch)

It maybe the benefit you see is not only in the VM part, but it could
came also the dozen of other fixes and improvements. For example
starting from the lowlatency fixes from Andrew (note: _fixes_) to highio
(from Jens) if you've highmem, to the dyn-sched (from Davide) if you've
tons of sleeping tasks or interactive processes etc...

The reason I maintain the main patches like the vm one also against
mainline, is exactly to address Ken's concern about being able to apply
just one patch if he's not confortable with the whole patchkit, and
secondly to be able to test it separately without the pollution. I feel
the vm patch is one of the most important and that's why I mentioned it
in particular, but the lowlatency fixes and lots of other stuff is
important too. But I've also the feeling the other stuff [modulo the
major things like pte-highmem and highio that at least affects only the
x86 high-end and not that much desktops or little server] is much much
easier to get integrated and that's why I worry much less about it.

Thanks for all the feedback and testing!

Andrea
