Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUGMWYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUGMWYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUGMWYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:24:30 -0400
Received: from mail.unitec.edu ([216.72.84.41]:3552 "EHLO mail.unitec.edu")
	by vger.kernel.org with ESMTP id S267176AbUGMWWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:22:49 -0400
Message-ID: <40F508F2.5090005@unitec.edu>
Date: Wed, 14 Jul 2004 04:20:34 -0600
From: "IVAN DE JESUS DERAS TABORA" <i.deras@unitec.edu>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Re: Garbage Collection and Swap
References: <40EF3BCD.7080808@comcast.net> <40F45DEF.8060307@techsource.com>
In-Reply-To: <40F45DEF.8060307@techsource.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>
>
> John Richard Moser wrote:
>
>>
>> THE GARBAGE COLLECTOR WANDERS AROUND IN THE ENTIRE HEAP, AND IN SOME
>> CASES IN OTHER PARTS OF RAM, LOOKING FOR WHAT LOOKS LIKE POINTERS TO
>> YOUR ALLOCATED DATA.
>>
>
> Whose GC does this?
>
> I get the impression that the Java VM, for instance, knows what 
> variables are pointers (well, references) and only considers those.  
> It also knows every object that has even been allocated.  It scans 
> over every pointer it knows about (the "mark" phase), and then it 
> scans over every dynamically allocated memory block (the "sweep" 
> phase) and removes all that have no references.
>
> There is anecdotal evidence that this approach sometimes can improve 
> performance over "manual" freeing because freeing can be done in bulk.
>
> Java GC works very well, and it's a huge improvement over the "manual" 
> method, because it almost completely eliminates memory leaks (if you 
> really want a memory leak, you can find a way to make it happen).
>
> Now, if you're talking about trying to apply GC to C code, it's an 
> entirely different matter.  C wasn't designed with GC in mind.  The 
> very fact that you can do MATH on pointers in C makes reliable GC 
> nearly impossible, although any reasonable attempt would certainly be 
> better than your assumption that something would "go scanning through 
> memory looking for things that look like pointers."  That would be 
> horribly stupid.  Better would be to have the compiler emit code that 
> registers pointers with something that keeps track of them, but that's 
> still a huge can of worms when you consider someone malloc'ing N 
> bytes, storing a (void *), and then later assigning that value to a 
> struct pointer.
>
> No, I don't think GC in C is feasible.

A garbage collector for C and C++
http://www.hpl.hp.com/personal/Hans_Boehm/gc/
