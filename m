Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWFANiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWFANiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWFANiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:38:23 -0400
Received: from [195.23.16.24] ([195.23.16.24]:54661 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750842AbWFANiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:38:22 -0400
Message-ID: <447EEDCB.1070002@grupopie.com>
Date: Thu, 01 Jun 2006 14:38:19 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ram <vshrirama@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: printk's - i dont want any limit howto?
References: <8bf247760606010025p38131240ia133cc3124f93bf7@mail.gmail.com>
In-Reply-To: <8bf247760606010025p38131240ia133cc3124f93bf7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> Hi,

Hi,

>  I have a driver full of printks. i am trying to understand the way
> the driver functions using printks
> 
>  So, i have a situation where i want all the printk's to be printed
> come whatever.

That is the normal behavior.

>   I dont want any rate limiting or anything else that prevents from
> my printks from appearing on the screen or dmesg.
> 
> Its really confusing when only one of your printks appear and some
> just dont appear even though you expect them to appear.
> 
>  Is there any way to make all the printks to appear come what may?.
> If so, how do  i do it?.
> 
>  Went through the printk.c am not sure setting the
> printk_ratelimit_jiffies = 0 and printk_ratelimit_burst= 1000 will do?
> 
>  am not sure if printk_ratelimit_jiffies = 0 is valid.

These are just used by "printk_ratelimit()" in constructs such as:

if (printk_ratelimit())
         printk(KERN_INFO "some message that may appear very often");

If you simply use printk, there should be no rate limiting.

> please advice.

I would say your printk's are not getting called at all or the log level 
of the messages is not sufficient for them to appear on the console or 
on the log. See Documentation/filesystems/proc.txt -> 
proc/sys/kernel/printk and syslog(2) for more documentation on this.

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
