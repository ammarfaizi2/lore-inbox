Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129138AbRBSWIJ>; Mon, 19 Feb 2001 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRBSWH7>; Mon, 19 Feb 2001 17:07:59 -0500
Received: from slc868.modem.xmission.com ([166.70.6.106]:6410 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129352AbRBSWHt>; Mon, 19 Feb 2001 17:07:49 -0500
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: The lack of specification (was Re: [LONG RANT] Re: Linux stifles innovation... )
In-Reply-To: <Pine.LNX.3.96.1010219191533.6201A-100000@artax.karlin.mff.cuni.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Feb 2001 13:02:25 -0700
In-Reply-To: Mikulas Patocka's message of "Mon, 19 Feb 2001 20:11:14 +0100 (CET)"
Message-ID: <m1ofvyzbji.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> writes:

> Imagine that there is specification of mark_buffer_dirty. That
> specification says that
> 	1. it may not block
> 	2. it may block
> 
> In case 1. implementators wouldn't change it to block in stable kernel
> 	relese because they don't want to violate the specification.
> 
> In case 2. implementators of ext2 wouldn't assume that it doesn't block
> 	even if it doesn't in current implementation.

Whenever the question has been asked the answer is always assume anything
in the kernel outside of the current function blocks.  

> In both cases, the bug wouldn't be created.

Nope.  It looks like someone made a mistake in ext2...

> 
> Anytime you change implementation of syscalls, you gotta check all
> applications that use them ;-) Luckily not - because there is
> specification and you can check that syscalls conform to the
> specification, not apps. 

Not normally.  The rule is that syscall don't change period.  The
internal kernel interface is different.  It is allowed to change.

As for syscall changing auditing most apps did happen when the LFS
spec was put together.  So you would have an implementation that would
keep most apps from failing on large files.

> > > Saying "code is the specification" is not good.
> > 
> > I'm not arguing against documentation.  That is dumb.  But the code is
> > ALWAYS canonical.  Not docs.
> 
> Let's see:

> Who is right? If there is no specification....

Hmm.  The developers should get together and pow wow when the problem
is noticed.  When it is finally talked out about how it should happen
then the code should get fixed accordingly.

It isn't about right and wrong it is about working code.  Not that
documenting things doesn't help.  And 2.4 is going in that direction...

Eric
