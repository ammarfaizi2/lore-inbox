Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263479AbUDEWEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUDEWCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:02:43 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:53252 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263480AbUDEWAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:00:05 -0400
Message-ID: <4071DBBB.4010704@techsource.com>
Date: Mon, 05 Apr 2004 18:20:43 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: John Stoffel <stoffel@lucent.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405213026.37258.qmail@web40512.mail.yahoo.com>
In-Reply-To: <20040405213026.37258.qmail@web40512.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergiy Lozovsky wrote:
> --- Timothy Miller <miller@techsource.com> wrote:
> 
>>
>>Sergiy Lozovsky wrote:
>>
>>
>>>
>>>All LISP errors are incapsulated within LISP VM.
>>> 
>>
>>
>>A LISP VM is a big, giant, bloated.... *CHOKE*
>>*COUGH* *SPUTTER* 
>>*SUFFOCATE* ... thing which SHOULD NEVER be in the
>>kernel.
> 
> 
> It is a smallest interpreter (of all purpose language)
> I was able to find. My guess is that you refer to the
> Common Lisp. it is huge and I don't use it.

Did you separate out the parser out into a user-space daemon?

Also, if you want a regular programming language with an extremely small 
interpreter, try Forth.

Learning Forth should be at LEAST as much fun as learning LISP.

> 
> 
>>If you want to use a more abstract language for
>>describing kernel 
>>security policies, fine.  Just don't use LISP.
> 
> 
> Point me to ANy langage with VM around 100K.

I bet a Forth interpreter would be smaller.

And for something specialized like security policy, you could probably 
develop your own language and interpreter for it, and it would be 
smaller (and faster) still.

> 
> 
>>The right way to do it is this:
>>
>>- A user space interpreter reads text-based config
>>files and converts 
>>them into a compact, easy-to-interpret code used by
>>the kernel.
>>
>>- A VERY TINY kernel component is fed the security
>>policy and executes it.
> 
> 
> it is exactly the way it is implemented. Not everyone
> need to create their own security model (that VERY
> TINY kernel component you refer to). But even for
> those who want to modify or create their own VERY TINY
> kernel component - they don't need to do that in C and
> debug it in th kernel crashing it.

You misunderstand.  When I say "VERY TINY kernel component", I'm 
referring to the interpreter.  Done properly, the pcode for the policy 
itself would be microscopic.

> 
> 
>>Move as much of the processing as reasonable into
>>user space.  It's 
>>absolutely unnecessary to have the parser into the
>>kernel, because 
>>parsing of the config files is done only when the
>>ASCII text version 
>>changes.
>>
>>It's absolutely unnecessary to have something as
>>complex as LISP to 
>>interpret it, when something simple and compact
>>could do just as well.
>>
>>Why do you choose LISP?  Don't you want to use a
>>language that sysadmins 
>>will actually KNOW?
> 
> 
> It was is) the smallest VM I know of.

Forth.


