Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSHPLOA>; Fri, 16 Aug 2002 07:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSHPLOA>; Fri, 16 Aug 2002 07:14:00 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:61936 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318295AbSHPLN7>; Fri, 16 Aug 2002 07:13:59 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <20020815165617.GE14394@dualathlon.random>
References: <1028771615.22918.188.camel@cog>
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
	<1028860246.1117.34.camel@cog>  <20020815165617.GE14394@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Aug 2002 12:15:59 +0100
Message-Id: <1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 17:56, Andrea Arcangeli wrote:
> sorry but I don't see the point of badtsc only in kernel.
> 
> If the TSC is bad that will be in particular bad from userspace where
> there's no hope to know what CPU you're running on.

You can still do meaningful measurements for things like profiling
because the cpu hop is statistically uninteresting.

> How do you detect the NUMA hw? That would be a nice addition so the
> numa-Q users won't be required to add notsc to the append lilo line.

The current Summit patches from IBM (the ones James did and merged in
-ac) do detection for Numa-Q and Summit. Those are pending for Marcelo
right now so if you have a better way I'd like to know.


Alan

