Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130634AbRAUI1k>; Sun, 21 Jan 2001 03:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbRAUI1b>; Sun, 21 Jan 2001 03:27:31 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:50734 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S130634AbRAUI1T>; Sun, 21 Jan 2001 03:27:19 -0500
Message-ID: <3A6A9CB3.2010304@mvista.com>
Date: Sun, 21 Jan 2001 00:24:19 -0800
From: george anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20b i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Mark I Manning IV <mark4@purplecoder.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding Style
In-Reply-To: <3A68E309.2540A5E1@purplecoder.com> <5.0.2.1.2.20010120152158.00ab7bc0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> At 06:29 20/01/2001, Linus Torvalds wrote:
> 
>> On Fri, 19 Jan 2001, Mark I Manning IV wrote:
> 
> [snip]
> 
>>  > > And two spaces is not enough. If you write code that needs 
>> comments at
>>  > > the end of a line, your code is crap.
>>  >
>>  > Might i ask you to qualify that statement ?
>> 
>> Ok. I'll qualify it. Add a "unless you write in assembly language" to the
>> end. I have to admit that most assembly languages are terse and hard to
>> read enough that you often want to comment at the end. In assembly you
>> just don't tend to have enough flexibility to make the code readable, so
>> you must live with unreadable code that is commented.
> 
> 
> Would you not also add "unless you are defining structure definitions 
> and want to explain what each of the struct members means"?
> 
> [snip]
> 
>> Notice? Not AFTER the statements.
>> 
>> Why? Because you are likely to want to change the statements. You don't
>> want to keep moving the comments around to line them up. And trying to
>> have a multi-line comment with code is just HORRIBLE:
> 
> 
> And structs are not likely to change so this argument would not longer 
> apply?
> 
> Just curious.

I am curious about another style issue.  In particular _inline_ in ".h" 
files.  The "style" for this as practiced today is about to run into a 
brick wall.  Try, for example, referring to "current->need_resched" 
within the spin_lock() macro.  I don't think you can get this to work 
with the current kernel, and if you can, a) let me know how, and b) it 
is much too hard.  Imho it is time to rethink how (or where) we put 
_inline_ code.

I think the problem could be fixed by a convention in the compiler that 
says something like "_inline_" code will be compiled when a reference to 
it is encountered, but this is outside the standard (i.e. the standard 
allows it to be as it is and does not disallow my proposed convention, 
as I understand the standard).

George




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
