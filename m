Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVHJS6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVHJS6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVHJS6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:58:52 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28421 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030189AbVHJS6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:58:52 -0400
Message-ID: <42FA4ECD.1070108@tmr.com>
Date: Wed, 10 Aug 2005 15:00:29 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: James Bruce <bruce@andrew.cmu.edu>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730120645.77a33a34.Ballarin.Marc@gmx.de>	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>	 <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz>	 <1122852234.13000.27.camel@mindpipe>  <20050731232941.GG27580@elf.ucw.cz> <1122854036.13000.33.camel@mindpipe>
In-Reply-To: <1122854036.13000.33.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-08-01 at 01:29 +0200, Pavel Machek wrote:
> 
>>Hi!
>>
>>
>>>>I'm pretty sure at least one distro will go with HZ<300 real soon now
>>>>;-).
>>>>
>>>
>>>Any idea what their official recommendation for people running apps that
>>>require the 1ms sleep resolution is?  Something along the lines of "Get
>>>bent"?
>>
>>So you busy wait for 1msec, big deal.
> 
> 
> Which requires changing all those apps.  I thought we tried not to break
> userspace with minor kernel version upgrades.

Sounds like you were wrong.

This whole thing is silly, I'm very aware of battery life issues, but in 
real ues we are talking about maybe 3% more battery life. People who are 
totally anal about it will build their own kernel, or use a vendor 
kernel with varioble tick rate, but saving <2BTU/hr is not going to let 
anyone buy a smaller A/C unit. The computer user gives off way more than 
that.

I would leave it at 1k and push for variable tick, which should make 
everyone happy.
> 
> 
>>Some machines can't even keep time properly with HZ=1000.
> 
> 
> If your workaround for broken hardware involves screwing over people
> with good hardware, it might be the wrong workaround.
> 
> 
>> Official recommendation is likely "help us
>>with CONFIG_NO_IDLE_HZ" or "get over it".
> 
> 
> IOW, "if you don't like it, get another distro, or compile your own
> kernel".
> 
> Lee
> 

