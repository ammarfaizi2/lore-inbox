Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318355AbSHPNP6>; Fri, 16 Aug 2002 09:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318357AbSHPNP6>; Fri, 16 Aug 2002 09:15:58 -0400
Received: from kim.it.uu.se ([130.238.12.178]:6557 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318355AbSHPNP5>;
	Fri, 16 Aug 2002 09:15:57 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15708.64483.439939.850493@kim.it.uu.se>
Date: Fri, 16 Aug 2002 15:19:31 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
Subject: Re: [PATCH] tsc-disable_B9
In-Reply-To: <1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
References: <1028771615.22918.188.camel@cog>
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
	<1028860246.1117.34.camel@cog>
	<20020815165617.GE14394@dualathlon.random>
	<1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > On Thu, 2002-08-15 at 17:56, Andrea Arcangeli wrote:
 > > sorry but I don't see the point of badtsc only in kernel.
 > > 
 > > If the TSC is bad that will be in particular bad from userspace where
 > > there's no hope to know what CPU you're running on.
 > 
 > You can still do meaningful measurements for things like profiling
 > because the cpu hop is statistically uninteresting.

There are kernel extensions around that handle process migration across
CPUs while providing virtualised per-process TSC counts, and for which
the TSCs do NOT need to be in perfect sync.

Disabling user-space RDTSC just because the TSCs aren't in sync is stupid.

/Mikael
