Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbUKVXmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUKVXmC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUKVXlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:41:46 -0500
Received: from advect.atmos.washington.edu ([128.95.89.50]:59628 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S262445AbUKVXiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:38:25 -0500
Message-ID: <41A27868.80703@atmos.washington.edu>
Date: Mon, 22 Nov 2004 15:38:16 -0800
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Con Kolivas <kernel@kolivas.org>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
References: <419A9151.2000508@atmos.washington.edu>	 <20041116163257.0e63031d@zqx3.pdx.osdl.net>	 <cone.1100651833.776334.15267.502@pc.kolivas.org>	 <419BA5C4.4020503@atmos.washington.edu>	 <1100722571.20185.9.camel@tux.rsn.bth.se>	 <419BBF57.3040808@atmos.washington.edu> <1100727847.20185.31.camel@tux.rsn.bth.se>
In-Reply-To: <1100727847.20185.31.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -12.68 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried them all - none of them helped.  Use "ntop" I can see that my 
throughput on the Intel gigabit ethernet interface on the system maxes 
out at 15.2 Mbps with 2.6.9.  With 2.6.7 it made it to 35 Mbps.

Does anyone have any other suggestions as to what to look for to 
diagnose this problem?

Martin Josefsson wrote:

>On Wed, 2004-11-17 at 22:15, Harry Edmon wrote:
>  
>
>>No, it is not loaded.  Here is the list of loaded modules under 2.6.9:
>>    
>>
>
>Ok, then it's something else, maybe the TSO changes...
>
>Here's some thigs to try:
>
>You can see the current settings, TSO etc, with
>
>'ethtool -k eth0'
>and disable TSO with
>'ethtool -K eth0 tso off'
>
>If that doesn't help there's more things to try.
>
>I don't know anything about the diffrent TCP congestion algorithms
>(Stephen does), but you could try disabling BIC.
>
>echo 0 > /proc/sys/net/ipv4/tcp_bic
>
>(continuing with things I hardly know anything about...)
>
>Or maybe the autotuning receive buffer, try disabling that with
>
>echo 0 > /proc/sys/net/ipv4/tcp_moderate_rcvbuf
>
>
>Stephen, any more things to try ?
>
>  
>

