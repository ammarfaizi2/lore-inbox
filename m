Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUANXZG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUANXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:17:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:60910 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266334AbUANXQs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:16:48 -0500
Message-ID: <4005A03A.40409@mvista.com>
Date: Wed, 14 Jan 2004 12:02:02 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401101611.53510.amitkale@emsyssoft.com> <400237F0.9020407@mvista.com> <200401122020.08578.amitkale@emsyssoft.com> <40046296.1050702@mvista.com> <20040114063155.GF28521@waste.org>
In-Reply-To: <20040114063155.GF28521@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Tue, Jan 13, 2004 at 01:26:46PM -0800, George Anzinger wrote:
> 
>>>Serial interface should be configurable independent of kgdb and may not be 
>>>configured if ethernet interface is configured.  Serial interface is far 
>>>simpler hence superior for debugging purposes. If it's available, using 
>>>ethernet interface is out of question. Ethernet interface can be used when 
>>>serial hardware isn't present or is being used for some other purposes.
>>>
>>
>>I rather think that the serial inteface should be the fall back unless the 
>>user has told us at configure time that it is not available.  I am not 
>>prepared to make a statment that it is better than eth.  The eth intface 
>>should be much faster, but it has its fingers into a large part of the 
>>kernel that MAY be the subject of the current session.  Thus, I think that 
>>eth may be better, IF one is clearly not involved in debugging those areas 
>>of the kernel.  (Which, by the way, we need to enumerate at some point.)
> 
> 
> I have in mind creating some other interfaces that will be on a par
> with serial for early boot availability. So lets not frame this in
> terms of eth vs serial. We can throw a priority int in the config
> interface, stuff that in the plug struct, and pick whichever one's
> highest and claims to be currently available.
> 
Right.  I had hoped that we might one day be able to use the USB and I am sure 
there are others.


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

