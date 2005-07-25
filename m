Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVGYQZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVGYQZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVGYQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 12:25:29 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:2565 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261341AbVGYQZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 12:25:27 -0400
Message-ID: <42E5134A.30001@tmr.com>
Date: Mon, 25 Jul 2005 12:28:58 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: "'Bernd Petrovitsch'" <bernd@firmix.at>,
       "'Linux kernel'" <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Vinicius'" <jdob@ig.com.br>
Subject: Re: Kernel doesn't free Cached Memory
References: <Pine.LNX.4.61.0507220904280.15626@chaos.analogic.com> <200507230536.IAA03542@raad.intranet>
In-Reply-To: <200507230536.IAA03542@raad.intranet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Dick Johnson wrote: { 
> 
>>On Fri, 2005-07-22 at 08:27 -0300, Vinicius wrote:
>>[...]
>>
>>>   I have a server with 2 Pentium 4 HT processors and 32 GB of RAM, 
>>>this server runs lots of applications that consume lots of memory to. 
>>>When I stop this applications, the kernel doesn't free memory (the  
>>>memory still in use) and the server cache lots of memory (~27GB). 
>>>When I start this applications, the kernel sends  "Out of Memory" 
>>>messages and kill some random applications.
> 
> 
> ...you might even need to turn memory over-commit off:
>   echo "0" > /proc/sys/vm/overcommit_memory
> }
> 
> That's in 2.4. In 2.6 it's:
>   echo "2" > /proc/sys/vm/overcommit_memory

RHEL3 *is* a 2.4 kernel.
> 
> But the kernel doesn't honor no-overcommit in either version, i.e. it still
> overcommits/pages-out loaded/running procs, thus invoking OOM!
> 
> Is there a way to make the kernel strictly honor the no-overcommit request?
> 

Don't have swap?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
