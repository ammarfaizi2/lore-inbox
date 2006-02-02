Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWBBPX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBBPX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWBBPX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:23:29 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:37647 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751139AbWBBPX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:23:29 -0500
Date: Thu, 2 Feb 2006 15:23:16 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060202152316.GC8944@ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602022214.52752.nigel@suspend2.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please take a look at /dev/snapshot.
> >
> > Parse error at the first sentence (too many nots), anyway:
> >
> > 1) we do not want two implementations of same code in kernel. [swsusp
> > vs. pmdisk was a mess]
> >
> > 2) we are not going to merge code into kernel, when it is possible to
> > do same thing in userspace. (*)
> >
> > 3) backwards compatibility is important in stable series.
> >
> > 4) merging code into kernel is a lot of work.
> >
> > I do not think I want to remove swsusp from kernel. Even if I wanted
> > to, there's 3). That means suspend2 should not go in (see 1). Even if I
> > removed swsusp from kernel, suspend2 is not going to be merged,
> > because of 2). Even if world somehow forgot that it is possible to do
> > suspend2 in userspace, merging 10K lines of code is (4) still lot of
> > work.
> >
> > Oops, that looks bad for suspend2 merge. I really think you should
> > take a look at /dev/snapshot. Unless it is terminally broken, I can't
> > see how suspend2 could be merged.
> 
> I don't want to argue Pavel. I want to give users the best suspend to disk 
> implementation they can get. If you want to argue, you can do so with 

I want to create best suspen that can be still merged into kernel; I
guess thats the difference. Anyway I believe that most of suspend
should be done in userspace -- most of it can. But I guess you need to
hear it from Linus/Andrew, so...

> yourself. Meanwhile, I'll work on getting Suspend2 ready for merging, and let 
> Andrew and Linus decide what they think should happen. If they want to step 
> in now and tell me not to bother, I'll happily listen and just maintain the 

Ahha, so that was the missing piece of puzzle.
						Pavel


-- 
Thanks, Sharp!
