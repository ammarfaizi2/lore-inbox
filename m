Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280935AbRKYREH>; Sun, 25 Nov 2001 12:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280937AbRKYRD7>; Sun, 25 Nov 2001 12:03:59 -0500
Received: from zero.aec.at ([193.170.194.10]:34313 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S280935AbRKYRDr>;
	Sun, 25 Nov 2001 12:03:47 -0500
To: ptb@it.uc3m.es
Cc: linux-kernel@vger.kernel.org
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com> <200111251527.QAA05393@nbd.it.uc3m.es>
From: Andi Kleen <ak@muc.de>
Date: 25 Nov 2001 18:03:10 +0100
In-Reply-To: "Peter T. Breuer"'s message of "Sun, 25 Nov 2001 16:30:13 +0100"
Message-ID: <m3lmgug4vl.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Peter T. Breuer" <ptb@it.uc3m.es> writes:

> "A month of sundays ago Chris Chabot wrote:"
> > The box has ran Redhat 7.1 and 7.2, with plain vanilla linux kernels
> > 2.4.9 upto 2.4.15, in all situations the same problem appeared.
> > 
> > The problem is that when the box boots up, it uses about 60Mb of memory.
> > However after only 1 1/2 days, the memory usage is already around 430Mb
> > (!!). (this is ofcource used - buffers - cache, as displayed by 'free').
> 
> I also have this problem. Unknown circumstances provoke it. Kernel
> 2.4.9 to 2.4.13.  When it occurs I lose about 30MB a day.

Compare snapshots of /proc/slabinfo before and after.

It may be completely harmless; e.g. a slab cache. free is unfortunately 
quite misleading with newer kernels; it doesn't give information about
many important caches (e.g. not about the slab caches) 

-Andi


