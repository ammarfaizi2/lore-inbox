Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTKYTD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 14:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTKYTD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 14:03:59 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:11241 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262848AbTKYTDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 14:03:55 -0500
Message-ID: <3FC3A797.4060108@softhome.net>
Date: Tue, 25 Nov 2003 20:03:51 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2/2.4/2.6 VMs: do malloc() ever return NULL?
References: <Pine.LNX.4.44.0311251158110.2870-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0311251158110.2870-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Tue, 25 Nov 2003, Ihar 'Philips' Filipau wrote:
> 
>> 2.6: the same as 2.4 with oom killer (default conf). I have no test
>>  system to check 2.6. w/o oom killer.
> 
> 
> # echo 2 > /proc/sys/vm/overcommit_memory
> 
> Then try again.
> 

   What do you know what is not said in docs?
   What '2' means?

   I'll try as soon as I will have again access to 2.6 box.

   this is what 2.6-test10 says:

> overcommit_memory
> 
> This file  contains  one  value.  The following algorithm is used to
> decide if there's enough  memory:  if  the  value of
> overcommit_memory is positive, then there's always  enough  memory.
> This is a useful feature, since programs often malloc() huge  amounts
> of  memory 'just in case', while they only use a small part of  it.
> Leaving  this value at 0 will lead to the failure of such a huge 
> malloc(), when in fact the system has enough memory for the program
> to run.
> 
> On the  other  hand,  enabling this feature can cause you to run out
> of memory and thrash the system to death, so large and/or important
> servers will want to set this value to 0.

   Could this special case 'sysctl_overcommit_memory > 1' be added and 
explained? (mmap.c:589)

   I cannot tell what it does - but name 'security_vm_enough_memory()' 
sounds promising ;-)

   As I have said - I will check this later when I will get to those box.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

