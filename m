Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbUCEQmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbUCEQmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:42:10 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44813
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262642AbUCEQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:42:08 -0500
Date: Fri, 5 Mar 2004 17:42:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, peter@mysql.com, akpm@osdl.org,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305164248.GH4922@dualathlon.random>
References: <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <p73ad2v47ik.fsf@brahms.suse.de> <20040305162319.GA16835@elte.hu> <20040310142125.6f448d28.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310142125.6f448d28.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 02:21:25PM +0100, Andi Kleen wrote:
> On Fri, 5 Mar 2004 17:23:19 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > [...] Only drawback is that if a timer tick is delayed for too long it
> > > won't fix that, but I guess that's reasonable for a 1s resolution.
> > 
> > what do you mean by delayed?
> 
> Normal gettimeofday can "fix" lost timer ticks because it computes the true
> offset to the last timer interrupt using the TSC or other means. xtime
> is always the last tick without any correction. If it got delayed too much 
> the result will be out of date.

lost timer ticks doesn't worry me that much, they mess up the system
time persistently anyways with 2.4 (and not all platforms uses the tsc
anyways, even on x86), it's only the lost softirqs that concerns me.
