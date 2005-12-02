Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVLBPug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVLBPug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 10:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVLBPuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 10:50:35 -0500
Received: from mail.tmr.com ([64.65.253.246]:65432 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750792AbVLBPuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 10:50:35 -0500
Message-ID: <4390701C.1030803@tmr.com>
Date: Fri, 02 Dec 2005 11:02:36 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>	 <20051123233016.4a6522cf.pj@sgi.com>	 <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>	 <200512020849.28475.vda@ilport.com.ua>	 <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>	 <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com> <2cd57c900512020456n2f31101k@mail.gmail.com>
In-Reply-To: <2cd57c900512020456n2f31101k@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 2005/12/2, Pekka Enberg <penberg@cs.helsinki.fi>:
> 
>>Hi,
>>
>>2005/12/2, Denis Vlasenko <vda@ilport.com.ua>:
>>
>>>>There is another reason why enums are better than #defines:
>>
>>On 12/2/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
>>
>>>This is a reason why enums are worse than #defines.
>>>
>>>Unlike in other languages, C enum is not much useful in practices.
>>>Maybe the designer wanted C to be as fancy as other languages?  C
>>>shouldn't have had enum imho. Anyway we don't have any strong motives
>>>to switch to enums.
>>
>>I don't follow your reasoning. The naming collision is a real problem
>>with macros. With enum and const, the compiler can do proper checking
>>with meaningful error messages. Please explain why you think #define
>>is better for Denis' example?
>>
>>                                     Pekka
>>
> 
> 
> That is a bad bad style. It should be `#define FOO 123' if you have to
> write it.
> 
> It's also hard to see what the confusing bar is "if you are looking at
> file.c alone".
> 
> enum is worse than typdef.  Don't you see why we should use `struct
> task_struct', rather than `task_t'?
> 
> Introducing enum alone can't solve the problems from bad macro usage
> habits. Actually, it's not anything wrong with macros, it's
> programers' bad coding style.

Using enum doesn't *solve* problems, it does *allow* type checking, and 
*prevent* namespace pollution. Use of typedef allows future changes, if 
you use "struct XXX" you're stuck with it.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
