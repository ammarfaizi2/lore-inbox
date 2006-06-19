Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbWFSXds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWFSXds (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWFSXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:33:48 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:56487 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S964986AbWFSXdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:33:47 -0400
Date: Mon, 19 Jun 2006 17:32:12 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC/SERIOUS] grilling troubled CPUs for fun and profit?
In-reply-to: <fa.so5wrYE6MzA2swzlOE1Xjw9iqvk@ifi.uio.no>
To: Dave Jones <davej@redhat.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel@vger.kernel.org
Message-id: <449733FC.4030701@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.pC0NfRl4O1eOCqPOBXy8f+7gbqU@ifi.uio.no>
 <fa.so5wrYE6MzA2swzlOE1Xjw9iqvk@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Wrong.
> 
>  > Try it. I have had
>  > broken plastic heat-sink hold-downs let the entire heat-sink fall off
>  > the CPU. The machine just stops.
> 
> Your single datapoint is just that, a single datapoint.
> There are a number of reported cases of CPUs frying themselves.
> Here's one: http://www.tomshardware.com/2001/09/17/hot_spot/page4.html
> Google no doubt has more.
> 
> Another anecdote: Upon fan failure, I once had an athlon MP *completely shatter*
> (as in broke in two pieces) under extreme heat.
> 
> This _does_ happen.

This is entirely dependent on the CPU type. Intel CPUs for years would
shut down on over-temperature (the THERMTRIP signal). Pentium 4s will
additionally throttle the CPU clock before reaching that temperature.
Older AMD CPUs like that Athlon MP indeed had no internal temperature
limiting - if there was any it was part of the motherboard, which often
responded too slowly such that it was indeed possible to smoke
(literally) CPUs if the heatsink fell off. Athlon 64/Opteron CPUs will
shut down on exceeding a critical temperature.

> cpu_relax() and friends aren't going to save a box in light of
> a fan failure in my experience.  
> However for a box which has locked up (intentionally)
> running instructions that do save power in a loop has obvious advantages.

cpu_relax likely doesn't save a whole lot of power, I wouldn't think..
However, at least in the first case that was pointed out, halt() is
called first, the loop only is there in case the halt() somehow exits
for some reason.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


