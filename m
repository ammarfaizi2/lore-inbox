Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSLVS7i>; Sun, 22 Dec 2002 13:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSLVS7i>; Sun, 22 Dec 2002 13:59:38 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:22498
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S265140AbSLVS7h>; Sun, 22 Dec 2002 13:59:37 -0500
Message-ID: <3E060D8B.5060208@redhat.com>
Date: Sun, 22 Dec 2002 11:07:55 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212221047570.2587-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212221047570.2587-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Uli, do you make public snapshots available so that people can test the
> new libraries and maybe see system-wide performance issues?

It is already available.  I've announced it on the NPTL mailing list a
couple of days ago.  There is no support without NPTL since the TLS
setup isn't present in sufficient form in the LinuxThreads code which
has to work on stone-old kernels.  But the NPTL code is more than stable
enough to run on test systems.  In fact, I've a complete system running
using it.

Announcement:

https://listman.redhat.com/pipermail/phil-list/2002-December/000387.html

It is not easy to build glibc and you can easily ruin your system.  You
need very recent tools, the CVS version of glibc and the NPTL add-on.
See for instance

https://listman.redhat.com/pipermail/phil-list/2002-December/000352.html

for a recipe on how to build glibc and how to run binaries using it
*without* replacing your system's libc.  There have been That's save but
still the build is demanding.  I know I'll be lynched again for saying
this, but it's the only experience I have: use RHL8 and get the very
latest tools (gcc, binutils) from rawhide.  Then you should be fine.

If there is interest in RPMs of the binaries I might _try_ to provide
some.  But this would mean replacing the system's libc.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

