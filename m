Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264948AbTLRGOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 01:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTLRGOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 01:14:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:48522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264948AbTLRGN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 01:13:57 -0500
Date: Wed, 17 Dec 2003 22:14:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0
Message-Id: <20031217221432.4e1bbd60.akpm@osdl.org>
In-Reply-To: <shsekv2ptcb.fsf@guts.uio.no>
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
	<20031217211516.2c578bab.akpm@osdl.org>
	<shsekv2ptcb.fsf@guts.uio.no>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> 
> Congratulations Linus and Andrew...

Let's first see how embarrassing the next week proves to be...

> Will you be posting a plan for how you want the 2.6.x series to
> proceed? I gather I'm not alone in having a load of patches that I'd
> like to send you ASAP...

I believe that the processes we've all been using for the past year have
worked well (invitation here for people to disagree).  So any changes we
make to that process shouldn't be arbitrary.

I expect that until 2.7.0 forks, Linus and I shall continue to work 2.6.x
in much the same manner - that's what I'd prefer, anyway.

Obviously, the threshold for merging things into 2.6 becomes higher, and
large changes will be rejected pending more review and testing.  I shall
continue to run an alternate tree for the provision of that testing
service.

Generally, we should expect that there will be large changes across the 2.6
lifetime - it is unrealistic to believe otherwise.  We just need to find
the processes to absorb those changes (and feed them into or from 2.7.x)
without breaking stuff.  We've done that fairly well across 2.5 I think.


We should sit tight for the next week or so, in case we need to rush out a
2.6.1 for brown-bag bugs.  After that I need to shrink the -mm patchset
rather a lot.

> Here's a brief commentary on the NFS client related sections in your 2
> todo lists, as well as on outstanding client issues:

Nick has been maintaining these lists lately - hopefully he can send me an
update for NFS, thanks.

> Must fix:
>   - The mmap-versus-truncate NFS problem appears to be a lot more
>     difficult to reproduce these days. I need a call for testing to
>     verify that the problem still exists.
>   - I'm mystified by Andi's comments about RPC having lots of
>     uninterruptible waits. It sounds to me as if he is confusing the
>     "soft" and "intr" options. The two are very distinct...
> 
> Should fix:
>   - The VFS support for atomic open() has already been merged by Linus
>     (as well as the NFSv2/v3 support). I still have a couple of
>     trivial bugfixes for the VFS case (one place where we used O_READ
>     instead of FMODE_READ, and one place where the "intent" is not
>     filled in at all). NFSv4 support needs for atomic open to be
>     merged in (this will fix several NFSv4 file creation races).
> 
> 
> Not listed in either:
>   - There are a few lockd fixes that need to be forward-ported from
>     2.4.x.
> 
>   - A *lot* of progress has been made on the NFSv4 client. I would
>     very much like to merge this into 2.6.x ASAP, since it concerns
>     rather critical subjects such as adding support for locking, and
>     reboot recovery (as well as lots of stability fixes). What are
>     your feelings on a timeframe for this sort of thing?

I doubt that people will be critially dependent on NFS4 client
functionality in 2.6 for a while, and your changes will only affect NFS4,
so go wild.

If the change was more intrusive then it would be better to
maintain+develop it in -mm until we've all happy, then merge it across.

>   - The RPCSEC_GSS support for NFSv2/v3 was merged in before it had
>     been thoroughly tested and reviewed. It contains a couple of
>     serious bugs that need to be ironed out.
> 
> If you want info beyond this mail, then my current set of NFS client
> patches may be found on
> 
>    http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.0-test11
> 
> The file HEADER.html contains a list of patches and a brief
> description of what each patch does. That should give an idea of how
> much is currently outstanding (I still expect the list to continue
> growing - I'm still working on several NFSv4 subtopics).

OK.

