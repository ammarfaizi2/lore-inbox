Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSHBTqE>; Fri, 2 Aug 2002 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSHBTqE>; Fri, 2 Aug 2002 15:46:04 -0400
Received: from quark.didntduck.org ([216.43.55.190]:269 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S317215AbSHBTqD>; Fri, 2 Aug 2002 15:46:03 -0400
Message-ID: <3D4AE232.6010000@didntduck.org>
Date: Fri, 02 Aug 2002 15:49:06 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Buzzard <jonathan@buzzard.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Weber <john.weber@linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Toshiba Laptop Support and IRQ Locks
References: <3D4AAD53.7010008@linux.org>  <1028310939.18309.93.camel@irongate.swansea.linux.org.uk> <E17aiHh-00034N-00@jelly.buzzard.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Buzzard wrote:
> alan@lxorguk.ukuu.org.uk said:
> 
>>Hi,
>>
>>Toshiba laptop support is broken.  Here's my rookie attempt at fixing
>>it.
> 
> 
> Whats broken? I have not seen the patch, though I don't track the latest
> 2.5 kernels either.
> 
> 
>>Looks basically sound. You probably want to use spinlock_irqsave - the
>>spin locks are less overhead than the reader/writer locks and you
>>don't really seem to be using it for anything else. I'm assuming we
>>want the irqsave to block interrupts because the I/O cycles might have
>>to happen one after another - if not they could be relaxed - perhaps
>>Jonathan knows ?
> 
> 
> Someone show me the patch and I can say for sure.
> 
> Two things to bare in mind, Toshiba have yet to do any sort of
> multi processor laptop, are extremely unlikely to ever manufacture
> one, and to the best of my knowledge the module only loads on Toshiba
> laptops. If it loads on anything else it is broken and needs fixing
> so it does not.

What about P4 Hyperthreading?

--
				Brian Gerst

