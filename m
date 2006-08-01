Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWHAQ6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWHAQ6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWHAQ6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:58:05 -0400
Received: from mail.tmr.com ([64.65.253.246]:56804 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751475AbWHAQ6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:58:03 -0400
Message-ID: <44CF8B94.8030506@tmr.com>
Date: Tue, 01 Aug 2006 13:12:52 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 005 of 9] md: Replace magic numbers in sb_dirty with well
 defined bit flags
References: <20060731172842.24323.patches@notabene> <1060731073218.24482@suse.de> <200607311733.12848.ioe-lkml@rameria.de>
In-Reply-To: <200607311733.12848.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

>Hi Neil,
>
>I think the names in this patch don't match the description at all.
>May I suggest different ones?
>
>On Monday, 31. July 2006 09:32, NeilBrown wrote:
>  
>
>>Instead of magic numbers (0,1,2,3) in sb_dirty, we have
>>some flags instead:
>>MD_CHANGE_DEVS
>>   Some device state has changed requiring superblock update
>>   on all devices.
>>    
>>
>
>MD_SB_STALE or MD_SB_NEED_UPDATE
>  
>
I think STALE is better, it is unambigous.

>  
>
>>MD_CHANGE_CLEAN
>>   The array has transitions from 'clean' to 'dirty' or back,
>>   requiring a superblock update on active devices, but possibly
>>   not on spares
>>    
>>
>
>Maybe split this into MD_SB_DIRTY and MD_SB_CLEAN ?
>  
>
I don't think the split is beneficial, but I don't care for the name 
much. Some name like SB_UPDATE_NEEDED or the like might be better.

>  
>
>>MD_CHANGE_PENDING
>>   A superblock update is underway.  
>>    
>>
>
>MD_SB_PENDING_UPDATE
>
>  
>
I would have said UPDATE_PENDING, but either is more descriptive than 
the original.

Neil - the logic in this code is pretty complex, all the help you can 
give the occasional reader, by using very descriptive names for things, 
is helpful to the reader and reduces your "question due to 
misunderstanding" load.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

