Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752277AbWCKAn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbWCKAn7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752273AbWCKAn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:43:59 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:62701 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S1750755AbWCKAn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:43:59 -0500
Message-ID: <44121D44.5030008@metaparadigm.com>
Date: Sat, 11 Mar 2006 08:43:48 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Router stops routing after changing MAC Address
References: <925A849792280C4E80C5461017A4B8A20321CC@mail733.InfraSupportEtc.com> <20060310163958.1215b0c4@localhost.localdomain>
In-Reply-To: <20060310163958.1215b0c4@localhost.localdomain>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>On Fri, 10 Mar 2006 18:33:15 -0600
>"Greg Scott" <GregScott@InfraSupportEtc.com> wrote:
>
>  
>
>>Hello - This feels like a kernel issue.  I spent hours and hours and
>>hours looking for documentation and archives around this but did not
>>find anything.  
>>
>>I have a Linux router and I need the ability to swap hardware without
>>causing downtime.  The problem, of course, is ARPs.  The NICs in the
>>replacement system need the same MAC Addresses as the NICs in the
>>original system.  I'd like this all to be in the kernel and not depend
>>on a daemon process that can die.
>>
>>How to change MAC addresses is documented well enough - and it works -
>>but when I change MAC addresses, my router stops routing.  From the
>>router, I can see the systems on both sides - but the router just
>>refuses to forward packets.  Here are my little test scripts to change
>>MAC Addresses.
>>    
>>
>
>You probably just need to flush the route cache after the address change?
>  
>
Or do a gratutious arp for the address with the new HW address (tool to
do this is included in HA failover software such as heartbeat and others).

~mc
