Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUE1OWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUE1OWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUE1OWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:22:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7882 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263199AbUE1OWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:22:47 -0400
Date: Fri, 28 May 2004 16:22:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Process hangs on blk_congestion_wait copying large file to cifs filesystem
Message-ID: <20040528142239.GK20657@suse.de>
References: <1085672706.4350.9.camel@taz.graycell.biz> <1085753249.2219.13.camel@taz.graycell.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085753249.2219.13.camel@taz.graycell.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28 2004, Nuno Ferreira wrote:
> On Qui, 2004-05-27 at 16:45 +0100, Nuno Ferreira wrote:
> > Hi,
> > I'm trying to copy a large file (200Mb or bigger) from an ext3
> > filesystem to a windows share mounted using CIFS and the cp process
> > hangs, sometimes for a long time (several minutes).
> > Calling ps, I can see that it's blocking on blk_congestion_wait.
> > 
> > Trying to edit a file on the same ext3 filesystem using vi blocks on the
> > same function. However, during that that same time that vi and cp were
> > blocked, I was able to do a "find /usr/share/doc" and it completed
> > normally, in a few seconds.
> > 
> > Eventually the copy succeeds but it takes a long time (20 minutes to
> > copy 200Mb) and the computer is unusable during most of that time.
> > 
> > This is copying from my laptop (IDE disk), the network card is a RTL8139
> > using 8139cp drivers.
> > 
> > Is someone seeing a similiar problem? What extra info is needed to debug
> > it?
> 
> Mmm, anyone with a similar problem? What should I do, make a profile
> like explained in Documentation/basic_profiling.txt or is the above
> information about the function where the processes are "stuck" enough?
> One thing I forgot to mention, during the several minutes the processes
> are stuck on that function there is no disk activity, so it's not the
> processes being starved. In fact, there is no other activity on the
> machine apart from the copy.

A sysrq-t back trace of that process would be interesting to see.

-- 
Jens Axboe

