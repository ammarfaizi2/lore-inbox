Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268140AbUH2ACx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268140AbUH2ACx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 20:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268141AbUH2ACx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 20:02:53 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:42984 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268140AbUH2ACv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 20:02:51 -0400
Message-ID: <41311D20.7050600@comcast.net>
Date: Sat, 28 Aug 2004 20:02:40 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Justin Piszcz <jpiszcz@lucidpixels.com>, apiszcz@lucidpixels.com,
       linux-kernel@vger.kernel.org
Subject: Re: Burning audio CD's is totally broken under 2.6.8.1.
References: <Pine.LNX.4.61.0408280714550.9133@p500> <41306C8F.8040307@kolivas.org>
In-Reply-To: <41306C8F.8040307@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I went to linux-2.6.8-rc1-ck6 when i found this problem to exist in 
2.6.7 and patches to the kernel and the problem went away.  But I was 
told it had nothing t odo with the ck6 patchset as it didn't touch the 
area that was effected (as i was told anyway).  

I've just upgraded to 2.6.9-rc1-mm1 (with nick's patch and mm's patches 
backed out as he suggested to do).  Now the kernel does not leak memory, 
which it did with vanilla 2.6.9-rc1. 

Audio writing however doesn't seem to be using dma. I get heavy io 
related cpu usage when burning the cd that brings write speed and system 
responsiveness down significantly. This should not be  obviously and i 
was wondering if that had something to do with why the mem leak no 
longer exists or if it's something else entirely separate.  Note, in ck6 
audio writing was fine and did not exibit this non-dma-like behavior and 
no configuration changes were made between versions. DMA is detected and 
enabled for the drive in data mode. 





Con Kolivas wrote:

> Justin Piszcz wrote:
>
>> Out of Memory: Killed process 737 (xchats).
>
>
> Known issue:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109309119620622&w=2
>
> Cheers,
> Con


