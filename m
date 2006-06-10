Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWFJLiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWFJLiG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 07:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWFJLiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 07:38:06 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:32694 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751489AbWFJLiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 07:38:05 -0400
Date: Sat, 10 Jun 2006 06:37:12 -0500
From: Hui Zhou <hzhou@hzsolution.net>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Frustrating Random Reboots, seeking suggestions
Message-ID: <20060610113712.GA2388@smtp.comcast.net>
References: <20060609145757.GB1640@smtp.comcast.net> <Pine.LNX.4.64.0606091058320.4969@turbotaz.ourhouse> <20060610023719.GA10857@smtp.comcast.net> <200606101052.05212.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <200606101052.05212.ioe-lkml@rameria.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2006 at 10:52:03AM +0200, Ingo Oeser wrote:
>Hi Hui Zhou,
>
>On Saturday, 10. June 2006 04:37, Hui Zhou wrote:
>> Thanks. memtest86 passes 6 times without errors. Serial console didn't 
>> show up anything (it just reboots). 
>> 
>> Anyway, I finally suspect the debian libmpeg binary is at fault. I 
>> manually build it from src and statically linked to the `bkmark' 
>> program. It seems cured the random reboots problem. It runs 
>> successfully for 4 times. However, the fifth time it ended up in a `D' 
>> state. The only system call it uses is libc file IO and some signal 
>> passing. Any comment on the cause?
>
>Do you also see the problem if you decode from file to memory only.
>without any display?
>
>NO: You have some problem with your peripherals.

There is no display. The program just marks the blank scene or scene 
changes and dumps the results to a text file for another program to 
analyze.
>
>YES: Check for heat and power problems.
>
>	If you are brave you could try some cpuburn variant to put the heat 
>	to the maximum.
>
>	WARNING: This could kill your CPU and might void your warranty, 
>		since this is not "normal use" of your CPU :-)

No, I am not that brave. :) However, I am now faily certain it is not 
heat problem. After relinked with a new libmpeg binary, it hasn't 
rebooted yet (8+hours). Any possibility that some binary code can 
randomly trigger reboots on certain CPUs? (Sounds absurd, but only you 
kernel guys have better answers.)

Now I am concerned with the `D' state. Is that some problem from the 
kernel?

Thanks.

-- 
Hui Zhou
