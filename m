Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUDVTYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUDVTYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbUDVTYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:24:35 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:36754 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S264633AbUDVTYd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:24:33 -0400
Message-ID: <40881BDB.4050909@cosmosbay.com>
Date: Thu, 22 Apr 2004 21:24:11 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: James Morris <jmorris@redhat.com>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Large inlines in include/linux/skbuff.h
References: <Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com> <4087E6B1.9000606@cosmosbay.com> <200404221927.34717.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200404221927.34717.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>
>>
>>If this a specialized machine, with a small program that mostly uses
>>recv() & send() syscalls, then, inlining functions is a gain, since
>>icache may have a 100% hit ratio. Optimization guidelines are good for
>>the common cases, not every cases.
>>    
>>
>
>And if it is NOT a specialized machine? icache miss will nullify
>any speed advantages, while you still pay space penalty.
>We don't need to pay for at least ~250 kbytes wasted overall
>in allyesconfig kernel for each and every specialized
>setup conceivable, IMHO.
>  
>
The point is : if this IS a specialized machine, then the kernel is 
custom one, not allyesconfig.

This is imho what I do for specialized machines, and yes, I even inline 
some specific functions, like fget() and others.

But I didnt asked to not doing the un-inlining, I was just reminding 
that some guys (like me) are doing micro-optimizations that 'seem' to go 
against Optimizations guidelines from intel or AMD.

Eric

