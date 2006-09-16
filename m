Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWIPMIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWIPMIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWIPMIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:08:48 -0400
Received: from tentacle.s2s.msu.ru ([193.232.119.109]:6115 "EHLO
	tentacle.sectorb.msk.ru") by vger.kernel.org with ESMTP
	id S964780AbWIPMIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:08:47 -0400
Date: Sat, 16 Sep 2006 16:08:46 +0400
From: "Vladimir B. Savkin" <master@sectorb.msk.ru>
To: Andi Kleen <ak@suse.de>
Cc: Jesper Dangaard Brouer <hawk@diku.dk>,
       Harry Edmon <harry@atmos.washington.edu>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
Message-ID: <20060916120845.GA18912@tentacle.sectorb.msk.ru>
References: <4492D5D3.4000303@atmos.washington.edu> <44948EF6.1060201@atmos.washington.edu> <Pine.LNX.4.61.0606191638550.23553@ask.diku.dk> <200606191724.31305.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200606191724.31305.ak@suse.de>
X-Organization: Moscow State Univ., Institute of Mechanics
X-Operating-System: Linux 2.6.17-rc6-64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 05:24:31PM +0200, Andi Kleen wrote:
> 
> > If you use "pmtmr" try to reboot with kernel option "clock=tsc".
> 
> That's dangerous advice - when the system choses not to use
> TSC it often has a reason.

I just found out that TSC clocksource is not implemented on x86-64.
Kernel version 2.6.18-rc7, is it true?

I've also had experience of unsychronized TSC on dual-core Athlon,
but it was cured by idle=poll.

> 
> > 
> > On my Opteron AMD system i normally can route 400 kpps, but with 
> > timesource "pmtmr" i could only route around 83 kpps.  (I found the timer 
> > to be the issue by using oprofile).
> 
> Unless you're using packet sniffing or any other application
> that requests time stamps on a socket then the timer shouldn't 
> make much difference. Incoming packets are only time stamped
> when someone asks for the timestamps.
> 
It seems that dhcpd3 makes the box timestamping incoming packets,
killing the performance. I think that combining router and DHCP server
on a same box is a legitimate situation, isn't it?

~
:wq
                                        With best regards, 
                                           Vladimir Savkin. 

