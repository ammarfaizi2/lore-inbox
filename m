Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbUCEO7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbUCEO7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:59:11 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32776
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262615AbUCEO7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:59:08 -0500
Date: Fri, 5 Mar 2004 15:59:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305145947.GA4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305143425.GA11604@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 03:34:25PM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > > vsyscall-sys_gettimeofday and vsyscall-sys_time could help quite some
>                                   ^^^^^^^^^^^^^^^^^
> > > for mysql. Also, the highly threaded nature of mysql on the same MM
> > 
> > he said he doesn't use gettimeofday frequently, so most of the flushes
> > are from other syscalls.
> 
> you are not reading Pete's and my emails too carefully, are you? Pete
> said:

I thought time() wouldn't be called more than 1 per second anyways, why
would anyone call time more than 1 per second?

> 
> > [...] MySQL does not use gettimeofday very frequently now, actually it
> > uses time() most of the time, as some platforms used to have huge
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > performance problems with gettimeofday() in the past.
> >
> > The amount of gettimeofday() use will increase dramatically in the
> > future so it is good to know about this matter.
> 
> 	Ingo
