Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVAUIFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVAUIFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAUIFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:05:38 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40261
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261592AbVAUIFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:05:23 -0500
Date: Fri, 21 Jan 2005 09:05:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050121080520.GA7703@dualathlon.random>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random> <20050121074203.GH2755@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121074203.GH2755@suse.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 08:42:08AM +0100, Jens Axboe wrote:
> And especially not with 500MB of zone normal free, thanks :)

;) Are you sure you had 500m free even before the _first_ oom killing?

I assumed what you posted was not the first one of the oom killing
messages. If it was the first then there was a regression. But if OTOH I
didn't misunderstood your message and it wasn't the first, then what
you've seen is just the brokeness of 2.6 w.r.t. oom killing, that's what
made Thomas drive a few hours too, and you've only to apply the 5
patches I just posted, and everything will work perfectly correct then
in terms of _not_ killing right and left anymore, even despite the 500m
free ;). I tested the code before posting and my regression test passed
at least, so it looked like there was no other regression. The several
rejects I've got while porting the code looked all due noop-cleanups. So
I doubt there was a regression and I'm optimistic you've just seen the
old bugs.
