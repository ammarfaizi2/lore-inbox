Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTKOU6c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 15:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTKOU6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 15:58:31 -0500
Received: from continuum.cm.nu ([216.113.193.225]:58496 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id S262081AbTKOU63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 15:58:29 -0500
Date: Sat, 15 Nov 2003 12:58:28 -0800
From: Shane Wegner <shane-keyword-kernel.a35a91@cm.nu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 crash on Intel SDS2
Message-ID: <20031115205828.GA1367@cm.nu>
References: <20031112182219.GA2921@cm.nu> <Pine.LNX.4.44.0311151029310.10014-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311151029310.10014-100000@logos.cnet>
X-No-Archive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 15, 2003 at 10:31:07AM -0200, Marcelo Tosatti wrote:
> 
> 
> On Wed, 12 Nov 2003, Shane Wegner wrote:
> 
> > On Wed, Nov 12, 2003 at 09:21:59AM -0200, Marcelo Tosatti wrote:
> > > > It's an Intel server board model SDS2 with a dual Pentium
> > > > III tualatin 1.13ghz.  I am attaching the dmesg output from
> > > > the kernel in case it is helpful but as there is no panics
> > > > or oops being printed, I am not sure how best I can help
> > > > track this down.  If there is anything further I can do or
> > > > any other information needed, let me know.
> > > 
> > > > On node 0 totalpages: 262144
> > > > > zone(0): 4096 pages.
> > > > zone(1): 225280 pages.
> > > > zone(2): 32768 pages.
> > > 
> > > > What do you (what is your workload) during the few minutes before the
> > > > crash?
> > 
> > It's a database machine running MySQL and Postgres.  The
> > MySQL server runs about 4 queries/sec and PostGres only as
> > needed.  It also does some minor mail service, say 2
> > messages per minute and runs apache at about 10 requests
> > per minute.
> > 
> > > > There are no significant driver changes in -pre4 that could affect you.
> > > > 
> > > Ah, have you tried to boot with "nmi_watchdog=1"  as Mikael suggested?
> > 
> > Will try that next, thanks.
> 
> Shane, 
> 
> Have you tried the NMI watchdog? 

Hi,

I did and unfortunately, it was of little help.  If
anything though, it made the lockup more consistent.  The
three times I tried to boot with nmi_watchdog=1, it locked
up when starting SpamAssassin.  Nothing special about that
process but just above that it started the hotplug
subsystem which I use to automatically insert various usb
drivers as needed.  Could that have anything to do with it?

Shane

Btw, to clarify, when the lockup occurs with nmi_watchdog,
no oops gets printed.

