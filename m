Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbTKOMde (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 07:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTKOMde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 07:33:34 -0500
Received: from intra.cyclades.com ([64.186.161.6]:3559 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261683AbTKOMdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 07:33:32 -0500
Date: Sat, 15 Nov 2003 10:31:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
In-Reply-To: <20031112182219.GA2921@cm.nu>
Message-ID: <Pine.LNX.4.44.0311151029310.10014-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Nov 2003, Shane Wegner wrote:

> On Wed, Nov 12, 2003 at 09:21:59AM -0200, Marcelo Tosatti wrote:
> > > It's an Intel server board model SDS2 with a dual Pentium
> > > III tualatin 1.13ghz.  I am attaching the dmesg output from
> > > the kernel in case it is helpful but as there is no panics
> > > or oops being printed, I am not sure how best I can help
> > > track this down.  If there is anything further I can do or
> > > any other information needed, let me know.
> > 
> > > On node 0 totalpages: 262144
> > > > zone(0): 4096 pages.
> > > zone(1): 225280 pages.
> > > zone(2): 32768 pages.
> > 
> > > What do you (what is your workload) during the few minutes before the
> > > crash?
> 
> It's a database machine running MySQL and Postgres.  The
> MySQL server runs about 4 queries/sec and PostGres only as
> needed.  It also does some minor mail service, say 2
> messages per minute and runs apache at about 10 requests
> per minute.
> 
> > > There are no significant driver changes in -pre4 that could affect you.
> > > 
> > > Can you please try with mem=900M? I suspect something in the VM changes
> > > might be causing this.
> 
> Just tried with mem=900m and subsequently mem=850m so as no
> himem pages were available with no effect.  Machine still
> crashed.
> 
> > Ah, have you tried to boot with "nmi_watchdog=1"  as Mikael suggested?
> 
> Will try that next, thanks.

Shane, 

Have you tried the NMI watchdog? 



