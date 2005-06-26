Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFZO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFZO7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVFZO7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 10:59:08 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:20667 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261300AbVFZO7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 10:59:04 -0400
Message-ID: <42BEC2B6.6020905@comcast.net>
Date: Sun, 26 Jun 2005 10:59:02 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Warne <nick@linicks.net>
CC: linux-kernel@vger.kernel.org
Subject: 8139too PCI IRQ issues   WAS Re: 2.6.12 breaks 8139cp
References: <200506261446.57802.nick@linicks.net>
In-Reply-To: <200506261446.57802.nick@linicks.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are you supposed to do though if you dont have that bios option.  
And if the bios wasn't changed between kernel version upgrades, what is 
the PCI irq subsystem doing now that requires such a change? And what 
makes it possible to remove the problem with reverting just the 8139too 
driver ...   There is a quirk here, but the fix should be in the kernel, 
since not all bios' allow you to make the fix yourself. 

Nick Warne wrote:

>>It seems that whatever is causing the bug i'm seeing was a change that 
>>involved the network driver/interrupt subsystem and not actually the 
>>8139too driver, this was done at around 2.6.3-2.6.4.   A NAPI patch that 
>>was introduced at that time basically reverted the interrupt function 
>>and removed the poll functions from the driver (via not enabling napi in 
>>Kconfig).
>>    
>>
>
>Ummm.  I was involved in this.  Here is the 'final' post after Mr Hirofumi 
>found the cause of my issues:
>
>http://www.ussg.iu.edu/hypermail/linux/kernel/0402.3/1709.html
>
>But I looked at what he said and found the real problem on my system (after 
>all that):
>
>http://www.ussg.iu.edu/hypermail/linux/kernel/0403.1/1537.html
>
>Nick
>  
>

