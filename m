Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUCRPmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUCRPmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:42:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:10889
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262711AbUCRPmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:42:02 -0500
Date: Thu, 18 Mar 2004 16:42:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Marinos J. Yannikos" <mjy@geizhals.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318154250.GH2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <s5hlllycgz3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlllycgz3.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 04:28:16PM +0100, Takashi Iwai wrote:
> the above one is the major source of RT-latency.
> only this oneliner will reduce more than 90% of RT-latencies.
> in my case with reiserfs, i got 0.4ms RT-latency with my test suite
> (with athlon 2200+).

cool ;)

> there is another point to be fixed in the reiserfs journal
> transaction.  then you'll get 0.1ms RT-latency without preemption.

[..]

> i think the first one is needed for preemptive kernel, too.
> with these patches, also 0.1-0.2ms RT-latency is achieved.

amazing.

And without those improvements you did, the worst case for 2.6 mainline
is 8msec, right?

thanks for the great work on lowlatency. I'm sure Andrew will pick those
improvements immediatly :).
