Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261306AbSJQKbt>; Thu, 17 Oct 2002 06:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSJQKbt>; Thu, 17 Oct 2002 06:31:49 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:49350 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261306AbSJQKbs>; Thu, 17 Oct 2002 06:31:48 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Posix capabilities
References: <20021016154459.GA982@TK150122.tuwien.teleweb.at>
	<20021017032619.GA11954@think.thunk.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Thu, 17 Oct 2002 12:37:30 +0200
Message-ID: <874rblcpw5.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> Personally, I'm not so convinced that capabilities are such a great
> idea.  System administrators have a hard enough time keeping 12 bits
> of permissions correct on executable files; with capabilities they
> have to keep track of several hundred bits of capabilties flags, which

So you claim, system administrators are stupid people?

> must be set precisely correctly, or the programs will either (a) fail
> to function,

Which you will notice very fast.

> or (b) have a gaping huge security hole.  

Which is not worse, but possibly a lot better, than setuid root.

> This probablem could be solved with some really scary, complex user
> tools (which no one has written yet).  Alternatively you could just
> let programs continue to be setuid root, but modify the executable to
> explicitly drop all the capabilities except for the ones that are
> actually needed as one of the first things that executable does.  It

Which isn't convincing, either. The benefit of capabilities is to
administer your system _without_ relying on someone else doing a
decent job.

> perhaps only gives you 90% of the benefits of the full-fledged
> capabilities model, but it's much more fool proof, and much easier to
> administer.

With capabilities you don't have to resort to programming, which _is_
already an easier way to administer. This also means, distribution
builders, who may not be coders, can contribute to enhance security.

Maybe this sounds like a plea for capabilities and maybe it is, but I
just want to put some things straight. Unless there's something
better, I stay with capabilities.

To be more constructive, I want to point to
<http://www.linux.it/~md/software/ssd.tgz>. This is a modified
start-stop-daemon, which allows to change capabilities. With this
really scary, complex user tool (which to some extent it is, when you
look at the code), I was able to drop all the capabilities except for
the ones that are actually needed. ;-)

Regards, Olaf.
