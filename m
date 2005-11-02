Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVKBP3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVKBP3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 10:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVKBP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 10:29:50 -0500
Received: from [85.8.13.51] ([85.8.13.51]:30869 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965081AbVKBP3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 10:29:49 -0500
Message-ID: <4368DB5C.7070609@drzeus.cx>
Date: Wed, 02 Nov 2005 16:29:32 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: swsusp not able to stop tasks
References: <4368BDA7.6060401@drzeus.cx> <20051102133825.GG30194@elf.ucw.cz>
In-Reply-To: <20051102133825.GG30194@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   
>> I'm having problem with swsusp in the recent kernels (somewhere around 
>> the late 2.6.14 rc:s). It says it cannot suspend all tasks:
>>     
>
>   
>> [ 7223.525225] Stopping tasks: 
>> =======================================================================================================================================
>> [ 7229.532506]  stopping tasks failed (1 tasks remaining)
>> [ 7229.532529] Restarting tasks...<6> Strange, kauditd not stopped
>>     
>
> What is this kauditd? Try turning auditing off in kernel config, and
> it should go away. If it does, add try_to_freeze() at place where
> sleep is possible into kauditd...
>
>   

That it did. And the machine suspends fine with audit removed. I'll have 
a look at inserting those try_to_freeze().

>> Some late addition (post 2.6.14) also makes my keyboard crap out after 
>> one of these cycles. Not sure it the TSC funkiness was present
>> before this.
>>     
>
> Is that reproducible?
> 								Pavel
>   

Somewhat. My short test now seems to indicate that it happens about 50% 
of the time.

Rgds
Pierre
