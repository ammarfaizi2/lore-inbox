Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbTC0WQd>; Thu, 27 Mar 2003 17:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbTC0WQd>; Thu, 27 Mar 2003 17:16:33 -0500
Received: from [12.242.167.130] ([12.242.167.130]:40576 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id <S261441AbTC0WQc>; Thu, 27 Mar 2003 17:16:32 -0500
Message-ID: <3E837ADD.9080209@comcast.net>
Date: Thu, 27 Mar 2003 14:27:41 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030326
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: thunder7@xs4all.nl
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: vesafb problem
References: <3E8329D2.7040909@comcast.net> <20030327190222.GA4060@middle.of.nowhere>
In-Reply-To: <20030327190222.GA4060@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One not very good way for you to proceed would be to change the
> definition of VMALLOC_RESERVE from (128 << 20) to something like (256
> << 20), which should leave the driver room to ioremap the framebuffer.
> This is a little ugly.  However, I don't see why a framebuffer driver
> would need to ioremap _all_ of a video card's memory -- so a better
> solution would be to fix the driver to only ioremap what it needs to.
> 
> Best,
>   Roland
> ======================================================
> 
> To see if this is it, booting with mem=512M would be a good test.
> 
> Kind regards,
> Jurriaan

Well, I've answered my own question regarding highmem. Reserving 256MB 
ram causes high-mem mapped IO to fail. I can have penguins, but no 
filesystems or no penguins and a useable system. I'm guessing that I 
could probably turn off HIGHMEM and HIGHMEM-IO and might be able to get 
penguins back, but at the cost of reduced system performance. I'm not a 
kernel hacker, but I might just see how bad I can break vesafb to remap 
only the necessary memory for the requested video mode. Perhaps that 
would fix the whole thing?

-Walt

