Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263909AbUAHIHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 03:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUAHIHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 03:07:22 -0500
Received: from ns1.wanfear.com ([207.212.57.1]:9924 "EHLO ns1.wanfear.com")
	by vger.kernel.org with ESMTP id S263836AbUAHIHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 03:07:18 -0500
Message-ID: <3FFD0FAE.8050705@candelatech.com>
Date: Thu, 08 Jan 2004 00:07:10 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Problem with 2.4.24 e1000 and keepalived
References: <20040107200556.0d553c40.skraw@ithnet.com> <20040107210255.GA545@alpha.home.local> <3FFCC430.4060804@candelatech.com> <20040108052000.GA8829@alpha.home.local>
In-Reply-To: <20040108052000.GA8829@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Ben,
> 
> On Wed, Jan 07, 2004 at 06:45:04PM -0800, Ben Greear wrote:
>  
> 
>>You have to bring the interface 'UP' before it will detect link,
>>with something like:  ifconfig eth2 up
> 
> 
> Don't you mean "after" instead of "before" here ? Because the case where
> it doesn't work is when everything is set up while the cable is unplugged,
> but conversely, if the system goes up with the cable plugged, setting the
> interface UP detects the link as UP and works. I believe that the problem
> is related to setting the interface UP with nothing plugged into it.

No, I meant what I said:  You have to tell many drivers to bring the interface
up before they will attempt (or at least report) link negotiation.
You do NOT have to give it an IP address or add any routes to it.

But, I don't know about your particular program, I just suspect it
is related to detecting link state.  I think tg3 detects link when
the interface is not UP, if you have some tg3 nics maybe you could
try with them?

Ben

> 
> Cheers,
> Willy
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


