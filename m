Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSGZRfw>; Fri, 26 Jul 2002 13:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317867AbSGZRfw>; Fri, 26 Jul 2002 13:35:52 -0400
Received: from cm61-15-171-191.hkcable.com.hk ([61.15.171.191]:12416 "EHLO
	host1.home.shaolinmicro.com") by vger.kernel.org with ESMTP
	id <S316824AbSGZRfv>; Fri, 26 Jul 2002 13:35:51 -0400
Message-ID: <3D41892B.8020908@shaolinmicro.com>
Date: Sat, 27 Jul 2002 01:38:51 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: ShaoLin Microsystems Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: CPU load
References: <1026312615.6584.18.camel@star15.staff.shaolinmicro.com> 	<20020710165443.GA15916@holomorphy.com> <1026323370.1352.70.camel@sinai>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>On Wed, 2002-07-10 at 09:54, William Lee Irwin III wrote:
>
>  
>
>>Examine the avenrun array declared in kernel/timer.c in a manner similar
>>to how loadavg_read_proc() in fs/proc/proc_misc.c does.
>>    
>>
>
>David, I wanted to add that we formalized the locking rules on
>avenrun[3] a couple kernel revisions ago.
>
>In 2.4, I believe it is implicitly assumed you will do a cli() before
>accessing the data (if you want all 3 values to be in sync you need the
>read to be safe).
>
>In 2.5, grab a read_lock on xtime_lock and go at it.
>
>	Robert Love
>  
>

Thanks for your information. I think having a generic interface to 
deterining CPU load of the system can help developers to determine some 
task schdeuling policy to make the system more efficient utilise the 
systems processing power. For example, I would not want to do some 
intensive processing job when CPU load is high, but I can leaving this 
work util the CPU load is not high (for non-urgent tasks).

regards,
David

regards,
David

