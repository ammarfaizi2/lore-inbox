Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUKDUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUKDUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUKDUIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:08:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:44220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262382AbUKDTi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:38:57 -0500
Date: Thu, 4 Nov 2004 11:38:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Heath <doogie@debian.org>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Nov 2004, Adam Heath wrote:
>
> On Wed, 3 Nov 2004, Chris Wedgwood wrote:
> 
> > On Wed, Nov 03, 2004 at 05:06:56PM -0600, Adam Heath wrote:
> >
> > > You can't be serious that this is a problem.
> >
> > try it, say gcc 2.95 vs gcc 4.0 ... i think last i checked the older
> > gcc was over twice as fast
> 
> I didn't deny the speed difference of older and newer compilers.
> 
> But why is this an issue when compiling a kernel?  How often do you compile
> your kernel?

First off, for some people that is literally where _most_ of the CPU 
cycles go.

Second, it's not just that the compilers are slower. Historically, new gcc 
versions are:
 - slower
 - generate worse code
 - buggier

For a _long_ time, the only reason to upgrade gcc was literally C++
support: basic C support was getting _worse_ with new compilers in pretty
much every regard.

Things seem to have improved a bit lately. The gcc-3.x series was 
basically not worth it for plain C until 3.3 or so.

		Linus
