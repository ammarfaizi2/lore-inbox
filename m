Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUK1X6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUK1X6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUK1X6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:58:23 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:4260 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261607AbUK1X5q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:57:46 -0500
Message-ID: <41AA6610.7020205@verizon.net>
Date: Sun, 28 Nov 2004 18:58:08 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: A M <alim1993@yahoo.com>
CC: Doug McNaught <doug@mcnaught.org>, linux-kernel@vger.kernel.org
Subject: Re: Accessing a process structure in the processes link list
References: <20041128233747.53950.qmail@web51902.mail.yahoo.com>
In-Reply-To: <20041128233747.53950.qmail@web51902.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.220.243] at Sun, 28 Nov 2004 17:57:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A M wrote:
> How would you know the offset (location of index 0 if
> it was an array or the head of link list) of that
> variable in memory, in this case it is the process
> table named task of type a pointer to task_struct? 
> 
> Any recommendation for references will be appreciated.
> 
> 
> Thanks, 
> 
> Ali 
> 

http://www.securityfocus.com/infocus/1811

is about identifying hooked syscalls, but the principles involved in locating the 
system call table could be applied to finding the process table.

P. S.  You can locate the process in memory with read access to /proc/kmem or 
/proc/mem (that's a lot tougher, though), but to modify it requires write access.


> --- Doug McNaught <doug@mcnaught.org> wrote:
> 
> 
>>A M <alim1993@yahoo.com> writes:
>>
>>
>>>Would it be possible for a program running as root
>>>that wasn't compiled with the kernel to access a
>>>process structure in the processes link list? 
>>
>>Yes, but see below.
>>
>>
>>>I've read an article about hiding processes and
>>
>>the
>>
>>>article made sound so easy to access the link list
>>
>>and
>>
>>>hide a process, how easy is it?
>>
>>You need read access to /dev/kmem and a fairly
>>intimate knowledge of
>>the kernel data structures in question.
>> 
>>
>>>Is it possible to a process to access its own
>>
>>entry in
>>
>>>the processes link list?
>>
>>Not without read access to the kmem device...
>>
>>-Doug
>>
> 
> 
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> The all-new My Yahoo! - Get yours free! 
> http://my.yahoo.com 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

