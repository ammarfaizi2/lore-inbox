Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269316AbTCDHmH>; Tue, 4 Mar 2003 02:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269317AbTCDHmH>; Tue, 4 Mar 2003 02:42:07 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:61652 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S269316AbTCDHmG>;
	Tue, 4 Mar 2003 02:42:06 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303040752.h247qOx20275@csl.stanford.edu>
Subject: Re: [CHECKER] potential deadlocks
To: Nikita@Namesys.COM (Nikita Danilov)
Date: Mon, 3 Mar 2003 23:52:24 -0800 (PST)
Cc: akpm@digeo.com (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <15971.9271.619893.597694@laputa.namesys.com> from "Nikita Danilov" at Mar 03, 2003 12:45:27 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andrew Morton writes:
>  > Dawson Engler <engler@csl.stanford.edu> wrote:
>  > >
>  > > BTW, are there known deadlocks (harmless or otherwise)?  Debugging
>  > > the checker is a bit hard since false negatives are silent...
>  > 
>  > Known deadlocks tend to get fixed.  But I am surprised that you did not
>  > encounter more of them.
>  > 
>  > btw, the filesystem transaction operations can be treated as sleeping locks. 
>  > So for ext3, journal_start()/journal_stop() may, for lock-ranking purposes,
>  > be treated in the same way as taking and releasing a per-superblock
>  > semaphore.  Other filesystems probably have similar restrictions.
>  > 
> 
> So are page-fault and memory allocation events, because thread
> blocks on them, and deadlocks involving servicing page fault or memory
> laundering have definitely been seen.

Do you mean calls to copy_*_user and kmalloc(GFP_WAIT) or did you have
something else in mind as well?

> We have (incomplete) description of kernel lock ordering, which is
> centered around reiser4 locks, but also includes some core kernel stuff.
> 
> It is available at 
> 
> http://www.namesys.com/v4/lock-ordering.dot  --- source for Bell-Labs' dot(1)
> http://www.namesys.com/v4/lock-ordering.ps   --- postscript output, produced from the .dot source

Wonderful; thanks!



