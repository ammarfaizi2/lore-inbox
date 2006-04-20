Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWDTIBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWDTIBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 04:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDTIBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 04:01:49 -0400
Received: from smtpout.mac.com ([17.250.248.176]:60152 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750753AbWDTIBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 04:01:49 -0400
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF43619E@titanium.secgo.net>
References: <963E9E15184E2648A8BBE83CF91F5FAF43619E@titanium.secgo.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EF32C995-F38A-4945-AB38-5CCBE21513B4@mac.com>
Cc: James Morris <jmorris@namei.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: searching exported symbols from modules
Date: Thu, 20 Apr 2006 04:01:30 -0400
To: Antti Halonen <antti.halonen@secgo.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 20, 2006, at 03:15:42, Antti Halonen wrote:
>> This makes me wonder why the hell you think you'll get help from  
>> this (open-source) list.
>
> I see, I figured this is the place to ask technical question  
> related to programming in kernel space.

Typically yes; however there are two problems:
   1)  If we can't see your code, we probably can't help you very  
well.  Since you're not providing your code, you're wasting both your  
time and ours with questions that would be much more easily answered  
with access to that code.
   2)  Many people will refuse to provide help for what they perceive  
as violations of their copyright.

>> A large number of people on this list (including copyright- 
>> holders) consider what you are doing blatantly illegal, although  
>> nobody has yet gone to court over it.
>
> Um, which part is illegal?

Many people consider any Linux kernel module to be a derivative work  
of the Linux kernel.  For example, you use non-standardized internal  
header files containing inline functions which end up compiled into  
your code, you use interfaces which are only present in the Linux  
kernel itself, your binary module does not run without a specific  
particular version of the Linux kernel, etc.

> Are you saying that I cannot have a non-open source kernel module?

My personal opinion is not relevant here, it's that of the major  
copyright holders (of which there are thousands) and the courts.  If  
nobody ever sues you over your kernel module, or if you win any  
lawsuit, you're ok.  On the other hand, it's such a sensitive topic  
you should go talk to your lawyer first.  Many significant kernel  
copyright holders believe that essentially any kernel module is a  
derivative work of the Linux kernel, and as such must be GPLed to  
comply with copyright law in most major countries.

> If I figured correctly, to violate GPL I should compile GPL code  
> into my module.

You are doing exactly that when you use atomic_t, spinlocks, or a  
thousand other inline functions from the kernel headers.

> It is a standalone module, not distributed with any custom kernel.

Which kernel does it run against?  Does this run on other operating  
systems?  Do you require certain Linux-only interfaces?  Can your  
work reasonably be considered independent?  I suggest talking with a  
lawyer to answer these questions before attempting to release any non- 
GPL-compatible kernel module; just as you would if you were releasing  
a module for Windows for which there is not a defined API.

Cheers,
Kyle Moffett

