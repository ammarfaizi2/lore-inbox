Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268252AbUHFTj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268252AbUHFTj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUHFTii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:38:38 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:8030 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S268252AbUHFTeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:34:03 -0400
Message-ID: <4113DD20.1010808@travellingkiwi.com>
Date: Fri, 06 Aug 2004 20:33:52 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cs using 100% CPU
References: <40FA4328.4060304@travellingkiwi.com> <20040806202747.H13948@flint.arm.linux.org.uk>
In-Reply-To: <20040806202747.H13948@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Sun, Jul 18, 2004 at 10:30:16AM +0100, Hamie wrote:
>  
>
>>Anyone know why this happens? Something busy waiting? (BUt that should 
>>show as system cpu right?) or something taking out really long locks?
>>    
>>
>
>It'll be because IDE is using PIO to access the CF card, which could
>have long access times (so reading a block of sectors could take some
>time _and_ use CPU.)  Obviously, PIO requires the use of the CPU, so
>the CPU can't be handed off to some other task while this is occuring.
>
>  
>
Well... I did consider that. And not to disbelieve you, since you know 
the kernel way better than I do, But decided I was being silly that a 
1.6GHz Pentium-M processor should use 100% CPU moving a couple of 
MB/second across a CF interface...

Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing 
the same job as quick, or even slightly faster...

And should it not use system CPU rather than user CPU?

TIA
 Hamish.

