Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUC3OZa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbUC3OZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:25:30 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:4111 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263679AbUC3OZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:25:24 -0500
Date: Tue, 30 Mar 2004 16:22:15 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Len Brown <len.brown@intel.com>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
Message-ID: <20040330142215.GA21931@alpha.home.local>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com> <1080535754.16221.188.camel@dhcppc4> <20040329052238.GD1276@alpha.home.local> <1080598062.983.3.camel@dhcppc4> <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk> <Pine.LNX.4.53.0403300814350.5311@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0403300814350.5311@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 08:15:46AM -0500, Richard B. Johnson wrote:
> On Tue, 30 Mar 2004, Alan Cox wrote:
> 
> > On Llu, 2004-03-29 at 23:07, Len Brown wrote:
> > > Linux uses this locking mechanism to coordinate shared access
> > > to hardware registers with embedded controllers,
> > > which is true also on uniprocessors too.
> >
> > If the ACPI layer simply refuses to run on a CPU without cmpxchg
> > then I can't see there being a problem, there don't appear to be
> > any 386 processors with ACPI
> >
> 
> Yep, but to get to use cmpxchg, you need to compile as a '486 or
> higher. This breaks i386.

OK, so why not compile the cmpxchg instruction even on i386 targets
to let generic kernels stay compatible with everything, but disable
ACPI at boot if the processor does not feature cmpxchg ? This could
be helpful for boot/install kernels which try to support a wide
range of platforms, and may need ACPI to correctly enable interrupts
on others.

Cheers,
Willy

