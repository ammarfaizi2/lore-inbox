Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267657AbUIMPUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267657AbUIMPUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUIMPSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:18:08 -0400
Received: from [209.88.178.130] ([209.88.178.130]:2804 "EHLO constg.qlusters")
	by vger.kernel.org with ESMTP id S268255AbUIMPIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 11:08:52 -0400
Message-ID: <4145B750.6060900@qlusters.com>
Date: Mon, 13 Sep 2004 18:05:52 +0300
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: bugs@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: Calling syscalls from x86-64 kernel results in a crash on Opteron
 machines
References: <4145A8E1.8010409@qlusters.com> <20040913153803.A27282@infradead.org>
In-Reply-To: <20040913153803.A27282@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Mon, Sep 13, 2004 at 05:04:17PM +0300, Constantine Gavrilov wrote:
>  
>
>>Hello:
>>
>>We have a piece of kernel code that calls some system calls in kernel 
>>context (
>>    
>>
>
>Which you shouldn't do in the first place.
>  
>

Function kernel_thread() on i386 is implemented by putting the args to 
appropriate regs and calling int 0x80, resulting in a system call 
clone() on i386.

I have also found the "syscall" instruction in x86-64 kernel specific 
code (it does not call _syscall() macros directly, though). So, 
"shouldn't do" is a bit too strong.

What I am writing is an application, and not interface. As such, it is 
not much different from its requierements from a user-space application. 
If user-space application may call system calls, why a kernel space 
application cannot?

And BTW, kernel-space applications have their own place even if the 
concept seems foreign to you.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------


