Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSKSPjc>; Tue, 19 Nov 2002 10:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266939AbSKSPjc>; Tue, 19 Nov 2002 10:39:32 -0500
Received: from ns.suse.de ([213.95.15.193]:14865 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266736AbSKSPjb>;
	Tue, 19 Nov 2002 10:39:31 -0500
Date: Tue, 19 Nov 2002 16:46:34 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>
Cc: Paul Larson <plars@linuxtestproject.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [LTP] Re: LTP - gettimeofday02 FAIL
Message-ID: <20021119154634.GA29949@wotan.suse.de>
References: <200211190127.gAJ1RWg11023@linux.local.suse.lists.linux.kernel> <1037713044.24031.15.camel@plars.suse.lists.linux.kernel> <p73adk5vdra.fsf@oldwotan.suse.de> <1037719651.12118.7.camel@irongate.swansea.linux.org.uk> <20021119151028.GA13979@wotan.suse.de> <1037722343.12086.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037722343.12086.16.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 04:12:23PM +0000, Alan Cox wrote:
> On Tue, 2002-11-19 at 15:10, Andi Kleen wrote:
> > It is because of the HZ=1000. See Jim Houston's mail on the same topic,
> > he analyzed the failure.
> > 
> > Basically the current code cannot handle missing ticks properly on SMP and with
> > the new 1ms tick it is much more likely that a timer interrupt gets lost.
> 
> Ok so add that to the other existing 2.5 timer handling bugs 8(

2.4 has the same problem, it is just much less likely to hit because of HZ=100

-Andi
