Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUFTOV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUFTOV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUFTOV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:21:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31724 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265508AbUFTOTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:19:45 -0400
Date: Sun, 20 Jun 2004 16:19:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.6 & 2.6.7 sometime hang after much I/O
Message-ID: <20040620141936.GA14787@suse.de>
References: <Pine.LNX.4.44.0406201123240.26522-100000@korben.citd.de> <40D56700.2030206@yahoo.com.au> <20040620115908.GA27241@citd.de> <40D58B93.4040304@yahoo.com.au> <20040620141734.GA28048@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620141734.GA28048@citd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20 2004, Matthias Schniedermeyer wrote:
> On Sun, Jun 20, 2004 at 11:05:23PM +1000, Nick Piggin wrote:
> > Matthias Schniedermeyer wrote:
> > 
> > >Here we go.
> > >
> > >Addendum: After some time more and more konsole froze. Up to the point
> > >where i (had to) kill(ed) X(CTRL-ALT-Backspace) and after i couldn't
> > >even log in at the console anymore i rebooted (into 2.6.5). Then i
> > >recompiled 2.6.7 with SYSRQ-support and tried to reproduce the hanging
> > >without X. After 3 runs i "gave up" and started X. Here i had luck and
> > >the process ('cut-movie.pl') froze at first try. Then i killed X and did
> > >the above on the console.
> > >
> > >As the system is currently unsuable enough to reboot, i will reboot in
> > >2.6.5 after this mail, but i can always reboot into 2.6.7 if you need
> > >more input.
> > >
> > >
> > 
> > The attached trace was with 2.6.7, right?
> 
> Yes.
> 
> > Can you reproduce the hang, then, as root, do:
> > 
> > 	echo 1024 > /sys/block/sda/queue/nr_requests
> > 
> > Replace sda with whatever devices your hung processes were
> > doing IO to. Do things start up again?
> 
> 1 try (with X) with unchanged nr_requests. (I was stupid enough to issues the
> command on the wrong HDD :-) )
> (AFAIR i had the same situation with 2.6.6, sometimes the hang didn't happen)
> 
> 6 tries (with X) with nr_requests=1024 and no hang.
> 
> 1 try with nr_requests back to 128 and now it hangs.
> now changing to nr_request=1024 doesn't seem to change anyting, my
> konsoles start to freeze.
> 
> 
> Don't know if it is relevant but the bytes transfered are always rougly
> around 3000-3400MB (1500-1700 MB read & 1500-1700 MB write. The program
> reads 100MB, then writes 100MB, then issues "sync", the hangs happend
> always about every after 15-17 "rounds")

(missed the initial report) - what io hardware are you using?

-- 
Jens Axboe

