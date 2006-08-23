Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWHWQXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWHWQXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWHWQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 12:23:22 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31361 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S965031AbWHWQXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 12:23:21 -0400
Date: Wed, 23 Aug 2006 20:22:14 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Jari Sundell <sundell.software@gmail.com>,
       David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
       nmiell@comcast.net, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823162214.GA14623@2ka.mipt.ru>
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com> <20060822231129.GA18296@ms2.inr.ac.ru> <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com> <20060822.173200.126578369.davem@davemloft.net> <b3f268590608221743o493080d0t41349bc4336bdd0b@mail.gmail.com> <20060823065659.GC24787@2ka.mipt.ru> <20060823000758.5ebed7dd.akpm@osdl.org> <20060823075056.GA18029@2ka.mipt.ru> <20060823090920.18e4d1da.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060823090920.18e4d1da.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 20:22:22 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 09:09:20AM -0700, Andrew Morton (akpm@osdl.org) wrote:
> > I can put nanoseconds as timer interval too (with aligned_u64 as David
> > mentioned), and put it for timeout value too - 64 bit nanosecods ends up
> > with 58 years, probably enough.
> > Structures with u64 a really not so good idea.
> > 
> 
> OK.  One could do u32 seconds/u32 nsecs, but a simple aligned_u64 will be
> better for 64-bit machines, and OK for 32-bit.

aligned_u64 is not exported to userspace, so in the last patchset I just
use __u64 as syscall parameter.

-- 
	Evgeniy Polyakov
