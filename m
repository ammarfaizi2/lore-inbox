Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSDDDat>; Wed, 3 Apr 2002 22:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSDDDaj>; Wed, 3 Apr 2002 22:30:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25397 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S287817AbSDDDa0>; Wed, 3 Apr 2002 22:30:26 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
	<20020403191538.GA7211@opus.bloom.county>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 20:23:58 -0700
Message-ID: <m13cycrvsh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> writes:

> On Wed, Apr 03, 2002 at 09:41:55AM -0700, Eric W. Biederman wrote:
> 
> > In imitation of the arm and ppc ports a CONFIG_CMDLINE option is also
> > implemented.
> 
> Just wondering, why didn't you do it with a
> CONFIG_CMDLINE_BOOL/CONFIG_CMDLINE set of options?  The way you did it,
> I _think_ you can't actually get a help msg from 'config' or
> 'oldconfig', you'll just set the commandline to '?'.

I just tested it and oldconfig at least works.  The overhead is exactly
one byte.
 
> Also, on current PPC, if we have a compiled-in commandline we put it in
> arch/ppc/kernel/setup.c and allow it to be overridden.  This even makes
> it semi-useful outside of the self-containted {b,}zImage situation.

I currently allow a compiled in command line to be appended to.  lilo also
does this when you specify a command line, and to my knowledge all boot options
prefer the last value specified so that should be good enough.  As the decision
happens in C code it isn't to hard to change either way.


Eric
