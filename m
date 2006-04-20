Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWDTOuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWDTOuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDTOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 10:50:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2577 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750798AbWDTOuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 10:50:12 -0400
Date: Thu, 20 Apr 2006 16:50:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-ID: <20060420145041.GE4717@suse.de>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19 2006, Linus Torvalds wrote:
> There are some other buffer management system calls that I haven't done 
> yet (and when I say "I haven't done yet", I obviously mean "that I hope 
> some other sucker will do for me, since I'm lazy"), but that are obvious 
> future extensions:

Well it's worked so far, hasn't it? :-)

>  - an ioctl/fcntl to set the maximum size of the buffer. Right now it's 
>    hardcoded to 16 "buffer entries" (which in turn are normally limited to 
>    one page each, although there's nothing that _requires_ that a buffer 
>    entry always be a page).

This is on a TODO, but not very high up since I've yet to see a case
where the current 16 page limitation is an issue. I'm sure something
will come up eventually, but until then I'd rather not bother.

>  - vmsplice() system call to basically do a "write to the buffer", but 
>    using the reference counting and VM traversal to actually fill the 
>    buffer. This means that the user needs to be careful not to re-use the 
>    user-space buffer it spliced into the kernel-space one (contrast this 
>    to "write()", which copies the actual data, and you can thus re-use the 
>    buffer immediately after a successful write), but that is often easy to 
>    do.

This I already did, it was pretty easy and straight forward. I'll post
it soonish.

-- 
Jens Axboe

