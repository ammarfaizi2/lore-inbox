Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132813AbRDISZQ>; Mon, 9 Apr 2001 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132815AbRDISZG>; Mon, 9 Apr 2001 14:25:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:20328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132813AbRDISY4>; Mon, 9 Apr 2001 14:24:56 -0400
Date: Mon, 9 Apr 2001 20:26:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Manfred Spraul <manfred@colorfullife.COM>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: softirq buggy
Message-ID: <20010409202618.B8138@athlon.random>
In-Reply-To: <3AD1D4A3.1E7FACD8@colorfullife.com> <200104091748.VAA03998@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104091748.VAA03998@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Mon, Apr 09, 2001 at 09:48:02PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 09:48:02PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > Btw, you don't schedule the ksoftirqd thread if do_softirq() returns
> > from the 'if(in_interrupt())' check.
> 
> ksoftirqd will not be switched to before the first schedule
> or ret form syscall, when softirqs will be processed in any case.
> So, wake up in this case would be mistake.

Agreed.

> The _real_ problem is softirqs generated from another softirqs:
> additonal thread is made _not_ to speed up softirqs, but to _tame_
> them (if I understood Andres's explanations correctly).

Exactly.

Andrea
