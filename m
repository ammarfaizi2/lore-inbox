Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262753AbVAKAKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262753AbVAKAKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVAKAJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:09:41 -0500
Received: from mail.teja.com ([209.10.202.115]:26771 "EHLO mail.teja.com")
	by vger.kernel.org with ESMTP id S262753AbVAJXzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:55:44 -0500
Message-ID: <41E3176F.6000809@teja.com>
Date: Mon, 10 Jan 2005 16:01:51 -0800
From: Slade Maurer <smaurer@teja.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave <dave.jiang@gmail.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
References: <8746466a050110153479954fd2@mail.gmail.com>
In-Reply-To: <8746466a050110153479954fd2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:

>I have this ARM (XScale) based platform that supports 36bit physical
>addressing. Due to the way the ATU is designed, the outbound memory
>translation window is fixed outside the first 4GB of memory space, and
>thus the need to use 64bit addressing in order to access the PCI bus. 
>After all said and done, the struct resource members start and end
>must support 64bit integer values in order to work. On a 64bit arch
>that would be fine since unsigned long is 64bit. However on a 32bit
>arch one must use unsigned long long to get 64bit. However, if we do
>that then it would make the 64bit archs to have 128bit start and end
>and probably wouldn't be something we'd want. What would be a nice
>clean way to support this that's acceptable to Linux? I guess this
>issue would be similar to x86-32 PAE would have?
>
>Also, please cc me on on the discussion. Not sure if my LKML
>subscription is working... Thanks!
>
>  
>
Also, it would be nice to have PTEs to represent the upper 4GB such that 
it can be mmapped to user space. PAE handled this in and it would be 
great to have it in ARM MMU36 as well.

  -Slade

