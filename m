Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVFWNq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVFWNq0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVFWNq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:46:26 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:41936 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262507AbVFWNpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:45:42 -0400
Date: Thu, 23 Jun 2005 09:45:27 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
In-reply-to: <20050623075601.GA23320@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>,
       "K.R. Foley" <kr@cybsft.com>, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Message-id: <200506230945.27358.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050608112801.GA31084@elte.hu>
 <Pine.LNX.4.58.0506221848480.23287@echo.lysdexia.org>
 <20050623075601.GA23320@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 June 2005 03:56, Ingo Molnar wrote:
>* William Weston <weston@sysex.net> wrote:
>> Hi Ingo,
>>
>> I just found this oops from last night on my home audio/midi
>> system (AthlonXP running -48-37).  I was burning a CD at the time,
>> and the scsi error precedes the oops trace by 46 seconds.  The
>> system is still up and fully functional, BTW.
>
>Found the bug and it should be fixed in -50-16 and later kernels. I
> had debugging code that called into print_IO_APIC() (when you had
> an scsi interrupt timeout), but that function was an __init call -
> so the kernel called into an already freed code area.
>
> Ingo
I just tried to build & boot 50-17 in mode=3, no hardirq's and got the 
same boot failure as mode 4 for 50-06 gave:

On screen:

Checking to see if this processor honours the WP bit even in 
supervisor mode...  OK.

and its stuck, needs a hardware reset to recover.  The next line 
should be the bogomips check/report I believe.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
