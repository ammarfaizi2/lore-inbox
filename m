Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268835AbTCCWpJ>; Mon, 3 Mar 2003 17:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268836AbTCCWpJ>; Mon, 3 Mar 2003 17:45:09 -0500
Received: from [195.223.140.107] ([195.223.140.107]:23181 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S268835AbTCCWpF>;
	Mon, 3 Mar 2003 17:45:05 -0500
Date: Mon, 3 Mar 2003 23:57:03 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Larry McVoy <lm@work.bitmover.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Arador <diegocg@teleline.es>,
       "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030303225702.GP16918@dualathlon.random>
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030302014915.34a6de37.diegocg@teleline.es> <1046571336.24903.0.camel@irongate.swansea.linux.org.uk> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <20030302020907.GE1364@dualathlon.random> <3E623F37.6060005@pobox.com> <20030302181615.GA25902@dualathlon.random> <20030303183734.GB21701@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030303183734.GB21701@work.bitmover.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 10:37:34AM -0800, Larry McVoy wrote:
> How close is http://www.bitmover.com/EXPORT to what you want (3MB file).
> 
> Note that this is very coarse granularity, it's very 2.5.62 up to 2.5.63,

I'm probably missing something obvious but it's not clear to me how to
extract the changeset info from this format.

Let's assume I want to extract this changeset:

hangeSet@1.1021, 2003-02-24 10:49:30-08:00, randy.dunlap@verizon.net
  [PATCH] convert /proc/io{mem,ports} to seq_file

  This converts /proc/io{mem,ports} to the seq_file interface
  (single_open).

How can I?

I mean, the above format is fine, as far as we have a file like that per
changeset (or alternatively per Linus's merge, even if not for every
single changeset, when he does the pulls). Clearly a file of that format
for a 2.5.62->63 diff is not finegrined enough.

Correct me if I'm wrong but if I understand well the changeset numbers
aren't fixed in the bitkeeper tree, a changeset number can change while
the merging happens across different cloned trees. So in short, the
changeset numbers are useless to the outside (but still providing them
won't hurt as far as nobody rely on them).

> in practice the granularity would be as least as fine as each of Linus'
> pushes and finer if possible.  We can't capture all the branching structure
> in patches, there is too much parallelism, but what we can do is capture
> each push that Linus does and if he did more than one merge in that push,
> we can break it up into each merge.  
> 
> We can also provide this as a BK url on bkbits for any cset or range of
> csets (we'll have to get another T1 line but I don't see way around that).

If that hurts, you could simply upload them to kernel.org.  Even if it's
not a file, can't you simply checkin into a remote cvs on kernel.org or
osdl.org or sourceforge, or whatever else place, so you won't need to
pay for it. It's up to you of course, but I'm sure you're not forced to
pay for this service (besides for the once-a-time setup of the exports,
that I hope won't generate any maintainance overhead to you).

> This should give enough information that anyone could build their own 
> BK 2 SVN gateway (or whatever, we're doing the CVS one).

Yes, as far as this file-format is per-merge I think this is all we
need. This way it will be usable to checkout, browse and regenerate the
tree, unlike the cset directory currently in kernel.org.

> Also, here's what Linus' recent pushes look like WITHOUT breaking it into
> each merge, we're still working on that code:
> 
>      57 csets on 2003/03/03 08:49:44 
>       5 csets on 2003/03/02 21:30:31 
>      28 csets on 2003/03/02 21:04:02 
>       1 csets on 2003/03/02 10:19:24 
>      49 csets on 2003/03/01 19:03:58 
>       2 csets on 2003/03/01 11:04:04 
>       5 csets on 2003/03/01 09:19:24 
>       1 csets on 2003/02/28 19:34:30 
>      37 csets on 2003/02/28 15:30:29 
>       8 csets on 2003/02/28 15:18:12 
>      23 csets on 2003/02/28 15:05:08 
>      31 csets on 2003/02/27 23:30:05 
>      16 csets on 2003/02/27 09:15:07 
>      11 csets on 2003/02/27 07:45:06 
>      47 csets on 2003/02/26 23:09:53 
>      32 csets on 2003/02/25 21:35:34 
>      24 csets on 2003/02/25 18:34:41 
>      22 csets on 2003/02/25 15:49:41 
>      14 csets on 2003/02/24 21:23:34 
>       3 csets on 2003/02/24 15:19:44 
>       1 csets on 2003/02/24 11:16:14 
>      15 csets on 2003/02/24 11:00:36 
>       4 csets on 2003/02/24 10:48:49 
>       1 csets on 2003/02/24 10:03:36 
>      15 csets on 2003/02/24 09:49:34 
>       1 csets on 2003/02/23 20:33:00 
>       3 csets on 2003/02/23 11:15:28 
>       8 csets on 2003/02/23 11:01:10 
>       6 csets on 2003/02/23 10:49:14 
>       2 csets on 2003/02/22 19:32:35 
>       4 csets on 2003/02/22 16:17:27 
>       1 csets on 2003/02/22 12:45:28 
>      76 csets on 2003/02/22 12:34:13 
>       1 csets on 2003/02/21 20:18:19 
>       6 csets on 2003/02/21 19:49:32 
>      86 csets on 2003/02/21 18:03:23 
>       3 csets on 2003/02/21 16:18:24 
>      30 csets on 2003/02/21 14:14:48 
>       1 csets on 2003/02/21 10:18:19 
>       1 csets on 2003/02/21 09:49:15 

Just curious, this also means that at least around the 80% of merges
in Linus's tree is submitted via a bitkeeper pull, right?

Andrea
