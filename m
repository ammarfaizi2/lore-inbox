Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUCDCnr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUCDCnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:43:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:23959 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261411AbUCDCnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:43:45 -0500
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
From: john stultz <johnstul@us.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Jamie Lokier <jamie@shareable.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Joel Becker <Joel.Becker@oracle.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <40469194.5080506@redhat.com>
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>
	 <1078359137.10076.193.camel@cog.beaverton.ibm.com>
	 <1078359191.10076.195.camel@cog.beaverton.ibm.com>
	 <1078359248.10076.197.camel@cog.beaverton.ibm.com>
	 <20040304005542.GZ4922@dualathlon.random>  <40469194.5080506@redhat.com>
Content-Type: text/plain
Message-Id: <1078368197.10076.252.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 03 Mar 2004 18:43:18 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-03 at 18:16, Ulrich Drepper wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Andrea Arcangeli wrote:
> 
> > This is just like the kernel patches people proposes when they get
> > vmalloc LDT allocation failure, because they run with the i686 glibc
> > instead of the only possibly supported i586 configuration. It makes no
> > sense to hide a glibc inefficiency
> 
> You apparently still haven't gotten any clue since your whining the last
> time around.  Absolute addresses are a fatal mistake.

Before we start up this larger debate again, might there be some short
term solution for my patch that would satisfy both of you?

If I understand the earlier arguments, if we're going to have the
dynamically relocated segments at some point, I agree that absolute
addresses are going to have problems. However, if I'm not mistaken, this
problem already exists w/ the vsyscall-sysenter code, correct? 

What is the plan for avoiding the absolute address issue there? If I
implemented the vsyscall-gettimeofday code in a similar manner (as
Andrea suggested), could the planned solution for vsyscall-sysenter be
applied here as well?

thanks
-john





