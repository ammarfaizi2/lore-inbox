Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264136AbUDVPhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbUDVPhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUDVPhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:37:53 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:62424 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S264136AbUDVPhv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:37:51 -0400
Message-ID: <4087E6B1.9000606@cosmosbay.com>
Date: Thu, 22 Apr 2004 17:37:21 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Large inlines in include/linux/skbuff.h
References: <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

>On Thu, 22 Apr 2004, Andi Kleen wrote:
>
>  
>
>>>How will these changes impact performance?  I asked this last time you 
>>>posted about inlines and didn't see any response.
>>>      
>>>
>>I don't think it will be an issue. The optimization guidelines
>>of AMD and Intel recommend to move functions that generate 
>>more than 30-40 instructions out of line. 100 instructions 
>>is certainly enough to amortize the call overhead, and you 
>>safe some icache too so it may be even faster.
>>    
>>
>
>Of course, but it would be good to see some measurements.
>
>
>- James
>  
>
It depends a lot of the workload of the machine.

If this a specialized machine, with a small program that mostly uses 
recv() & send() syscalls, then, inlining functions is a gain, since 
icache may have a 100% hit ratio. Optimization guidelines are good for 
the common cases, not every cases.

Eric Dumazet

