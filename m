Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUKBSbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUKBSbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUKBSbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:31:39 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:61380 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261300AbUKBSbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:31:25 -0500
Message-ID: <4187D28B.5060507@drzeus.cx>
Date: Tue, 02 Nov 2004 19:31:39 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __GFP flags and kmalloc failures
References: <4187AC80.6050409@drzeus.cx> <20041102144429.GG32054@logos.cnet> <4187CB93.6080405@drzeus.cx> <20041102152629.GH32054@logos.cnet>
In-Reply-To: <20041102152629.GH32054@logos.cnet>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Tue, Nov 02, 2004 at 07:01:55PM +0100, Pierre Ossman wrote:
>  
>
>>Is there any other way of increasing the chances of actually getting the 
>>pages I need? Since it is DMA it needs to be one big block.
>>    
>>
>
>__GFP_NOFAIL, from gfp.h:
>
> * Action modifiers - doesn't change the zoning
> *
> * __GFP_REPEAT: Try hard to allocate the memory, but the allocation attempt
> * _might_ fail.  This depends upon the particular VM implementation.
> *
> * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
> * cannot handle allocation failures.
> *
> * __GFP_NORETRY: The VM implementation must not retry indefinitely.
> */
>
>  
>
Yes, I've browsed through these. __GFP_NOFAIL seems like it can hang for 
a very long time (I don't know if there is an upper bound on how long it 
will have to wait for a free page). __GFP_REPEAT seems to work good 
enough in this case.
My question was meant to be more along the lines of "Is there anything I 
can do without resorting to unstable/interal API:s?".

Rgds
Pierre

