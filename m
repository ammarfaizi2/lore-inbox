Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbTCFBsr>; Wed, 5 Mar 2003 20:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTCFBsr>; Wed, 5 Mar 2003 20:48:47 -0500
Received: from [12.36.124.2] ([12.36.124.2]:1673 "EHLO intranet.resilience.com")
	by vger.kernel.org with ESMTP id <S267636AbTCFBsq>;
	Wed, 5 Mar 2003 20:48:46 -0500
Mime-Version: 1.0
Message-Id: <p0521050dba8c56efeacb@[10.2.0.101]>
In-Reply-To: <3E66964E.6050101@wmich.edu>
References: <20030303123029.GC20929@atrey.karlin.mff.cuni.cz>
 <p05210507ba8c20241329@[10.2.0.101]>
 <3E66842F.9020000@WirelessNetworksInc.com>
 <200303061038.44872.kernel@kolivas.org>
 <20030305235057.M20511@flint.arm.linux.org.uk>
 <3E66964E.6050101@wmich.edu>
Date: Wed, 5 Mar 2003 17:58:52 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Linux vs Windows temperature anomaly
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:29pm -0500 3/5/03, Ed Sweetman wrote:
>I've never heard of running linux frying someone's cpu. I could see 
>frying a power supply because cheap power supplies will fail after a 
>while of idle/load cycles that linux is good at using. I really dont 
>see how else linux could be more "busy" than winows especially since 
>windows has 5 or 6 spyware ad programs running behind the scenes all 
>the time anyway and the virus scanner having to check every 
>instruction would definitly lead to a higher cpu average than a 
>linux box ding the same things minus the spyware and virus scanner. 
>It just doesn't make any sense. Erroring out more in linux than 
>windows...possibly yes depending on which version but not hardware 
>damage under normal use.

I don't think it's a case of "busy" per se. Both systems are 100% 
occupied with a userland memory test (it just mallocs and locks a 
biggish buffer, and does reads and writes of various patters). One 
pass of the test takes about 104 seconds on both systems (presumably 
it's memory-bound, so compiler differences aren't showing up).

It was suggested off-list that I compare the chipset config registers 
to see if anything is different. I've been meaning to do that, but 
just looking at the registers, I don't see anything that would affect 
FSB timing, or the FSB at all, for that matter. Naetheless, I'll do 
the comparison as soon as I dig up an lspci equivalent for Win2K.

As for temperature differences, the heat sink temperature (at least) 
doesn't seem to differ appreciably between the systems, which is what 
I'd expect with essentially the same load on each.

I'm wondering, somewhat ignorantly, if there might be some kind of 
CPU configuration that Windows is adjusting, as some kind of 
workaround or the like. I don't suppose that this is the best place 
to ask how to read MSRs from Windows....
-- 
/Jonathan Lundell.
