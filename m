Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbTAFJdv>; Mon, 6 Jan 2003 04:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbTAFJdv>; Mon, 6 Jan 2003 04:33:51 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:3343 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266354AbTAFJdu>; Mon, 6 Jan 2003 04:33:50 -0500
Date: Mon, 6 Jan 2003 09:43:17 +0000
To: lvm-devel@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] dm fs?
Message-ID: <20030106094316.GC2543@reti>
References: <20030105213728.GA8239@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030105213728.GA8239@gtf.org>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 04:37:28PM -0500, Jeff Garzik wrote:
> What is the status of dmfs going into mainline?
> 
> I saw that Greg KH posted a patch with some corrections to dmfs for
> 2.5.50?
> 
> IMO it would be nice to have a kernel config option that makes the
> ioctl method optional when dmfs is set to y or m in kernel config.
> That will not only save a bit of code space, but it will also serve to
> encourage use of dmfs.  :)

The last version I released is here: 

http://people.sistina.com/~thornber/patches/2.5-unstable/2.5.51/2.5.51-dmfs-1.tar.bz2

There are still a couple of easy to fix issues with it (eg. the
kmalloc while a spin lock is held that Andrew Morton pointed out :).

Both Andrew Morton and Greg KH expressed concerns with the way I've
mapped the dm semantics onto the filesystem
(http://marc.theaimsgroup.com/?l=linux-kernel&m=103975736919315&w=2).
So Greg is currently trying to get a sysfs interface working.

We need to get a concensus of opinion in the community as to what is a
good interface.  I'm not going to be rushed into including something
in dm that could cause critism for years to come.  dmfs is what
Alasdair Kergon and I have proposed, we're just waiting for an
alternative to kick off the discussions ATM.

- Joe
