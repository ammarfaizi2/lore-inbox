Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316848AbSGHLhH>; Mon, 8 Jul 2002 07:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSGHLhG>; Mon, 8 Jul 2002 07:37:06 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:15371 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S316848AbSGHLhE>; Mon, 8 Jul 2002 07:37:04 -0400
Date: Mon, 8 Jul 2002 12:39:28 +0100
From: John Levon <levon@movementarian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@conectiva.com.br>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Enhanced profiling support (was Re: vm lock contention reduction)
Message-ID: <20020708113928.GA80073@compsoc.man.ac.uk>
References: <3D27AC81.FC72D08F@zip.com.au> <Pine.LNX.4.44.0207061949240.1558-100000@home.transmeta.com> <3D27B9EA.E68B11E@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D27B9EA.E68B11E@zip.com.au>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Excuse the quoting, I was out of the loop on this ...]

On Sat, Jul 06, 2002 at 08:47:54PM -0700, Andrew Morton wrote:

> Linus Torvalds wrote:
> > 
> > I haven't had much time to look at the oprofile thing, but what I _have_
> > seen has made me rather unhappy (especially the horrid system call
> > tracking kludges).

It makes me very unhappy too. There are a number of horrible things
there, mostly for the sake of convenience and performance.
sys_call_table is just the most obviously foul thing.  I'm glad to hear
there is interest in getting some kernel support for such things to be
done tastefully.

> > I'd rather have some generic hooks (a notion of a "profile buffer" and
> > events that cause us to have to synchronize with it, like process
> > switches, mmap/munmap - oprofile wants these too), and some generic helper
> > routines for profiling (turn any eip into a "dentry + offset" pair
> > together with ways to tag specific dentries as being "worthy" of
> > profiling).

How do you see such dentry names being exported to user-space for the
profiling daemon to access ? The current oprofile scheme is, um, less
than ideal ...

> So.  John.  Get coding :-)

I'm interested in doing so but I'd like to hear some more on how people
perceive this working. It essentially means a fork for a lot of the
kernel-side code, so it'd mean a lot more work for us (at least until I
can drop the 2.2/2.4 versions).

regards
john

-- 
"If a thing is not diminished by being shared, it is not rightly owned if
 it is only owned & not shared."
	- St. Augustine
