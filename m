Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUCLIDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbUCLIDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:03:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1523 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262019AbUCLIDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:03:51 -0500
Message-ID: <40516EDA.5060006@mvista.com>
Date: Fri, 12 Mar 2004 00:03:38 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
References: <20040225213626.GF1052@smtp.west.cox.net> <200403041028.33638.amitkale@emsyssoft.com> <4050D9EE.2070800@mvista.com> <200403121014.08221.amitkale@emsyssoft.com>
In-Reply-To: <200403121014.08221.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:
> On Friday 12 Mar 2004 2:58 am, George Anzinger wrote:
> 
>>Amit S. Kale wrote:
>>~
>>
>>
>>>>context any
>>>>
>>>>p fun()
>>>
>>>p fun() will push arguments on stack over the place where irq occured,
>>>which is exactly how it'll run.
>>
>>Is this capability in kgdb lite?  It was one of the last things I added to
>>-mm version.
> 
> 
> No! It's not present in kgdb heavy also. All you can do is set $pc, continue.

Possibly I can help here.  I did it for the mm version.  It does require a 
couple of asm bits and it sort of messes up the set/fetch memory, but it does do 
the job.
> 
> -Amit
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

