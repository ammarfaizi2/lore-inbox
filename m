Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUCGRX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 12:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCGRX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 12:23:27 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36100
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262240AbUCGRX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 12:23:26 -0500
Date: Sun, 7 Mar 2004 18:24:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040307172407.GA4922@dualathlon.random>
References: <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143210.GA11897@elte.hu> <20040305145837.GZ4922@dualathlon.random> <20040305152622.GA14375@elte.hu> <20040305155317.GC4922@dualathlon.random> <20040307084120.GB17629@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040307084120.GB17629@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 09:41:20AM +0100, Ingo Molnar wrote:
> 
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > [...] but I'm quite confortable to say that up to 16G (included) 4:4
> > is worthless unless you've to deal with the rmap waste IMHO. [...]
> 
> i've seen workloads on 8G RAM systems that easily filled up the ~800 MB
> lowmem zone. (it had to do with many files and having them as a big

was that a kernel with rmap or w/o rmap?

> but i'm quite strongly convinced that 'getting rid' of the 'pte chain
> overhead' in favor of questionable lowmem space gains for a dying
> (high-end server) platform is very shortsighted. [getting rid of them
> for purposes of the 64-bit platforms could be OK, but the argumentation
> isnt that strong there i think.]

disagree, the reason I'm doing it is for the 64bit platforms, I can't
care less about x86. the vm is dogslow with rmap.
