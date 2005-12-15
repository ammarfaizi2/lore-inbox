Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVLOWgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVLOWgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVLOWgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:36:55 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:57478 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751168AbVLOWgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:36:55 -0500
Message-ID: <43A1DB18.4030307@wolfmountaingroup.com>
Date: Thu, 15 Dec 2005 14:07:36 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051215223000.GU23349@stusta.de>
In-Reply-To: <20051215223000.GU23349@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Thu, Dec 15, 2005 at 02:00:13PM -0800, Andrew Morton wrote:
>  
>
>>Adrian Bunk <bunk@stusta.de> wrote:
>>    
>>
>>>This patch was already sent on:
>>>- 11 Dec 2005
>>>- 5 Dec 2005
>>>- 30 Nov 2005
>>>- 23 Nov 2005
>>>- 14 Nov 2005
>>>      
>>>
>>Sigh.  I saw the volume of email last time and though "gee, glad I wasn't
>>cc'ed on that lot".
>>    
>>
>
>If you substract the "this breaks my binary-only M$ Windows driver" 
>emails there's not much volume left.
>
>  
>
>>Supporting 8k stacks is a small amount of code and nobody has seen a need
>>to make changes in there for quite a long time.  So there's little cost to
>>keeping the existing code.
>>
>>And the existing code is useful:
>>
>>a) people can enable it to confirm that their weird crash was due to a
>>   stack overflow.
>>
>>b) If I was going to put together a maximally-stable kernel for a
>>   complex server machine, I'd select 8k stacks.  We're still just too
>>   squeezy, and we've had too many relatively-recent overflows, and there
>>   are still some really deep callpaths in there.
>>    
>>
>
>a1) People turn off 4k stacks and never report the problem / noone 
>    really debugs and fixes the reported problem.
>
>Me threatening people with enabling 4k stacks for everyone already 
>resulted in several fixes.
>
>An how many weird crashes with _different_ causes have you seen?
>It could be that there are only _very_ few problems that noone really 
>debugs brcause disabling 4k stacks fixes the issue.
>  
>

When you are on the phone with an irrate customer at 2:00 am in the 
morning, and just turning off your broken 4K stack fix
and getting the customer running matters. 4K stacks are a BAD idea. I 
have even found USER SPACE apps
that crash linux without the 8K option. Andrew has spoken. Suck it up 
and deal with it. It's not a problem limited to Windows
drivers.

Jeff

>cu
>Adrian
>
>  
>

