Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265081AbSKNSLd>; Thu, 14 Nov 2002 13:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKNSLd>; Thu, 14 Nov 2002 13:11:33 -0500
Received: from ns.suse.de ([213.95.15.193]:61959 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265081AbSKNSLd>;
	Thu, 14 Nov 2002 13:11:33 -0500
Date: Thu, 14 Nov 2002 19:18:26 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, John Alvord <jalvo@mbay.net>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
Message-ID: <20021114191826.A11146@wotan.suse.de>
References: <p731y5owj0x.fsf@oldwotan.suse.de> <Pine.LNX.4.20.0211140929080.28420-100000@otter.mbay.net> <20021114184049.A28183@wotan.suse.de> <20021114180117.GM31697@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114180117.GM31697@dualathlon.random>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 07:01:17PM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 14, 2002 at 06:40:49PM +0100, Andi Kleen wrote:
> > > Owens' kbuild-2.5 handled it a different way and didn't need exact
> > > timings. That is especially important since nanosecond time accuracy is
> > 
> > You may not believe it, but there are projects other than the kernel
> > that do use make too.
> > 
> > > impossible if you are handling a collection of machines doing the
> > > work. NTP is accurate, but not that accurate.
> > 
> > The patch does not actually implement nanosecond resolution, but
> > jiffies resolution (1ms on 2.5), which is easily reachable with NTP.
> 
> 1msec still leave a reasonable window open IMHO. this problem would need
> sequence numbers updated atomically to be solved correctly without
> regard to the timing that may vary depending on the hardware IMHO (so
> that it could still work on a 1Thz cpu even if it's not a pratical
> matter for at least this decade).
> 

The API is ready for nanoseconds so when you feel the need you can 
convert it to using do_gettimeofday()

-Andi
