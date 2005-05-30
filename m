Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVE3EBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVE3EBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 00:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVE3EBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 00:01:13 -0400
Received: from mail.avantwave.com ([210.17.210.210]:10370 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261513AbVE3EBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 00:01:05 -0400
Message-ID: <429A8FFD.40606@avantwave.com>
Date: Mon, 30 May 2005 12:01:01 +0800
From: Tomko <tomko@avantwave.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: question about /dev/console and /dev/tty
References: <4296C5C0.4030409@avantwave.com> <d76sqc$suq$1@news.cistron.nl>
In-Reply-To: <d76sqc$suq$1@news.cistron.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Thank you very much for the reply, but i would like to ask some more.

1. it seems we can choose which device we want for console output by 
typing this on kernel command line:
console = device , options
if i type  "console = ttyS1 " is that means kernel will internally link 
/dev/console to /dev/ttyS1 , and when i do any operation to /dev/console 
, it is the same as i do to /dev/ttyS1 ?

2 . what means foreground virtual console as tty0 is representing ?

Regards,
TOM



Miquel van Smoorenburg wrote:

>In article <4296C5C0.4030409@avantwave.com>,
>Tomko  <tomko@avantwave.com> wrote:
>  
>
>>Hi everyone,
>>
>>Which device is /dev/console pointing to ? or is it a virtual device ? 
>>Actually why this node is made?
>>    
>>
>
>See linux/Documentation/serial-console.txt
>
>  
>
>>Why kernel default not providing a control terminal on /dev/console but 
>>on other device ?
>>    
>>
>
>Because some daemons open /dev/console to send last resort error
>messages to, and you do not want them to unexpectedly gain a
>controlling tty.
>
>  
>
>>It is not surprising that we can use CTRL-C to terminate some process on 
>>i386 linux on the Desktop machine,  is that mean the shell on our 
>>desktop is not using /dev/console ? so where are the shell running on?
>>    
>>
>
>/dev/tty1, /dev/tty2 etc
>
>Mike.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

