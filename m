Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267559AbTBDXU1>; Tue, 4 Feb 2003 18:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbTBDXU1>; Tue, 4 Feb 2003 18:20:27 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59779 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267559AbTBDXU0>; Tue, 4 Feb 2003 18:20:26 -0500
Subject: Re: gcc 2.95 vs 3.21 performance
From: "Timothy D. Witham" <wookie@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302041405500.2638-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0302041405500.2638-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Open Source Development Lab, Inc.
Message-Id: <1044401231.1863.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 04 Feb 2003 15:27:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  If needed we could build this compiler's tree into our testing
process. (PLM/STP) So that patches or changes could be automatically
tested against a matrix of kernels, hardware configurations on 
different regression and stress tests.

Tim
 
On Tue, 2003-02-04 at 14:11, Linus Torvalds wrote:
> On Tue, 4 Feb 2003, John Bradford wrote:
> > > I'd love to see a small - and fast - C compiler, and I'd be willing to
> > > make kernel changes to make it work with it.  
> > 
> > How IA-32 centric would your prefered compiler choice be?  In other
> > words, if a small and fast C compiler turns up, which lacks support
> > for some currently ported to architectures, are you likely to
> > encourage kernel changes which will make it difficult for the other
> > architectures that have to stay with GCC to keep up?
> 
> I don't think being architecture-specific is necessarily a bad thing in 
> compilers, although most compiler writers obviously try to avoid it.
> 
> The kernel shouldn't really care: it does want to have a compiler with
> support for inline functions, but other than that it's fairly close to
> ANSI C.
> 
> Yes, I know we use a _lot_ of gcc extensions (inline asms, variadic macros
> etc), but that's at least partly because there simply aren't any really
> viable alternatives to gcc, so we've had no incentives to abstract any of
> that out.
> 
> So the gcc'isms aren't really fundamental per se. Although, quite frankly,
> even inline asms are pretty much a "standard" thing for any reasonable C
> compiler (since C is often used for things that really want it), and the
> main issue tends to be the exact syntax rather than anything else. So I
> don't think I'd like to use a compiler that is _so_ limited that it
> doesn't have some support for something like that. I certainly would 
> refuse to use a C compiler that didn't support inline functions.
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

