Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTKQQqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKQQqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:46:44 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:50701 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S262133AbTKQQqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:46:42 -0500
Message-ID: <3FB8FB6A.8070609@dcrdev.demon.co.uk>
Date: Mon, 17 Nov 2003 16:46:34 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hard lock on 2.6-test9 (More Info)
References: <Pine.LNX.4.44.0311170829000.8840-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311170829000.8840-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the advice Linus - I'll give that a go.

As an aside, I've tried both the nvidia drivers and the out-of-the-box 
Xfree ones with the same results (2.4 stable, 2.6 not).

I'll get back to the list with more info once I've done the testing.

Thanks again for your time,

Dan.

Linus Torvalds wrote:

>On Mon, 17 Nov 2003, Dan Creswell wrote:
>  
>
>> 17:       5267       3420   IO-APIC-level  ohci1394, Intel ICH4, nvidia
>>
>>When I boot X under kernel 2.6, I see the additional nvidia interrupt 
>>path as per the 2.4 output (which was taken whilst I was running X).
>>
>>But, within seconds of this additional interrupt assignment appearing, 
>>2.6 dies a horrible death whilst 2.4 just keeps on rolling.
>>    
>>
>
>Two potential reasons:
> - the nvidia driver is just broken under 2.6.x
> - or a driver bug in ohci1394 _or_ the Intel ICH4 driver, which could 
>   become unhappy if they see a lot of interrupts that aren't for them 
>   (maybe it uncovers a race).
>
>You can test for the latter by just disabling those drivers, and seeing 
>what happens. If it still breaks, it's nvidia. If the crashes stop, it 
>might _still_ be nvidia, but at that point somebody else might start being 
>interested in it.
>
>		Linus
>
>
>
>  
>


