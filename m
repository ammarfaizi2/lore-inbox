Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268194AbUHFQzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268194AbUHFQzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268190AbUHFQuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:50:37 -0400
Received: from smtp.rol.ru ([194.67.21.9]:30581 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S268194AbUHFQts (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:49:48 -0400
Message-ID: <4113B752.7050808@vlnb.net>
Date: Fri, 06 Aug 2004 20:52:34 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet> <4113A579.5060702@vlnb.net> <20040806155328.GA21546@logos.cnet>
In-Reply-To: <20040806155328.GA21546@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Fri, Aug 06, 2004 at 07:36:25PM +0400, Vladislav Bolkhovitin wrote:
> 
>>Thanks.
>>
>>One more question, if you don't object. How after some variable 
>>assigment to make other CPUs *immediatelly* see the assigned value, i.e. 
>>to make current CPU immediately flush its write cache in memory? *mb() 
>>seems deal with reordering, barrier() with the compiler optimization (am 
>>I right?). 
> 
> 
> Yes correct. *mb() usually imply barrier(). 
> 
> About the flush, each architecture defines its own instruction for doing so,
>  PowerPC has  "sync" and "isync" instructions (to flush the whole cache and instruction 
> cache respectively), MIPS has "sync" and so on..

So, there is no platform independent way for doing that in the kernel?

>>The similar memory barrier spin_lock() does, but it's not 
>>easy to uderstand its internal magic.
> 
> 
> 
> 

