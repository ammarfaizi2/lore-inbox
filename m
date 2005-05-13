Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVEMOxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVEMOxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262395AbVEMOxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:53:41 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:663 "EHLO webmail.tiscali.de")
	by vger.kernel.org with ESMTP id S262392AbVEMOxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:53:35 -0400
Message-ID: <4284BF3C.4030501@tiscali.de>
Date: Fri, 13 May 2005 16:52:44 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
CC: Chris Friesen <cfriesen@nortel.com>, linux-os@analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Need kernel patch to compile with Intel compiler
References: <377362e105051207461ff85b87@mail.gmail.com>	 <Pine.LNX.4.61.0505121130030.31719@chaos.analogic.com>	 <42837C2E.9000506@nortel.com> <377362e105051306506e3870a6@mail.gmail.com>
In-Reply-To: <377362e105051306506e3870a6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuji "Maverick" Rai wrote:
> On 5/13/05, Chris Friesen <cfriesen@nortel.com> wrote:
> 
>>Richard B. Johnson wrote:
>>
>>
>>>The kernel is designed to be compiled with the GNU 'C' compler
>>>supplied with every distribution. It uses a lot of __asm__()
>>>statements and other GNU-specific constructions.
>>
>>Yep.  And Intel added a bunch of them to their compiler so that they
>>could build a kernel with it.
>>
>>
>>>Why would you even attempt to convert the kernel sources to
>>>be compiled with some other tools?
>>
>>The Intel compiler is quite good at optimizing for their processors (and
>>ironically for AMD ones as well).  However, I think that a lot of the
>>gains come from the vectorizer, which of course can't be used with
>>kernel code.
>>
>>Chris
>>
> 
> 
> Yes, that's why I wanted to use Intel's compiler for kernel (of course
> I didn't mean to use C++; the product's name is C++, it doesn't sell C
> alone.)    Its vectorization is so nice that SETI@home calculates
> 20-30% faster than the original one compiled with gcc.
> 
> But I thought it's not such a good idea to build kernel with Intel
> compiler, because kernel's speed doesn't affect so much in my case. 
> And that vectorization isn't so effective in kernel.  PGO (profile
> guided optimization) is the only effective optimization in the kernel
> according to
> http://softwareforums.intel.com/ids/board/message?board.id=16&message.id=1504
> 
> So I decided not to try this...looks like too much effort and little
> gain.  and I guess that's why nobody is trying this now.
> 
Yeah that's what the 2.6.5 patch does. Some People talked about 20% more speed with this patch last year. If anyone is 
able to patch the current kernel the patch should be in -mm.

Matthias-Christian Ott
