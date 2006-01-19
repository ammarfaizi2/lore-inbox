Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161442AbWASVvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161442AbWASVvm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161443AbWASVvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:51:42 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:19447 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1161442AbWASVvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:51:41 -0500
Message-ID: <43D0098D.5080000@wildturkeyranch.net>
Date: Thu, 19 Jan 2006 13:50:05 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@mwildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Clean up of hrtimer code.
References: <43CEF172.2000308@mvista.com>	 <1137701896.7947.56.camel@localhost.localdomain>	 <43CFFC60.8010405@mvista.com> <1137704954.7947.65.camel@localhost.localdomain>
In-Reply-To: <1137704954.7947.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:

>George,
>
>On Thu, 2006-01-19 at 12:53 -0800, George Anzinger wrote:
>  
>
>>>The assumption that the CLOCK_REALTIME/MONOTONIC relationship is valid
>>>for all additional clocks is not correct.
>>>      
>>>
>>Well, it is until it isn't.  There really does need to be a paring of some 
>>sort to sort out the ABS flag.
>>    
>>
>
>How is this applicable to some additional non posix clocks ? It applies
>to CLOCK_MONOTONIC and CLOCK_REALTIME, but nothing speaks against
>implementing CLOCK_WHATEVER with a totally different behaviour vs. the
>ABS_TIME flag. Am I missing something ?
>
>  
>
How ever it is done the selection of a base depends on the mode and the 
clock.  I suggested mapping this via
odd/ even, but, I think what is needed is some way to code this into 
hrtimer.c in a reasonable way.  Your choice, really.

-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

