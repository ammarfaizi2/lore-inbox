Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVDIQXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDIQXJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 12:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVDIQXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 12:23:08 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:64111 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261354AbVDIQWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 12:22:54 -0400
Date: Sat, 9 Apr 2005 12:17:58 -0400
From: David Roundy <droundy@darcs.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409161748.GM14943@abridgegame.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <1112858331.6924.17.camel@localhost.localdomain> <87d5t73pnf.fsf@osv.topcon.com> <20050407103018.GA22906@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407103018.GA22906@merlin.emma.line.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 12:30:18PM +0200, Matthias Andree wrote:
> On Thu, 07 Apr 2005, Sergei Organov wrote:
> > darcs? <http://www.abridgegame.org/darcs/>
> 
> Close. Some things:
> 
> 1. It's rather slow and quite CPU consuming and certainly I/O consuming
>    at times - I keep, to try it out, leafnode-2 in a DARCS repo, which
>    has a mere 20,000 lines in 140 files, with 1,436 changes so far, on a
>    RAID-1 with two 7200/min disk drives, with an Athlon XP 2500+ with
>    512 MB RAM. The repo has 1,700 files in 11.5 MB, the source itself
>    189 files in 1.8 MB.
> 
>    Example: darcs annotate nntpd.c takes 23 s. (2,660 lines, 60 kByte)
> 
>    The maintainer himself states that there's still optimization required.

Indeed, there's still a lot of optimization to be done.  I've recently made
some improvements recently which will reduce the memory use (and speed
things up) for a few of the worst-performing commands.  No improvement to
the initial record, but on the plus side, that's only done once.  But I was
able to cut down the memory used checking out a kernel repository to 500m.
(Which, sadly enough, is a major improvement.)

You would do much better if you recorded the initial state one directory at
a time, since it's the size of the largest changeset that determines the
memory use on checkout, but that's ugly.

> Getting DARCS up to the task would probably require some polishing, and
> should probably be discussed with the DARCS maintainer before making
> this decision.
> 
> Don't get me wrong, DARCS looks promising, but I'm not convinced it's
> ready for the linux kernel yet.

Indeed, I do believe that darcs has a way to go before it'll perform
acceptably on the kernel.  On the other hand, tar seems to perform
unacceptably slow on the kernel, so I'm not sure how slow is too slow.
Definitely input from interested kernel developers on which commands are
too slow would be welcome.
-- 
David Roundy
http://www.darcs.net
