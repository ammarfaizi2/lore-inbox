Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278107AbRJRT5C>; Thu, 18 Oct 2001 15:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278110AbRJRT4x>; Thu, 18 Oct 2001 15:56:53 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10502 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S278108AbRJRT4o>; Thu, 18 Oct 2001 15:56:44 -0400
Date: Thu, 18 Oct 2001 15:57:17 -0400
Message-Id: <200110181957.f9IJvHh06884@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
X-Newsgroups: linux.dev.kernel
In-Reply-To: <200110181632.f9IGW9i29729@schroeder.cs.wisc.edu>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110181632.f9IGW9i29729@schroeder.cs.wisc.edu> nleroy@cs.wisc.edu wrote:

| Perhaps there should be a pair of "mtools" added: mopen and mclose, that do 
| basically this.  That way it could be a "standard" item, documented in man 
| pages, etc., not some secret that only the l-k users know.  Thoughts?

  At the risk of seeming ungenerous, mtools was a hack, to compensate
for the inability of some operating systems to handle the DOS
filesystem. While it's useful, I don't thing blindingly fast performance
is a requirement.

  That said, I have a few other thoughts. First, can't the kernel
detect when a new floppy is inserted? I can't remember if there is an
interupt generated when the floppy seats or not.

  And second, can't you just avoid the whole issue by keeping the floppy
accessed at all time while you use it? Something like:
  sleep 3600 </dev/fd0 &
or some such to lock the pages after they are read?

  The change is a good one, it avoids having stale data in memory which
might cause worse things than slow performance. I think I have been
bitten by that in the past, but I don't remember any details, so it may
have been another problem.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
