Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290330AbSAPBTd>; Tue, 15 Jan 2002 20:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290319AbSAPBTO>; Tue, 15 Jan 2002 20:19:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:12479 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S290327AbSAPBSw>;
	Tue, 15 Jan 2002 20:18:52 -0500
Date: Wed, 16 Jan 2002 02:18:44 +0100
From: David Weinehall <tao@acc.umu.se>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, John Weber <weber@nyc.rr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020116021844.G5235@khan.acc.umu.se>
In-Reply-To: <20020115194316.I17477@redhat.com> <Pine.LNX.4.33.0201151644180.1213-100000@penguin.transmeta.com> <20020115195204.K17477@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20020115195204.K17477@redhat.com>; from bcrl@redhat.com on Tue, Jan 15, 2002 at 07:52:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 07:52:04PM -0500, Benjamin LaHaise wrote:
> On Tue, Jan 15, 2002 at 04:44:54PM -0800, Linus Torvalds wrote:
> > Numbers please.
> > 
> > I'd MUCH rather just clean up the include file hierarchy than have these
> > kinds of non-local knowledge issues.
> 
> The last time I did it for fs.h et al (this meant pulling the fs.h and 
> sched.h codependancy apart), it got 2.4 compiles back down to 2.2 compile 
> times (3m -> 2m45s maybe 2m30s iirc) -- about a 10% drop in compile time.  
> It's even more noticeable when you're doing a fully blown modular kernel 
> build as distributions do.

The difference between 3 minutes and 2.45 isn't really a lot imho. What
is interesting if difference scales; that is, if you compile on a 486
or so, does the 10% drop still hold, or are we still talking about a
difference of 15 seconds. If the latter, I'd go for the cleanup,
but if the former is true, maybe, just maybe, the ugly version might
be the solution.

I'd prefer all includes that can be to be non-conditional, though.


/David
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
