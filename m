Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278143AbRJRVCA>; Thu, 18 Oct 2001 17:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278145AbRJRVBv>; Thu, 18 Oct 2001 17:01:51 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:31756 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S278143AbRJRVBq>; Thu, 18 Oct 2001 17:01:46 -0400
Message-Id: <200110182049.f9IKn8i00824@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: davidsen@tmr.com (bill davidsen), linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Thu, 18 Oct 2001 15:47:15 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200110181957.f9IJvHh06884@deathstar.prodigy.com>
In-Reply-To: <200110181957.f9IJvHh06884@deathstar.prodigy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 October 2001 14:57, bill davidsen wrote:
> In article <200110181632.f9IGW9i29729@schroeder.cs.wisc.edu> 
nleroy@cs.wisc.edu wrote:
> | Perhaps there should be a pair of "mtools" added: mopen and mclose, that
> | do basically this.  That way it could be a "standard" item, documented in
> | man pages, etc., not some secret that only the l-k users know.  Thoughts?
>
>   At the risk of seeming ungenerous, mtools was a hack, to compensate
> for the inability of some operating systems to handle the DOS
> filesystem. While it's useful, I don't thing blindingly fast performance
> is a requirement.

Yeah, but they're still handy from time to time.  It's certainly quicker to 
pop a disk in and type "mdir", than to put it in, type "mount /floppy; ls 
/floppy; umount /floppy" or similar.  You get the picture.  Not that you 
don't have a valid point, too.

>   That said, I have a few other thoughts. First, can't the kernel
> detect when a new floppy is inserted? I can't remember if there is an
> interupt generated when the floppy seats or not.

If I'm not mistaken, and I think has already been mentioned somewhere before 
in this thread, these interrupts where determined to be unreliable under some 
circumstances.  Anybody remember the details?

>   And second, can't you just avoid the whole issue by keeping the floppy
> accessed at all time while you use it? Something like:
>   sleep 3600 </dev/fd0 &
> or some such to lock the pages after they are read?

That's basically what I'd propose "mopen" do...  Hold it open 'til the user 
does a "mclose".  Of course, if you yank the disk out in the middle, all bets 
are off.

-Nick
