Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbTEIGta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 02:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbTEIGta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 02:49:30 -0400
Received: from holomorphy.com ([66.224.33.161]:6558 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262311AbTEIGt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 02:49:29 -0400
Date: Fri, 9 May 2003 00:01:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
Message-ID: <20030509070142.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EBAD63C.4070808@nortelnetworks.com> <20030509001339.GQ8978@holomorphy.com> <Pine.LNX.4.50.0305081735040.2094-100000@blue1.dev.mcafeelabs.com> <20030509003825.GR8978@holomorphy.com> <Pine.LNX.4.53.0305082052160.21290@chaos> <3EBB25FD.7060809@nortelnetworks.com> <20030509042659.GS8978@holomorphy.com> <3EBB4735.30701@nortelnetworks.com> <20030509062008.GT8978@holomorphy.com> <3EBB504C.1030001@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB504C.1030001@nortelnetworks.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 02:53:00AM -0400, Chris Friesen wrote:
> I'm obsessed with interrupts because it gives me a higher sampling rate.
> I could set up and itimer for a recurring 10ms timeout and see how much 
> extra I waited, but then I can only get 100 samples/sec.
> With /dev/rtc (on intel) you can get 20x more samples in the same amount of 
> time.

Why not just keep track of it in the scheduler? The statistic is well-
defined in terms of things measurable at context switch and wakeup.
Just stamping processes with when they became runnable and when they
were first run with the timebase and/or TSC and/or whatever would seem
to provide the answer you want for T(x). W(x) is slightly more involved
but can be measured properly in the same way.

I think your stats will be more accurate and serve your own (not mine;
I have _zero_ cause to fish this stuff out myself besides curiostiy)
purposes better if measured in the way I'm suggesting. That said, only
your own purposes really matter for this in the end so if I
misunderstand you by all means generate all the interrupts you want.


-- wli
