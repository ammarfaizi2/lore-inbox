Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311475AbSDNALF>; Sat, 13 Apr 2002 20:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311483AbSDNALE>; Sat, 13 Apr 2002 20:11:04 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:58104
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311475AbSDNALD>; Sat, 13 Apr 2002 20:11:03 -0400
Date: Sat, 13 Apr 2002 17:13:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -aa VM updates for 2.5
Message-ID: <20020414001323.GV23513@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020413233906.GB10807@matchmail.com> <3CB8C55F.ECD143F7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I'm just taking about the VM-xx patch from -aa, not some of the more
controversial patches in -aa.

On Sat, Apr 13, 2002 at 04:55:11PM -0700, Andrew Morton wrote:
> Mike Fedyk wrote:
> > 
> > Why haven't any of the -aa VM updates gone into 2.5?  Especially after Andrew
> > Morton has split it up this is surprising...
> 
> I don't think there's really any point in doing that.
> 
> None of the regular VM guys are really working 2.5 at this time.
> 
> VM has a close relationship with buffers, so tinkering
> with the VM while I'm busily driving a truck through the
> buffer layer and setting up new writeback mechanisms
> would represent some wasted effort.

Yep, make sense.  Though, keeping in mind the changes that are in -aa may
help when making changes to the buffer layer, and possibly less effort if a
problem is already fixed in -aa but not in 2.5.

> We don't know yet whether 2.5 will have a reverse-mapping
> VM.  If it does, then maintenance work against the current
> one is wasted effort and more patching pain.
>

It looks like most of the vm changes can just be dropped into 2.5 over a few
-pres.  Especially since few (none?) have argued that the -aa vm-patch
causes regressions.

> (I'd also like to investigate the option of not throttling
>  page allocators by making them wait on I/O - make them
>  wait on pages coming free instead).
>

Sounds interesting.

> So.  My vote would be that unless the VM is actually impeding
> developers who are working on other parts of the kernel (it
> is not) then just leave it as-is for the while.
>

What about the recent threads on swapping in 2.5?

Merging the -aa vm-patch into 2.5 will allow people to develop on the best
known -aa VM to date, and can reduce duplicated effort.  Though, admittedly
it doesn't make much sense to do the same work on 2.4 and 2.5 at the same
time (vm patch merging).  Maybe it'll just be forward ported from 2.4...

Mike
