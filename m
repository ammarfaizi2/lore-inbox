Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTJMWqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 18:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbTJMWqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 18:46:49 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:29663 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262069AbTJMWqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 18:46:47 -0400
Date: Mon, 13 Oct 2003 15:46:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031013224646.GA10863@ip68-0-152-218.tc.ph.cox.net>
References: <20030829184910.GB10336@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310100952010.11062-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310100952010.11062-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 12:20:56PM +0300, Meelis Roos wrote:

> > > 1. Network interface is detected correctly but first ifconfig command
> > > (even if it fails because of wrong arguments) hangs the machine. This is
> > > with both tulip driver (new io+mmio or mmio or just plain pio, 3 modes
> > > tried) and de4x5 driver (the card is a onboard 21140).
> > >
> > > 2. 2.4 detects full 64M of RAM, 2.6 detects only 32M of RAM.
> >
> > Interesting.  Can you try the linuxppc_2_4_devel
> > (http://penguinppc.org/dev/kernel.shtml) tree and let me know if that
> > finds 32mb or 64mb of RAM?
> 
> Yesterday I got the machine back from production use and tried to
> compile it. It did not compile for my configuration. I also tried
> 2.6.0-test6 that I had cheked out, it made no difference, still only 32M
> RAM and hang on ifconfig eth0 up.

-test6 BTW, should be the same.  The issue is that older 2.4 doesn't
'detect' 64MB of RAM, it reads that value from data the firmware passes
on (that can be incorrect or non-existant) and what 2.6 does and (newer
2.4 does / will do) is to ask the memory controller how much memory it
thinks that it has (which in someways is more important).

What I'm trying to do is to see if the problem is something in 2.4 or
2.6, as 2.6 correctly detects 128MB on my PReP box.

-- 
Tom Rini
http://gate.crashing.org/~trini/
