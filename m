Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUKPQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUKPQyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbUKPQyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:54:46 -0500
Received: from mail.tmr.com ([216.238.38.203]:14859 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262042AbUKPQx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:53:57 -0500
Date: Tue, 16 Nov 2004 11:43:31 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Massimo Cetra <mcetra@navynet.it>
cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Willy Tarreau'" <willy@w.ods.org>, "'Rik van Riel'" <riel@redhat.com>,
       "'Marcos D. Marado Torres'" <marado@student.dei.uc.pt>,
       "'Ed Tomlinson'" <edt@aei.ca>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: My thoughts on the "new development model"
In-Reply-To: <015b01c4bbf1$48069580$e60a0a0a@guendalin>
Message-ID: <Pine.LNX.3.96.1041116112553.21955F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Massimo Cetra wrote:

> > On Wed, Oct 27, 2004 at 08:04:33AM +0200, Willy Tarreau wrote:
> > > Oh yes I remember... I was very interested because of netfilter and 
> > > ramfs but couldn't use it because of its awful stability. That was 
> > > when I started complaining about linux development model, where new 
> > > features were more important than bug fixes, which resulted in no 
> > > usable kernel before 2.4.18.
> > 
> > 2.6.x has taken a rather different path from 2.4.x
> 
> However, results are similar. 
> 
> 2.6 seems to work better than 2.4 in "early stage of stable branch" but
> It's quite impossible to set up a production server on 2.6.x, optimize
> it and keeping the same performance with 2.6.(x+2).

The catch here is "optimize it."
> 
> Iosched has a lot of flavours, with performance worse than 2.4 (at least
> for databases). 
> Swap is a misterious thing and It needs a degree in swappiness to
> understand how it works and how it changes.

I think one of the issues with 2.6 in general is that it doesn't auto-tune
as well as 2.4. While it's good to have controls, and I ran tuned -aa
kernels for several years because Andrea took the time to give me a two
screen primer on tuning bdflush, tuning 2.6 for i/o and CPU scheduling had
more benefits than 2.4. Unfortunately you now need to tune the algorithm
as well as the parameters, and in some cases the "tuning" needs to be done
with patch and gcc.
> 
> I see a lot of efforts in making a top-performance kernel but these
> efforts are not compatible with a stable-tree.

I'm going to disagree a little here, what needs to be done is to put i/o
and CPU scheduling in modules (some work has been done), so that kernels
can be tuned, and use of a default delection should be stable, at least
defined as not crashing or hanging, and producing some reasonable
performance with self tuning.
> 
> Stable means not only that the kernel does not hangs, but that features
> remains (almost) the same for a reasonable amount of time.

And there I agree, rewriting an app to go from 2.4 to 2.6 is fine, from
2.6.n to 2.6.n+1 isn't.
> 
> Max
> 

I hope you realize that the development model is decided by a democratic
vote, just be aware that there is only one voter.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

