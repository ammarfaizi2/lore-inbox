Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264648AbSJVP4n>; Tue, 22 Oct 2002 11:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264726AbSJVP4n>; Tue, 22 Oct 2002 11:56:43 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:6160 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264648AbSJVP4m>;
	Tue, 22 Oct 2002 11:56:42 -0400
Message-ID: <3DB576BB.1010404@acm.org>
Date: Tue, 22 Oct 2002 11:03:07 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Levon <levon@movementarian.org>
CC: Corey Minyard <cminyard@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022150944.GC70310@compsoc.man.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon wrote:

>On Tue, Oct 22, 2002 at 08:02:11AM -0500, Corey Minyard wrote:
>
>>Ok.  I'd be inclined to leave the high-usage things where they are, 
>>although it would be nice to be able to make the NMI watchdog a module. 
>>oprofile should probably stay where it is.  Do you have an alternate 
>>implementation that would be more efficient?
>>    
>>
>I'm beginning to think you're right. You should ask Keith Owens if kdb
>etc. can use your API successfully.
>
Ok.  Good thought, that would decouple kdb a little.

>>>>dev_name could be removed, although it would be nice for reporting 
>>>>
>>>Reporting what ? from where ?
>>>
>>Registered NMI users in procfs.
>>    
>>
>Then if you add such code, you can add dev_name ... I hate code that
>does nothing ...
>
Ok, I'll add a procfs interface then :-).  IMHO, there's a different 
between stuff in an interface that is looking forward and dead code, 
though.  If I added it later, I would break all the users.  But there is 
a balance.

>>Yes.  But I don't understand why they would be used in the notifier code.
>>    
>>
>I'm trying to reduce code duplication - you do basically the same thing
>notifier register/unregister does.
>
Ah.  Yes, there is some stuff that looks the same but is subtly 
different.  I'll see what I can do.

>btw, the stuff you add to header files should all be in asm-i386/nmi.h
>IMHO.
>
Ok, I agree.

>It would make it clear that there's a fast-path "set nmi handler" and
>the slow one, and you can document the difference there, if that's what
>we're going to do.
>
>regards
>john
>
>  
>
Thanks,

-Corey

