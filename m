Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbULNQUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbULNQUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULNQUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:20:38 -0500
Received: from fire.osdl.org ([65.172.181.4]:44994 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261538AbULNQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:17:27 -0500
Message-ID: <41BF0F1A.6080001@osdl.org>
Date: Tue, 14 Dec 2004 08:04:42 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to get the whole information dumped from kernel
References: <20041214152730.74648.qmail@web51509.mail.yahoo.com>
In-Reply-To: <20041214152730.74648.qmail@web51509.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Park Lee wrote:
> On  Sat, 11 Dec 2004 at 10:53, Linus Torvalds wrote:
> 
>>- for one-off things where you don't want to go to
> the bother, but
>>just want to find one problem, you can do:
>>     [snipped]     
>>   - disable CONFIG_CALLSYM, which makes the oops
> much harder to
>>     read, but also more compact. Then look up the
> addresses by hand
>>     with "gdb vmlinux" or use the ksymoops program.
>  
>  
> In /usr/src/linux/.config, we can see that
> "CONFIG_KALLSYMS=y" is included in the General setup
> section like the following: 
>  
> #
> # General setup
> #
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_SYSCTL=y
> CONFIG_AUDIT=y
> CONFIG_AUDITSYSCALL=y
> CONFIG_LOG_BUF_SHIFT=17
> CONFIG_HOTPLUG=y
> # CONFIG_IKCONFIG is not set
> # CONFIG_EMBEDDED is not set
> CONFIG_KALLSYMS=y
> CONFIG_FUTEX=y
> CONFIG_EPOLL=y
> CONFIG_IOSCHED_NOOP=y
> CONFIG_IOSCHED_AS=y
> CONFIG_IOSCHED_DEADLINE=y
> CONFIG_IOSCHED_CFQ=y
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  
> But, when we run 'make menuconfig', we can only see
> that the General setup section only contains the
> following items:
>   
>   [*] Support for paging of anonymous memory (swap)   
> 
>   [*] System V IPC                                 
>   [*] POSIX Message Queues                         
>   [*] BSD Process Accounting                          
>    
>   [*] Sysctl support                                  
>      
>   [*] Auditing support                                
>      
>   [*]   Enable system-call auditing support           
>       
>   (17) Kernel log buffer size (16 => 64KB, 17 =>
> 128KB)        
>   [*] Support for hot-pluggable devices               
>           
>   [ ] Kernel .config support                          
>          
>   [ ] Configure standard kernel features (for small
> systems)  ---> 

Right here, press Y and the press Enter and more options
(including KALLSYMS) will appear for you to make.

>   [*] Optimize for size                               
>  
> Then, It seems that there is no place to disable
> CONFIG_KALLSYMS (i.e. turn 'CONFIG_KALLSYMS=y' to
> 'CONFIG_KALLSYMS is not set'), How can I turn off the
> 'CONFIG_KALLSYMS' item?? Is CONFIG_KALLSYMS=y set
> automatically by system?

-- 
~Randy
