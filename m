Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUDGGDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 02:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUDGGDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 02:03:33 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63110
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263563AbUDGGDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 02:03:32 -0400
Date: Wed, 7 Apr 2004 08:03:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407060330.GB26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406202548.GI2234@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 10:25:48PM +0200, Andrea Arcangeli wrote:
> I'm using DOUBLE. However I won't post the quips, I draw the graph
> showing the performance for every working set, that gives a better
> picture of what is going on w.r.t. memory bandwidth/caches/tlb.

Here we go:

	http://www.kernel.org/pub/linux/kernel/people/andrea/misc/31-44-100-1000/31-44-100-1000.html

the global quips you posted indeed had no way to account for the part of
the curve where 4:4 badly hurts. details in the above url.

Please cross check my results on your hardware (I used a 2.5Ghz xeon, 1G
of ram, and benchs run fresh after boot with all ram still free).
Numbers are perfectly reproducible for me, and they make perfect sense
too.  2.6.5-aa4 is the same as 2.6.5-aa3 for this benchmark (though I'll
upload 2.6.5-aa4 in a few hours).
