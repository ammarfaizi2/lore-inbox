Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbUKWXoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbUKWXoV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKWXoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:44:07 -0500
Received: from advect.atmos.washington.edu ([128.95.89.50]:56287 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S261654AbUKWXmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:42:03 -0500
Message-ID: <41A3CAC6.1020004@atmos.washington.edu>
Date: Tue, 23 Nov 2004 15:41:58 -0800
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
References: <419A9151.2000508@atmos.washington.edu>	<20041116163257.0e63031d@zqx3.pdx.osdl.net>	<cone.1100651833.776334.15267.502@pc.kolivas.org>	<419BA5C4.4020503@atmos.washington.edu>	<1100722571.20185.9.camel@tux.rsn.bth.se>	<419BBF57.3040808@atmos.washington.edu>	<1100727847.20185.31.camel@tux.rsn.bth.se>	<41A27868.80703@atmos.washington.edu> <20041123100450.3cbb82e6@zqx3.pdx.osdl.net>
In-Reply-To: <20041123100450.3cbb82e6@zqx3.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -12.66 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the new e1000 driver with TSO off and tcp_rmem set to a max of 
1000000 (I am sure the problem is reading and not writing).  It had no 
effect.  The TCP traffic on the system is via RCP calls to port 388.  
Any other ideas?

Stephen Hemminger wrote:

>On Mon, 22 Nov 2004 15:38:16 -0800
>Harry Edmon <harry@atmos.washington.edu> wrote:
>
>  
>
>>Tried them all - none of them helped.  Use "ntop" I can see that my 
>>throughput on the Intel gigabit ethernet interface on the system maxes 
>>out at 15.2 Mbps with 2.6.9.  With 2.6.7 it made it to 35 Mbps.
>>
>>Does anyone have any other suggestions as to what to look for to 
>>diagnose this problem?
>>    
>>
>
>Well, before the TSO changes, if TSO was enabled then TCP would not obey slow
>start or do congestion control properly.  Did you increase the TCP send/receive
>buffers (sysctl's net.ipv4.tcp_rmem and net.ipv4.tcp_wmem)? You may just
>be window limited.  Also, 2.6.9 has TCP bugs with TSO that can cause panic's.
>These have been fixed in 2.6.10-rc2.
>  
>

