Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288614AbSAIAE7>; Tue, 8 Jan 2002 19:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288612AbSAIAEt>; Tue, 8 Jan 2002 19:04:49 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:16885 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S288610AbSAIAEm>;
	Tue, 8 Jan 2002 19:04:42 -0500
Date: Wed, 9 Jan 2002 01:04:24 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andrew Morton <akpm@zip.com.au>
Cc: Greg KH <greg@kroah.com>, jtv <jtv@xs4all.nl>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020109010424.U5235@khan.acc.umu.se>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>, <20020108231147.GA16313@kroah.com>; <20020109003901.T5235@khan.acc.umu.se> <3C3B85E6.9634B180@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3B85E6.9634B180@zip.com.au>; from akpm@zip.com.au on Tue, Jan 08, 2002 at 03:51:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 03:51:02PM -0800, Andrew Morton wrote:
> David Weinehall wrote:
> > 
> > ...
> > > Since the C99 spec does not state anything about __FUNCTION__, changing
> > > it from the current behavior does not seem like a wise thing to do.
> > >
> > > Any pointers to someone to complain to, or is there no chance for
> > > reversal?
> > 
> > Because the want people to stop using a gcc-specific way and start
> > using the C99-mandated way instead?! Very sane imho.
> > 
> 
> They shouldn't take a GNU extension which has been offered
> for ten years and suddenly revert it, or unoptionally spit a
> warning.  But they keep on doing this.

Well, as the C standards evolve to incorporate things that gcc earlier
had to create extensions to provide, it is reasonable that gcc, which
after all _is_ a C-compiler (yeah, yeah, I know that gcc is GNU Compiler
Collection or whatever, but disregard from that now, ok?!) should
use those. Deprecating the use of the extension in one release and
removing it from the next is something we do from time to time in the
kernel too...

> I've had large codebases which compiled just fine five years ago.
> But with a current compiler, same codebase produces an *enormous*
> number of warnings.  There's no switch to turn them off and going

So, you:

a.) Coded with a lot of gcc specific code

or

b.) Had a lot of bugs in your code that gcc didn't warn about before

In both cases I'd recommend fixing the code...

> in and changing the code is clearly not an option.  The only options

Huh? Most likely, your code is broken, rather than blaming the
messenger, act properly upon the received message.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
