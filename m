Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTLJTBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 14:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTLJTBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 14:01:50 -0500
Received: from us01smtp2.synopsys.com ([198.182.44.80]:37372 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S263726AbTLJTBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 14:01:49 -0500
Message-ID: <3FD76D99.1960A104@synopsys.com>
Date: Wed, 10 Dec 2003 14:01:45 -0500
From: Chris Petersen <Chris.Petersen@synopsys.com>
Reply-To: Chris.Petersen@synopsys.com
Organization: Synopsys, Inc.
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Chris Petersen <Chris.Petersen@synopsys.COM>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FIXED (was Re: PROBLEM:  Blk Dev Cache causing kswapd thrashing)
References: <Pine.LNX.4.44.0311271649520.21568-100000@logos.cnet> <3FD75B8A.21FA59D9@synopsys.com> <20031210180849.GA13303@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Wed, Dec 10, 2003 at 12:44:42PM -0500, Chris Petersen wrote:
> >
> > To confuse matters RedHat has released an RPM with 2.4.20-24.7 which
> > apparently contains later patches that include the fix.
> 
> 2.4.20-24.7 contains two patches. Both security issues. (do_brk
> and an nptl local DoS), nothing else (vs previous 2.4.20-20.7)

I wasn't claiming that it wasn't fixed UNTIL 2.4.20-24.7 specifically.
I was merely stating that 2.4.20-24.7 appears to contain the fix.

After some research it looks like the fix is sortof there in
RedHat's 2.4.20-13.7.  It behaves better, but not as good as 2.4.23
or 2.4.20-24.7.  By "better" I mean kswapd (and bdflush, kupdated,
kreclaimd) doesn't hog the CPU(s) as much; but it still does to
a greater extent compared to what I'm calling the "fixed" versions.
So in 2.4.20-13.7 it's quasi-busted or quasi-fixed, depending on
your half-full/empty position.

>  > This can be
>  > confusing because their 2.4.21-4EL kernel is busted (WRT this bug)
> 
> That kernel bears no relation whatsoever to 2.4.20-24.7
> It's for a completely different product for one thing, with
> very little in common between them (in terms of patches we add).

Exactly my point!

I suppose I am working from the assumption that if vanilla
(kernel.org) 2.4.20 was fixed then 2.4.21-4EL would also be fixed
(which it's not).  It would seem to me that a kernel's got no
business calling itself 2.4.21-<anything> if it's not based off of
previous kernel base.  Otherwise, "21" has absolutely no meaning.

Imperical evidence seems to indicate that vanilla 2.4.20 does not
contain the fix.  Whereas something that RedHat calls 2.4.20-XYZ does.

-chris

-----------------------------------------------------------------
Chris M. Petersen                                cmp@synopsys.com
Sr. R&D Engineer

Synopsys, Inc.                                    o: 919.425.7342
1101 Slater Road, Suite 300                       c: 919.349.6393
Durham, NC  27703                                 f: 919.425.7320
-----------------------------------------------------------------
