Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315956AbSENSHb>; Tue, 14 May 2002 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315957AbSENSHa>; Tue, 14 May 2002 14:07:30 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:43122 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S315956AbSENSH3>; Tue, 14 May 2002 14:07:29 -0400
Date: Tue, 14 May 2002 13:07:26 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200205141807.NAA71526@tomcat.admin.navo.hpc.mil>
To: elladan@eskimo.com, Mark Mielke <mark@mark.mielke.cc>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Cc: Christoph Hellwig <hch@infradead.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> A second method was proposed as well - create a file with a hole in it,
> map it, then dirty the pages in the hole and exit.  This would not
> require suid.

Actually, the allocation that fills the partition (and goes one over)
should fail. Even if that is only adding a block to the hole, it should
fail. Now if it DOES continue then you have found a bug since it
shouldn't do that.

> This is basically a documentation issue, unless someone wants to go fix
> it.  I wouldn't bother myself - it's ext[23] only and not really very
> useful.
> 
> The basic problem is this: the documentation states "This is intended to
> allow for the system to continue functioning even if non-priveleged
> users fill up all the space available to them."  This states that it's a
> security feature.  It does not work as intended - all users are
> privileged to do this - so the documentation should be updated.

There is nothing wrong with the documentation. Though it could have
additions to more clearly explain why. The feature can already be disabled.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
