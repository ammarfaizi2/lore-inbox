Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310606AbSCXRWR>; Sun, 24 Mar 2002 12:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311035AbSCXRV5>; Sun, 24 Mar 2002 12:21:57 -0500
Received: from mout0.freenet.de ([194.97.50.131]:37542 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S310606AbSCXRVv>;
	Sun, 24 Mar 2002 12:21:51 -0500
Message-ID: <3C9E0BBC.4030406@freenet.de>
Date: Sun, 24 Mar 2002 18:24:12 +0100
From: Andreas Hartmann <andihartmann@freenet.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020323
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.18] Security: Process-Killer if machine get's out of memory
In-Reply-To: <E16pBJE-0006hU-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>I've got a basic question:
>>Would it be possible to kill only the process which consumes the most 
>>memory in the last delta t?
>>Or does somebody have a better idea?
> 
> 
> At the point you hit OOM every possible heuristic is simply handwaving that
> will work for a subset of the user base. Fix the real problem and it goes
> away.

This would and must be the first solution. I agree with you.

On the other hand - nobody is perfect and there can be such situations. 
Why shouldn't the kernel be the ultimate checkpoint to prevent greater 
damage? That's what I'm thinking.

It's not easy and it takes probably ressources (processor and RAM) to do 
some
checks. The idea would be, to do such checks only when the memory-usage is
over a defined value, e.g. 60% or later. Best would be, if it would be
free configurable (to have the checks at all and at which point beginning).

I suggested a heuristic. Maybe, there are better ones. What I want to 
say is, that I think that there should be a mechanism to detect and kill 
a process as good as possible, which wants to have all the memory and 
even more - before the memory is used to 100%.


Regards,
Andreas Hartmann

