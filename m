Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTKLSWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 13:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTKLSWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 13:22:23 -0500
Received: from continuum.cm.nu ([216.113.193.225]:12162 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S264128AbTKLSWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 13:22:22 -0500
Date: Wed, 12 Nov 2003 10:22:19 -0800
From: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
Message-ID: <20031112182219.GA2921@cm.nu>
References: <Pine.LNX.4.44.0311120857020.14144-100000@logos.cnet> <Pine.LNX.4.44.0311120920220.14144-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311120920220.14144-100000@logos.cnet>
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12, 2003 at 09:21:59AM -0200, Marcelo Tosatti wrote:
> > It's an Intel server board model SDS2 with a dual Pentium
> > III tualatin 1.13ghz.  I am attaching the dmesg output from
> > the kernel in case it is helpful but as there is no panics
> > or oops being printed, I am not sure how best I can help
> > track this down.  If there is anything further I can do or
> > any other information needed, let me know.
> 
> > On node 0 totalpages: 262144
> > > zone(0): 4096 pages.
> > zone(1): 225280 pages.
> > zone(2): 32768 pages.
> 
> > What do you (what is your workload) during the few minutes before the
> > crash?

It's a database machine running MySQL and Postgres.  The
MySQL server runs about 4 queries/sec and PostGres only as
needed.  It also does some minor mail service, say 2
messages per minute and runs apache at about 10 requests
per minute.

> > There are no significant driver changes in -pre4 that could affect you.
> > 
> > Can you please try with mem=900M? I suspect something in the VM changes
> > might be causing this.

Just tried with mem=900m and subsequently mem=850m so as no
himem pages were available with no effect.  Machine still
crashed.

> Ah, have you tried to boot with "nmi_watchdog=1"  as Mikael suggested?

Will try that next, thanks.

Shane
