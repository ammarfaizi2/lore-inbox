Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288597AbSAHX47>; Tue, 8 Jan 2002 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288602AbSAHX4t>; Tue, 8 Jan 2002 18:56:49 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:39182 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288597AbSAHX4e>; Tue, 8 Jan 2002 18:56:34 -0500
Message-ID: <3C3B85E6.9634B180@zip.com.au>
Date: Tue, 08 Jan 2002 15:51:02 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Greg KH <greg@kroah.com>, jtv <jtv@xs4all.nl>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>,
		<20020108231147.GA16313@kroah.com>; from greg@kroah.com on Tue, Jan 08, 2002 at 03:11:47PM -0800 <20020109003901.T5235@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> ...
> > Since the C99 spec does not state anything about __FUNCTION__, changing
> > it from the current behavior does not seem like a wise thing to do.
> >
> > Any pointers to someone to complain to, or is there no chance for
> > reversal?
> 
> Because the want people to stop using a gcc-specific way and start
> using the C99-mandated way instead?! Very sane imho.
> 

They shouldn't take a GNU extension which has been offered
for ten years and suddenly revert it, or unoptionally spit a
warning.  But they keep on doing this.

I've had large codebases which compiled just fine five years ago.
But with a current compiler, same codebase produces an *enormous*
number of warnings.  There's no switch to turn them off and going
in and changing the code is clearly not an option.  The only options
are to:

1: Not use the newer compiler

2: Grotty sed script to gobble the warnings

3: Fix the compiler.

I've done all three :(

-
