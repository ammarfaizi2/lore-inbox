Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbULVAbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbULVAbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbULVA3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:29:45 -0500
Received: from ns2.priorweb.be ([213.193.229.2]:19915 "HELO ns2.priorweb.be")
	by vger.kernel.org with SMTP id S261925AbULVA3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:29:04 -0500
Message-ID: <41C8B330.8050803@joow.be>
Date: Wed, 22 Dec 2004 00:35:12 +0100
From: Pieter Palmers <pieterp@joow.be>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: girish wadhwani <girish.wadh@gmail.com>
CC: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>,
       Arne Caspari <arnem@informatik.uni-bremen.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de>	 <41C694E0.8010609@informatik.uni-bremen.de>	 <20041220175156.GW21288@stusta.de>	 <1103576759.1252.93.camel@krustophenia.net> <e2e1047f04122013493f5b0151@mail.gmail.com>
In-Reply-To: <e2e1047f04122013493f5b0151@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

girish wadhwani wrote:

>>Please, can't you just hold off on breaking the ieee1394 API at all for
>>now?  Currently there are no supported IEEE-1394 audio devices.  This is
>>a big deal as most new pro audio interfaces are IEEE-1394 devices.
>>There are a few under development, see http://freebob.sf.net.  But they
>>don't work yet.  If you rip out half the API you will make it that much
>>harder for these developers, by requiring them to be kernel hackers as
>>well as driver writers.
>>
>>How about waiting until there is _one_ IEEE-1394 audio driver in the
>>tree before breaking the API?
>>    
>>
>
>I don't think the symbols are an issue for the Freebob project.
>Atleast, not right now. The code doesn't use the symbols. Most of the
>driver is intended to be in userspace anyways.
>Moreover, if you are going to break in the interface, you might as
>well do it before the driver
>is written rather than after.
>
>Just my 2c.
>
>-Girish   
>  
>
At this point were not looking at any kernel symbols at all. The driver 
is intended indeed as a userspace driver, depending heavily on the 
userspace libs available. I personally would go to kernel space only if 
perfomance issues arise. Or maybe if implementing an ALSA kernel space 
driver would be easier than implementing it in user space (small chance).

So wrt to the kernel symbols, I personally don't mind them changing... I 
have to learn them from scratch anyway (as you point out).

And should we be implementing some sort of kernel driver, chances are 
that it will only implement the AMDTP packaging and ISO transport. 
Connection management and other non-RT tasks will most likely remain in 
user space, based upon well-tested libs. So the number of interface 
functions used will be rather small, and they will probably be available 
anyway because other drivers also use them.

And isn't driver writing a bit of kernel hacking anyway? As far as I 
know, you have to be very aware of kernel issues/internals when writing 
a driver...

Greets,

Pieter Palmers
Freebob developer

>>Lee
>>
>>
>>-------------------------------------------------------
>>SF email is sponsored by - The IT Product Guide
>>Read honest & candid reviews on hundreds of IT Products from real users.
>>Discover which products truly live up to the hype. Start reading now.
>>http://productguide.itmanagersjournal.com/
>>_______________________________________________
>>mailing list linux1394-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/linux1394-devel
>>
>>    
>>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now. 
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>mailing list linux1394-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux1394-devel
>
>  
>

