Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313062AbSDSWMW>; Fri, 19 Apr 2002 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSDSWMV>; Fri, 19 Apr 2002 18:12:21 -0400
Received: from smtp-server6.tampabay.rr.com ([65.32.1.43]:17575 "EHLO
	smtp-server6.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S313062AbSDSWMU>; Fri, 19 Apr 2002 18:12:20 -0400
Date: Fri, 19 Apr 2002 18:10:26 -0400
From: Rick Haines <rick@kuroyi.net>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: read latency (ia64)
Message-ID: <20020419221026.GA1995@sasami.kuroyi.net>
In-Reply-To: <20020418140622.GA31405@sasami.kuroyi.net> <15552.34913.686564.487970@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 02:13:05PM -0700, David Mosberger wrote:
> >>>>> On Thu, 18 Apr 2002 10:06:22 -0400, Rick Haines <rick@kuroyi.net> said:
> 
>   Rick> I have a Lion with 4 666mhz B3 stepping cpus and 4GB ram
>   Rick> running Debian unstable with kernel 2.4.18 and the 020410 ia64
>   Rick> patch (I have the same problem with 2.4.9-itanium-smp from the
>   Rick> archive).
> 
>   Rick> I have a program that reads large files in increments of 81920
>   Rick> blocks.  After about 9600 read calls I get about a dozen reads
>   Rick> that take about 3 seconds each.  Does anyone have any ideas as
>   Rick> to a cause/solution?  (I have 4 other threads working/possibly
>   Rick> writing output at the same time, although in this case only 1
>   Rick> of them would be active at the same time).  I am also running
>   Rick> a program that callocs almost all my ram to make sure none of
>   Rick> the file is cached.
> 
> I don't think anyone will be able to help you without a test case.
> Do you have a minimal test case that reproduces the problem?

I got a response from Andrew Morton that sounds promising.  He says 
it's probably that "writeback has kicked in, and your reads are stalling
behind the writes".  I'll send another email after I try his patch.

-- 
Rick (rick@kuroyi.net)
http://dxr3.sourceforge.net

I think the slogan of the fansubbers puts
it best: "Cheaper than crack, and lots more fun."
