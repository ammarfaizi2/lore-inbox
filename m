Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264303AbTLKCXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 21:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTLKCXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 21:23:52 -0500
Received: from findaloan.ca ([66.11.177.6]:18095 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S264303AbTLKCXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 21:23:49 -0500
Date: Wed, 10 Dec 2003 20:53:48 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>,
       Witukind <witukind@nsbm.kicks-ass.org>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031211015348.GA23489@mark.mielke.cc>
References: <3FD78645.9090300@wmich.edu> <Pine.LNX.4.44.0312110046350.3331-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312110046350.3331-100000@gaia.cela.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 12:48:35AM +0100, Maciej Zenczykowski wrote:
> > I'm not saying module use is more memory efficient than not or vice 
> > versa, but if memory usage in the 100K range is going to be the only 
> > argument for autoloading/unloading of modules then it's really _not_ 
> > worth the effort unless someone can give that kind of support without 
> > trying.  Your fight for memory efficiency should start where the 
> > inefficiency is the largest, and work it's way down, not the other way 
> > around.
> That's not quite true - all kernel memory is statically mapped into ram 
> and unswappable.  2 MB's of X will likely end up 80% swapped to disk and 
> the rest is in use (and can still be swapped out when no longer needed). 
> 100KB of an unused driver will not get swapped out.  
> That's where the difference is.  As for using small userspace?  I do, 
> djbdns for dns, twm for window manager etc etc...

I was under the impression, that on the x86 processors, it is not
possible to have more than ~640Kb of 'unswappable' memory. Everything
else *is* swappable.

Perhaps somebody with understanding could enlighten us on this point?

Is kernel code swappable if compiled in statically? I have assumed
that it is.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

