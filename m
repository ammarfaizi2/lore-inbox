Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbTCNH61>; Fri, 14 Mar 2003 02:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263271AbTCNH61>; Fri, 14 Mar 2003 02:58:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53482 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263270AbTCNH6Z>;
	Fri, 14 Mar 2003 02:58:25 -0500
Date: Fri, 14 Mar 2003 09:09:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: [2.4] init/do_mounts.c::rd_load_image() memleak
Message-ID: <20030314080911.GY836@suse.de>
References: <20030313210144.GA3542@linuxhacker.ru> <20030313220308.A28040@flint.arm.linux.org.uk> <20030314105032.A17568@namesys.com> <20030314075957.GX836@suse.de> <20030314110421.A28273@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030314110421.A28273@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Oleg Drokin wrote:
> Hello!
> 
> On Fri, Mar 14, 2003 at 08:59:57AM +0100, Jens Axboe wrote:
> 
> > > > > +	if (buf)
> > > > > +		kfree(buf);
> > > > kfree(NULL); is valid - you don't need this check.
> > > Almost every place I can think of does just this, so I do not see why this
> > > particular piece of code should be different.
> > Since when has that been a valid argument? :)
> 
> Well, my argument is code uniformness which was always valid as long
> as it does not introduce any bugs, I think.

I agree with that.

> Do you propose somebody should go and fix all
> if ( something )
> 	kfree(something);
> pieces of code to read just
> kfree(something); ?

No that would just be another pointless exercise in causing more
annoyance for someone who has to look through patches finding that one
hunk that breaks stuff. The recent spelling changes come to mind.

But just because you don't seem to have seen any kfree(NULL) in the
kernel does not mean they are not there. And should a good trend not
allow to grow?

-- 
Jens Axboe

