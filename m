Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262512AbUKQT3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262512AbUKQT3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbUKQT2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:28:01 -0500
Received: from advect.atmos.washington.edu ([128.95.89.50]:26813 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S262408AbUKQT0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:26:07 -0500
Message-ID: <419BA5C4.4020503@atmos.washington.edu>
Date: Wed, 17 Nov 2004 11:25:56 -0800
From: Harry Edmon <harry@atmos.washington.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
References: <419A9151.2000508@atmos.washington.edu> <20041116163257.0e63031d@zqx3.pdx.osdl.net> <cone.1100651833.776334.15267.502@pc.kolivas.org>
In-Reply-To: <cone.1100651833.776334.15267.502@pc.kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -12.775 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried your suggestion - no improvement.

Con Kolivas wrote:

> Stephen Hemminger writes:
>
>> On Tue, 16 Nov 2004 15:46:25 -0800
>> Harry Edmon <harry@atmos.washington.edu> wrote:
>>
>>> I have a system that is running a program that receives and sends 
>>> atmospheric data via TCP.  Most of the data is either in little 
>>> packets (between 64 and 127 bytes) and large packets (between 1024 
>>> and 1517).  I am running this on a dual Xeon box (Tyan S2721-533 
>>> motherboard) with 2 GB of memory and a Intel gigabit ethernet 
>>> (82546EB).  I have been running this under 2.6.7.  When I switch to 
>>> 2.6.9 on the same hardware, my network throughtput is cut by more 
>>> than half.  All I can tell from looking at "netstat -s" is that my 
>>> TCP resets are orders of magnitude higher under 2.6.9 than 2.6.7.  
>>> Enclosed is my 2.6.7 and 2.6.9 config files.  Anyone have any ideas 
>>> where I should look to find the problem?
>>
>>
>> Do an OpenBSD or other firewall in the way that doesn't understand 
>> window
>> scaling? OpenBSD pf doesn't correctly TCP window scaling so it ruins the
>> throughput (typically 1/4 of expected).
>
>
> Easiest way to see if this is responsible is to disable it and see if 
> the throughput improves
>
> echo 0 > /proc/sys/net/ipv4/tcp_window_scaling
>
> Cheers,
> Con


