Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUCDDPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCDDPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:15:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16650
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261422AbUCDDPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:15:18 -0500
Date: Thu, 4 Mar 2004 04:15:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
Message-ID: <20040304031557.GD4922@dualathlon.random>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com> <1078359137.10076.193.camel@cog.beaverton.ibm.com> <1078359191.10076.195.camel@cog.beaverton.ibm.com> <1078359248.10076.197.camel@cog.beaverton.ibm.com> <20040304005542.GZ4922@dualathlon.random> <40469194.5080506@redhat.com> <20040304024739.GA4922@dualathlon.random> <1078368889.10076.255.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078368889.10076.255.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 06:54:49PM -0800, john stultz wrote:
> On Wed, 2004-03-03 at 18:47, Andrea Arcangeli wrote:
> > And sysenter is at a fixed address in 2.6 x86 too (it doesn't even
> > change between different kernel compiles).
> 
> Actually, the 4G patch pushes vsysenter down a page, and glibc seems to
> handle this properly.

this is nice for x86 indeed. This has never been a concern in x86-64
since there's no need to move the address space there.

so in short this means 64G machines using 4:4 will need two tries to get
to the root shell, every bother box will succeed at the first try ;).
