Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbUCTMNe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 07:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUCTMNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 07:13:34 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49344
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263385AbUCTMNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 07:13:32 -0500
Date: Sat, 20 Mar 2004 13:14:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040320121423.GA9009@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <405A584B.40601@cyberone.com.au> <20040319050948.GN2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319050948.GN2045@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 09:09:48PM -0800, William Lee Irwin III wrote:
> On Fri, Mar 19, 2004 at 01:17:47PM +1100, Nick Piggin wrote:
> > Technically, I think preempt can still reduce maximum latency
> > depending on whether the time between explicit resched checks
> > is greater than the (small) scheduling overhead that preempt
> > adds.
> > But yeah, that would be in the noise compared with long
> > preempt-off regions.
> > I'm not sure about applications, but maybe some soft-realtime
> > things like audio software benefit from a lower average latency
> > (I don't know).
> 
> Someone really needs to get numbers on this stuff.

Takashi already did it and we know it doesn't reduce the maximum latency.
