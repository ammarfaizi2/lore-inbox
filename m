Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbULFHOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbULFHOU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 02:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbULFHOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 02:14:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62627 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261201AbULFHOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 02:14:16 -0500
Date: Mon, 6 Dec 2004 08:13:39 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
Message-ID: <20041206071335.GA10498@suse.de>
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041206002954.GA28205@optonline.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05 2004, Jeff Sipek wrote:
> On Sun, Dec 05, 2004 at 07:58:45PM +0100, Jens Axboe wrote:
> > It should be really easy to try some rudimentary prio io support - just
> > scale the time slice based on process priority. A few lines of code
> > change, and io priority now follows process cpu scheduler priority. To
> > work really well, the code probably needs a few more limits besides just
> > slice time.
> 
> I started working on the rudimentary io prio code, and it got me
> thinking...  Why use the cpu scheduler priorities? Wouldn't it make
> more sense to add io_prio to task_struct? This way you can have a
> process which you know needs a lot of CPU but not as much io, or the
> other way around.
> 
> What do you think?

I don't like tieing them together, see various threads in the list
archives for discussions about that. I just said that it would be easy
to test basic support this way, since you only have to change a few
lines.

I've already posted the glue code to set/query process priorities, I
would plan on just using something like that again.

-- 
Jens Axboe

