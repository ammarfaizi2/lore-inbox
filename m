Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbWCJB0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWCJB0k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbWCJB0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:26:39 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:40413 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932698AbWCJB0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:26:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jv3/9cQV7sRXTB7lc5LtvN3eKlLPLjppEydcvxhKkz+uF13FpcIqOjy0aUZlOmuce1XPXudJ8IVN+MJWjRQIx4rrup1stBYHTiink3XaYQ7Kehfq0eOk19NERO6vARRqsx4SUAh8H65wkpYWWqa+xLyp4+GLAbiL5T4OSesGriw=
Message-ID: <4410D607.5080102@gmail.com>
Date: Fri, 10 Mar 2006 09:27:35 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.16-rc5-m3 PATCH] inotify: add the monitor for the event
 source
References: <440F075F.1030404@gmail.com>	 <1141836798.12175.1.camel@laptopd505.fenrus.org>	 <440FBA9C.3050109@gmail.com>	 <1141882513.2883.2.camel@laptopd505.fenrus.org>	 <440FFB7F.8050902@gmail.com> <1141932941.2883.26.camel@laptopd505.fenrus.org>
In-Reply-To: <1141932941.2883.26.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>> it breaks ABI because this structure is communicated to userspace, and
>>> you change both the layout and the size of it. What else would ABI
>>> mean??
>>>   
>>>       
>> Many structures exported to user space in kernel  are undergoing some 
>> change, A good application shouldn't count on invariability forever,
>> My test application hasn't any problem before change and after change.
>>     
>
>
> this is absolutely incorrect. This is an ABI that cannot change in any
> incompatible way.
>   
>>> but... what makes you think it's not a kernel thread such as kjournald?
>>> (which have basically meaningless current)
>>>   
>>>       
>> you can get  values of these fields without any problem for kernel 
>> thread although they are useless.
>>     
>
> exactly
>
>   
>>> there is no "full path name" concept in linux like that. And even worse,
>>> many processes will not have *any* path because they have been deleted,
>>> especially the viruses will use this ;)
>>>   
>>>       
>> For this case you said, this patch has now way really, do you have a 
>> good way to handle this case?
>>     
>
> it sounds that what you want to achieve is broken in the first place...
> (or should use audit etc)
>   
As I known, BSD process audit only can be done inside a process, and 
audit result is just visible after
termination of this process, if an application wants to monitor all the 
processes, it has no way. My patch
 provides such a way bases on inotify with minimal work, it should be an 
good extension for
inotify although it can't cover all the cases.
>
>   

