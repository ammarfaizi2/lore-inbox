Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVATX1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVATX1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVATX1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:27:43 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18219
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261847AbVATX11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:27:27 -0500
Date: Fri, 21 Jan 2005 00:27:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: oom killer gone nuts
Message-ID: <20050120232721.GP12647@dualathlon.random>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120171544.GN12647@dualathlon.random> <20050120205204.GB11170@pclin040.win.tue.nl> <41F02933.7040706@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F02933.7040706@nortelnetworks.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 03:57:07PM -0600, Chris Friesen wrote:
> Andries Brouwer wrote:
> 
> >But let me stress that I also consider the earlier situation
> >unacceptable. It is really bad to lose a few weeks of computation.
> 
> Shouldn't the application be backing up intermediate results to disk 
> periodically?  Power outages do occur, as do bus faults, electrical 
> glitches, dead fans, etc.

Agreed. Plus if you truly cannot change the app because it's binary only
at least you can set the ulimit based on the virtual sizes, ulimit
should work reliably even if overcommit doesn't.
