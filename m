Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTKZNV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbTKZNV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:21:28 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:59352 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S261929AbTKZNV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:21:26 -0500
Message-ID: <3FC4A8BA.9070907@softhome.net>
Date: Wed, 26 Nov 2003 14:20:58 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <3FC358B5.3000501@softhome.net> <Pine.LNX.4.53.0311251510310.6584@chaos> <3FC3E2F4.4080809@softhome.net> <Pine.LNX.4.53.0311260745190.9601@chaos>
In-Reply-To: <Pine.LNX.4.53.0311260745190.9601@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> 
>>   May I ask you one question? Did you were ever doing once graceful
>>failure of application under memory pressure? Looks like not.
>>
> 
> Yes. I'm in the business of making embedded systems that cannot
> fail. And they do not fail. They allocate memory once during
> startup and they never fail or exit. They also do not use malloc()
> but that's not an issue.
> 

   So what do you use then in user space to reliably allocate memory?

   As to me - memory is a resource. Is it virtual or is it physical - it 
is still resource. And I need to allocate part of this resource.

   malloc() uses brk() inside. But brk() is "implementation details". I 
honestly do not care about them - I just want to be sure that what ever 
resource I have allocated - I can use it afterwards until I shall free 
it. POSIX even doesn't mention brk() BTW.

   If you can hint me any other method to allocate memory without 
surprises - I will really appreciate.

> 
> 
>>   Memory pools used by applications exactly to make grace error
>>handling under memory pressure - but it looks like this stuff under
>>Linux gets no testing at all. And default settings could make from
>>simple bug complete disaster.
>>
> 
> Wrong. It is up to the application to allocate and deallocate
> dynamic memory properly.  FYI, you can always look at /proc/meminfo
> yourself instead of expecting malloc() to do it for you. You only
> need to look at swap.
> 

   Embedded? with swap?!?
   What you have smoken?! - take me to your dealer!-)))

   And btw Rik already gave me answer - 2.6 kernels + 
/proc/sys/vm/overcommit_memory == 2.
   Work charmfully ;-)
   Enjoy.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

