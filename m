Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129549AbRBQB7o>; Fri, 16 Feb 2001 20:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131492AbRBQB7f>; Fri, 16 Feb 2001 20:59:35 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:31492 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129549AbRBQB7V>;
	Fri, 16 Feb 2001 20:59:21 -0500
Date: Sat, 17 Feb 2001 02:58:47 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Matt D. Robinson" <yakker@alacritech.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux stifles innovation...
Message-ID: <20010217025847.A5685@almesberger.net>
In-Reply-To: <Pine.LNX.4.33.0102161843490.2548-100000@asdf.capslock.lan> <3A8DC2A7.43C7A5C3@alacritech.com> <20010217013422.A3055@almesberger.net> <3A8DCBE2.7A5D311@alacritech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A8DCBE2.7A5D311@alacritech.com>; from yakker@alacritech.com on Fri, Feb 16, 2001 at 04:54:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt D. Robinson wrote:
> Actually I do.  Perhaps I should define enterprise as "big iron".  In
> that way, enterprise kernels would be far more innovative than a
> secure kernel (which cares less about performance gains and large
> features and more about just being "secure").

Hmm, and if you want a secure "big iron" ? Do you then start another
branch merging from both lines, or try to merge all the "enterprise"
enhancements into the "secure" system or vice versa ? If the latter
is easy, why was the split needed in the first place ? If it isn't
easy, will you succeed ? After all, you're facing the integration of
a large portion of code, and you only have a probably small "special
interest" group of people for it.

> In fact, I think
> if some of these vendors created their own kernel trees, it would
> inevitably lead to inclusion of the best features into the primary
> kernel tree.  Where's the harm in that?

Temporary splits or "private" add-ons are not a problem. In fact,
this happens all the time. If there are more fundamental and
permanent splits, I would expect it to become increasingly difficult
to maintain compatibility for components. This should affect drivers
first, then deeper regions of the kernel (e.g. networking, then MM).

Actually, there is a live experiment of this nature going on: with
BSD, you have several specialized lines. I'm not following their
development, but maybe somebody who does could comment on how they
compare in terms of compatibility among themselves, and in terms of
features/drivers with Linux.

Also, code that is supposed to run on multiple platforms easily
degenerates into a wild collection of #ifdefs, or requires the
addition of further abstraction layers. (*) Again, the quality of BSD
drivers (both in readability and efficiency) should be indicative for
whether my assumption is true.

(* Further abstraction layers can sometimes be very efficient, e.g.
   the UP/SMP support in Linux. The hard part is to put them at the
   right place. If your kernels are sufficiently different, you may
   end up with translation modules at fairly deep layers, e.g.
   instead of, say, VFS in all kernels providing the same set of
   functions, you'd translate between VFS variants in your file
   system driver, which is probably less efficient, and much more
   likely to result in bugs.)

In my personal experience, it's already painful enough to maintain
a piece of software that should run in 2.2 and 2.3 kernels, despite
rather good compatibility support.

> And I don't think that convergence happens quickly or efficiently
> enough, despite all the great work Linus and Alan do.

One of the largest obstacles to covergence that I've seen so far is
that some groups isolate their work too much. Rapid convergence is
only possible if all relevant parties understand what's going on, at
least at the point of what happens at interfaces. This means that
large projects should be done openly, with occasional announcements
on linux-kernel. Building that killer subsystem in-house until
perfection is reached, and then submitting a multi-megabyte patch
isn't going to make anybody happy.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
