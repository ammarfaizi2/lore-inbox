Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292266AbSBOXWp>; Fri, 15 Feb 2002 18:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292265AbSBOXW0>; Fri, 15 Feb 2002 18:22:26 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:43248
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292264AbSBOXWP>; Fri, 15 Feb 2002 18:22:15 -0500
Date: Fri, 15 Feb 2002 15:22:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
Subject: Re: Hard lockup with 2.4.18-pre9 + preempt + lock break + O1k[23] + rmap
Message-ID: <20020215232221.GB5310@matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Robert Jameson <rj@open-net.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org> <1013780277.950.663.camel@phantasy> <20020215201810.GA5310@matchmail.com> <1013810411.803.1045.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013810411.803.1045.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 05:00:10PM -0500, Robert Love wrote:
> On Fri, 2002-02-15 at 15:18, Mike Fedyk wrote:
> 
> > I don't use USB, and I have had several machines lock up hard while doing
> > medium to heavy IO.  I've had this happen with pre9-mjc2 and another patch
> > that just contained pre9-preempt-schedo1
> > (nyu.dyn.dhs.org:8080/patches/2.4.18-pre9-to-rmap12e-schedO1-rml.patch.bz2)
> 
> The -mjc and similar patches make debugging a bit, uh, hard ;)
>

Yep, I understand.  When I was patching in rmap12f I had to manually
merge the little bit into mm/bootmem.c and the offset was several hundred
lines.  Then I realized just how much WLI's bootmem patch changes.

> > I'm running 2.4.18-pre9-ac3 now to see if I can reproduce without prempt and
> > O(1).
> 
> If you can't reproduce it, I'd like to see if you can reproduce it
> _only_ with preempt.  Also, if it happens on stock pre9 (no -ac) would
> be of interest, since that doesn't have Andre's IDE patch.
>

Actually, I'm going to recompile -mjc2 without lock breaking to see if that
helps.  Then try without prempt altogether.  If either of those two fix the
problem, I'll see if I can reproduce against the latest kernel from marcello
and your latest patch and merge myself.  Heh, I want to keep testing -mjc.
There are so many nice things in there. ;)

> > I have someone else from IRC that has the same issue with prempt+O(1)
> > against vanilla 2.4.17.  He should be sending you a bug report soon.
> 
> Now this would be of interest, thanks.
>

I asked him to cc me so that I may be able to help too... 

> 	Robert Love

Mike
