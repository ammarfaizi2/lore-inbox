Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUBLO7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUBLO7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:59:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36237
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S266481AbUBLO7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:59:42 -0500
Date: Thu, 12 Feb 2004 15:59:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interl
Message-ID: <20040212145940.GU4478@dualathlon.random>
References: <20040212022314.GS4478@dualathlon.random> <XFMail.20040212104215.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20040212104215.pochini@shiny.it>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 12, 2004 at 10:42:15AM +0100, Giuliano Pochini wrote:
> 
> On 12-Feb-2004 Andrea Arcangeli wrote:
> 
> > the main difference is that 2.4 isn't in function of time, it's in
> > function of requests, no matter how long it takes to write a request,
> > so it's potentially optimizing slow devices when you don't care about
> > latency (deadline can be tuned for each dev via
> > /sys/block/*/queue/iosched/).
> 
> IMHO it's the opposite. Transfer speed * seek time of some
> slow devices is lower than fast devices. For example:
> 
> Hard disk  raw speed= 40MB/s   seek time =  8ms
> MO/ZIP     raw speed=  3MB/s   seek time = 25ms
> 
> One seek of HD costs about 320KB, while on a slow drive it's
> only 75KB. 2.4 has a terrible latency on slow devices, and it
> has very small advantage in terms of speed. On CDs and DVDs
> the cost of a seek is much higher, but since the data is
> usually accessed sequentially you have the high latency
> penalty with no appreciable speed gain in this case too.

I was thinking at old slow harddisks (5M/sec), and I don't think all
data on cds is always accessed sequentially, you only need two tasks
reading two files.
