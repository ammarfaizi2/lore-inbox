Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVDMLAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDMLAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVDMLAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:00:54 -0400
Received: from indonesia.procaptura.com ([193.214.130.21]:56734 "EHLO
	indonesia.procaptura.com") by vger.kernel.org with ESMTP
	id S261304AbVDMLAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:00:43 -0400
Message-ID: <425CFBDA.9040301@procaptura.com>
Date: Wed, 13 Apr 2005 13:00:42 +0200
From: Toralf Lund <toralf@procaptura.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: insmod segfault in pci_find_subsys()
References: <423A9B65.1020103@procaptura.com> <20050318170709.GD14952@kroah.com> <42496309.3080007@procaptura.com> <20050413071233.GB25581@kroah.com>
In-Reply-To: <20050413071233.GB25581@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Mar 29, 2005 at 04:15:37PM +0200, Toralf Lund wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>On Fri, Mar 18, 2005 at 10:12:05AM +0100, Toralf Lund wrote:
>>>
>>>
>>>      
>>>
>>>>Am I seeing an issue with the PCI functions here, or is it just that I 
>>>>fail to spot an obvious mistake in the module itself?
>>>>  
>>>>
>>>>        
>>>>
>>>I think it's a problem in your code.  I built and ran the following
>>>example module just fine (based on your example, which wasn't the
>>>smallest or cleanest...), with no oops.  Does this code work for you?
>>>
>>>
>>>      
>>>
>>OK, I've finally been able to test this, and no, it does not work. 
>>insmod segfaults and the system log says
>>
>>kernel: Unable to handle kernel paging request at virtual address 533e3762
>>    
>>
>
>Then I think you have a broken build system or makefile or gcc.  It
>works fine here.
>  
>
Yes. You are right. I actually mentioned this on a different thread: I 
eventually found out that the kernel was compiled with -mregparam=3, and 
the module was not. This option seems to have been added to the default 
config and/or Red Hat's build setup sometime before the current kernel 
release, but after the start of the 2.6 series...

- Toralf

