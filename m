Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268154AbUHFPnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268154AbUHFPnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 11:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUHFPle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 11:41:34 -0400
Received: from smtp.rol.ru ([194.67.21.9]:31040 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S268153AbUHFPdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:33:44 -0400
Message-ID: <4113A579.5060702@vlnb.net>
Date: Fri, 06 Aug 2004 19:36:25 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 bitops.h commentary on instruction reordering
References: <20040805200622.GA17324@logos.cnet> <411392E0.6080507@vlnb.net> <20040806143359.GC20911@logos.cnet>
In-Reply-To: <20040806143359.GC20911@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

One more question, if you don't object. How after some variable 
assigment to make other CPUs *immediatelly* see the assigned value, i.e. 
to make current CPU immediately flush its write cache in memory? *mb() 
seems deal with reordering, barrier() with the compiler optimization (am 
I right?). The similar memory barrier spin_lock() does, but it's not 
easy to uderstand its internal magic.

Vlad

Marcelo Tosatti wrote:
> On Fri, Aug 06, 2004 at 06:17:04PM +0400, Vladislav Bolkhovitin wrote:
> 
>>So, is there any way to workaround this problem, i.e. prevent bit 
>>operations reordering on non-x86 architectures? Some kinds of memory 
>>barriers?
> 
> 
> Memory barriers, yes, smp_mb(), rmb, wmb and friends.
> 
> 

