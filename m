Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262713AbUCEVHS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbUCEVHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:07:18 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55824
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262704AbUCEVHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:07:15 -0500
Date: Fri, 5 Mar 2004 22:07:55 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mbligh@aracnet.com, mingo@elte.hu, peter@mysql.com, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305210755.GW4922@dualathlon.random>
References: <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <39960000.1078512175@flay> <20040305191329.GR4922@dualathlon.random> <56050000.1078516505@flay> <20040305202941.GT4922@dualathlon.random> <20040305124119.756aab4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305124119.756aab4c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 12:41:19PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > > The main thing you didn't mention is the overhead in the per-cpu data
> >  > > structures, that alone generates an overhead of several dozen mbytes
> >  > > only in the page allocator, without accounting the slab caches,
> >  > > pagetable caches etc.. putting an high limit to the per-cpu caches
> >  > > should make a 32-way 32G work fine with 3:1 too though. 8-way is
> >  > > fine with 32G currently.
> >  > 
> >  > Humpf. Do you have a hard figure on how much it actually is per cpu?
> > 
> >  not a definitive one, but it's sure more than 2m per cpu, could be 3m
> >  per cpu.
> 
> It'll average out to 68 pages per cpu.  (4 in ZONE_DMA, 64 in ZONE_NORMAL).

3m per cpu with all 3m in zone normal.
