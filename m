Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265120AbTFRJRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 05:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265122AbTFRJRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 05:17:00 -0400
Received: from [213.24.247.63] ([213.24.247.63]:44207 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S265120AbTFRJQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 05:16:59 -0400
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like  Windows!
Date: Wed, 18 Jun 2003 13:30:48 +0400
User-Agent: KMail/1.5.1
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no>
In-Reply-To: <3EF0214A.3000103@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200306181330.48072.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
>
> Because the problem _is_ unsolvable.  You want the kernel
> to go "oh, lots of free memory showed up, lets pull
> everything in from swap just in case someone might need it."
> ...
>
> It is simply impossible to know "what" the
> next thing we will need from swap will be, and what
> stuff won't ever be needed from swap.  The memory
> might be putr to better uses, such as:
> 1. New programs/allocations can start without
>     having to push something out first
> 2. file cache for io-intensive apps.
> ...
> Note that reading from swap is very much like reading
> from executable files - it is done when needed.
> We donæ't normally pre-read every executable
> on the system when there is free memory just
> in case someone might want to run a program,
> the same applies to swap.
Well, the problem is probably unsolvable on kernel level (kernel is unaware of 
user's habits in app/mem usage), but I think it's pretty solvable on user 
level - give us a knob to tune VM's behavior. We mere mortals often know 
better how we will use our system's memory, and which apps we will be 
running. I, for myself, like laptop-mode patch (basically, it groups disk 
writes to do them once in 5-10 minutes, thus allowing hdd to sleep a lot) 
very much - when I'm on AC, most probably I'm in office , and turning it off 
is reasonable. When I'm on battery, though, chances are I won't be compiling 
the kernel and/or do other heavy disk IO, instead, I most likely will be 
coding, so echo 1 >/proc/sys/vm/laptop_mode seems appropriate, reasonable and 
useful. 
Could something like this be done with VM/swap policy ? 

-- 
With all the best, yarick at relex dot ru.

