Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVA0U6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVA0U6Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVA0Uyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:54:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:25078 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261197AbVA0Uxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:53:40 -0500
Message-ID: <41F954CE.6040504@mvista.com>
Date: Thu, 27 Jan 2005 12:53:34 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george@mvista.com
CC: Ingo Molnar <mingo@elte.hu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com> <20050121082125.GA28267@elte.hu> <41F0BFA4.5030107@mvista.com> <20050121084557.GA29550@elte.hu> <41F0C33D.60908@mvista.com> <20050121090014.GA30379@elte.hu> <41F0C686.5070903@mvista.com>
In-Reply-To: <41F0C686.5070903@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> Ingo Molnar wrote:
> 
>> * George Anzinger <george@mvista.com> wrote:
>>
>>
>>> What I am suggesting is spliting the mark code so that it would only
>>> grap the offset (current TSC in most systems) during interrupt
>>> processing.  Applying this would be done later in the thread.  Since
>>> it is not applying the offset, the xtime_lock would not need to be
>>> taken.
>>
>>
>>
>> ok, you are right, and this would be fine with me. Wanna take a shot at
>> it? I've uploaded the -03 patch which is my most current tree. (with the
>> do_timer() moving done already.) I've reviewed the TSC offset codepath
>> again and i'm not sure where i got the 10 usecs from ... it's a pretty
>> cheap codepath that can be done in the direct interrupt just fine.
>>
> Tomorrow, uh, later today.  Need some sleep now...

Ingo, I have been looking at the code being proposed by John Stultz.  It looks 
like it handles all the issues I am talking about here.  I think it would be 
best to leave the RT patch as it is WRT this issue and work on getting John's 
patch ready for prime time as any work I would do here will just get tossed when 
his patch hits the steet.

Meanwhile, I will (already have) get HRT working on RT and make that available 
in the next few days.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

