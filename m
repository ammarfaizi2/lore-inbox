Return-Path: <linux-kernel-owner+w=401wt.eu-S932299AbXAGBLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbXAGBLe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 20:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbXAGBLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 20:11:33 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:14249 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932300AbXAGBLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 20:11:32 -0500
X-AuditID: d80ac21c-9cb36bb00000021a-6d-45a048c4dfbf 
Date: Sun, 7 Jan 2007 01:11:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: David Brownell <david-b@pacbell.net>
cc: Matt Mackall <mpm@selenic.com>, Philippe De Muyter <phdm@macqel.be>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RTC subsystem and fractions of seconds
In-Reply-To: <200701061552.43654.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.64.0701070108001.1428@blonde.wat.veritas.com>
References: <200701051949.00662.david-b@pacbell.net> <20070106232633.GA8535@ingate.macqel.be>
 <200701061552.43654.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Jan 2007 01:11:31.0696 (UTC) FILETIME=[C4375700:01C731F8]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, David Brownell wrote:
> On Saturday 06 January 2007 3:26 pm, Philippe De Muyter wrote:
> 
> > The way it is done currently 
> > in drivers/rtc/hctosys.c is 0.5 sec off.  We could obtain a much better
> > precision by looping there until the next change (next second for old clocks,
> > next 0.01 second for m41t81, maybe even better for other ones).
> 
> Hmm ... "looping" fights against "quickly"; as would "wait for next
> update IRQ" (on RTCs that support that).  But it would improve precision,
> at least in the sense of having the system clock and that RTC spending
> less time with the lowest "seconds" digit disagreeing.
> 
> This is something you could write a patch for, n'est-ce pas?

If you're thinking of going that way, it'd be courteous to CC Matt,
who devoted some effort to removing just that loop in 2.6.17 ;)

Hugh
