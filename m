Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVF1WzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVF1WzK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVF1WyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:54:05 -0400
Received: from waste.org ([216.27.176.166]:52099 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261482AbVF1WvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:51:19 -0400
Date: Tue, 28 Jun 2005 15:49:46 -0700
From: Matt Mackall <mpm@selenic.com>
To: Sean <seanlkml@sympatico.ca>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Petr Baudis <pasky@ucw.cz>,
       Christopher Li <hg@chrisli.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050628224946.GU12006@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <20050628180157.GI12006@waste.org> <62CF578B-B9DF-4DEA-8BAD-041F357771FD@mac.com> <3886.10.10.10.24.1119991512.squirrel@linux1> <20050628221422.GT12006@waste.org> <3993.10.10.10.24.1119997389.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3993.10.10.10.24.1119997389.squirrel@linux1>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 06:23:09PM -0400, Sean wrote:
> On Tue, June 28, 2005 6:14 pm, Matt Mackall said:
> >> You can even have a setup where objects
> >> are archived onto write-once media like DVD and still participate in a
> >> live repository, where new objects are written to hard disk, but older
> >> object are (automatically) sourced from the DVD.
> >
> > Have fun with that. It's an excellent way to destroy your DVD drive.
> 
> Oh come on, stop the FUD.   You pack all the objects up into a single pack
> file (see new feature in Git) and you burn it _once_ to dvd or cdrom.

And even as one big file, it will _still_ be layed out on disk in
pessimal order.

> > Git's completely structureless filename hashing pretty much guarantees
> > that disk layout will degrade to worst-case random access behavior
> > over time. Just walking through the 2000 commit blobs in the current
> > tree can take minutes cold cache on a fast hard disk. Walking the 1700
> > tree blobs in a given version takes quite a while too.
> >
> > Put that on a DVD and that could easily turn into hours of continuous
> > seeking for a simple operation like checking out tip of tree.
> >
> > And as far as I know, ISO9660 and UDF don't really handle huge
> > directories well. So if you try and put the whole kernel history (200k
> > files, some huge number of directory blobs, and 30k-60k commit blobs)
> > on a DVD, you'll be really hurting.
> >
> > Meanwhile the whole history (>30k changesets) with Mercurial fits on a
> > regular CD, with reasonable directory sizes and I/O patterns.
> >
> > Not that it's really worth the trouble. It takes longer for me to burn
> > an ISO image to disc than to download a complete kernel repo from
> > kernel.org.
> >
> 
> Git is still developing, there will be new ways to seek and cache things
> etc eventually that remove any performance issue.

Again, have fun with that. Mercurial already went down this path a
month ago, discovered it couldn't reasonably be fixed without
abandoning the hashes as file name scheme, and changed repo layout.

Git's going to have a much harder time as it's pretty solidly tied to
lookup by contents hash. If you throw that out, you might as well use
Mercurial.

-- 
Mathematics is the supreme nostalgia of our time.
