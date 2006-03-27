Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWC0KWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWC0KWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 05:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWC0KWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 05:22:44 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:43712 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750868AbWC0KWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 05:22:43 -0500
Message-ID: <4427BCCC.4080506@tlinx.org>
Date: Mon, 27 Mar 2006 02:22:04 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Save 320K on production machines?
References: <4426515B.5040307@tlinx.org> <Pine.LNX.4.61.0603261122410.22145@yvahk01.tjqt.qr> <20060326100639.GE4053@stusta.de>
In-Reply-To: <20060326100639.GE4053@stusta.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sun, Mar 26, 2006 at 11:24:15AM +0200, Jan Engelhardt wrote
>>> ** primarily "funit-at-a-time", though -fweb &
>>> -frename-registers may add a bit (GCC 3.3.5 as
>>> patched by SuSE; Maybe extra optimizations could
>>> be a "CONFIG" option much like regparms is now?
>>>       
>> IIRC, -funit-at-a-time with gcc3 made compiled code go bloat.
>>     
> That's wrong, the compiled code is smaller.
>   
>> Jan Engelhardt
>>     
> cu
> Adrian
>   
---
    That's my point -- if the code is optimized and it shrinks the code 
size
due to unnecessary path duplication, the remain code is more likely
to fit in the CPU cache (getting some performance benefits as well
faster in the process), isn't that a good reason to use it?

This was measured on a Pentium-III, SMP optioned kernel.  I'm sure it
will help my code fit just a little better in the runtime caches, no?

The current makefile turns on the optimization only on gcc4 or higher,
but my results were with gcc3.5.5.  Maybe defaults for 386 should
enabler the optimization for some versions of gcc 3 as well?  
-l

