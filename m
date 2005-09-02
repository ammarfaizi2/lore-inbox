Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVIBJ6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVIBJ6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 05:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVIBJ6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 05:58:45 -0400
Received: from gromit.tds.de ([193.28.97.130]:36804 "EHLO gromit.tds.de")
	by vger.kernel.org with ESMTP id S1751106AbVIBJ6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 05:58:44 -0400
Date: Fri, 2 Sep 2005 11:58:22 +0200
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Bongani Hlope <bonganilinux@mweb.co.za>, linux-kernel@vger.kernel.org
Subject: Re: Bad page state on AMD Opteron Dual System with kernel 2.6.13-rc6-git13
Message-ID: <20050902095821.GA6489@security.tds.de>
References: <20050826165342.GA11796@pbkg4> <43110363.7020808@gentoo.org> <20050829052454.GA8172@pbkg4> <20050829102830.GA7604@pbkg4> <Pine.LNX.4.61.0508291401470.13709@goblin.wat.veritas.com> <20050829142318.GB7604@pbkg4> <20050830072759.GA4150@pbkg4> <Pine.LNX.4.61.0508301035410.6339@goblin.wat.veritas.com> <20050830123529.GA4293@pbkg4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830123529.GA4293@pbkg4>
User-Agent: Mutt/1.5.6i
From: weiti@security.tds.de (Tim Weippert)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all together, 

for now i can confirm, that the problem disappears!

I have done the following:

First try the msr fix, this doesn't solve the problem entirely, but
there were no kernel panics.

With the randomize_va_space setting the general protection disappeared
too ...

I'm now happy and will go for holiday ( 4 weeks *g*). After that i will look
if the machine gets some problems back, but i don't think ...

I thank you all for your help!

On Tue, Aug 30, 2005 at 02:35:29PM +0200, Tim Weippert wrote:
> On Tue, Aug 30, 2005 at 10:51:18AM +0100, Hugh Dickins wrote:

> > It's conceivable (though not very likely) that here you have the error
> > reported on exit from a long-running "sh", running since before you made
> > the MSR fix (the error I'm thinking of occurs when originally exec'ed,
> > but may pass unnoticed while running).
> 
> Yes, this can possible, that the sh run before the changes were made.
> but. The later problem suggest me that this not entirely fix the
> problem.

> > > Bongani Hlope suggest me to try this:
> > > 
> > > echo 0 > /proc/sys/kernel/randomize_va_space and look for 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=4851
> > 
> > Please do try that.  And if no luck with that, next time it's convenient
> > for you to reboot, please write the MSR as early as you can to see if
> > that makes any difference (probably not, but there's a chance).

-- 

Every time I think I know where it's at, they move it.

Tim Weippert <weiti@topf-sicret.org>
http://www.topf-sicret.org/
