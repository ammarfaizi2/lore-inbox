Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314300AbSDRK5C>; Thu, 18 Apr 2002 06:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314301AbSDRK5B>; Thu, 18 Apr 2002 06:57:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20752 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314300AbSDRK5B>; Thu, 18 Apr 2002 06:57:01 -0400
Message-ID: <3CBE97E5.1010004@evision-ventures.com>
Date: Thu, 18 Apr 2002 11:54:45 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 38
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBED42.50003@evision-ventures.com> <3CBE8E61.6070702@evision-ventures.com> <20020418114844.A15930@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Thu, Apr 18, 2002 at 11:14:09AM +0200, Martin Dalecki wrote:
> 
>>@@ -523,6 +513,12 @@
>> 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
>> 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
>> 	unsigned	highmem	   : 1; /* can do full 32-bit dma */
>>+	byte		slow;		/* flag: slow data port */
>>+	unsigned no_io_32bit	   : 1;	/* disallow enabling 32bit I/O */
>>+	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
>>+	unsigned no_unmask	   : 1;	/* disallow setting unmask bit */
>>+	byte		unmask;		/* flag: okay to unmask other irqs */
>>+
> 
> 
> Just cosmetic... This causes the layout to be:
> 
> 	1 bit
> 	1 bit
> 	1 bit
> 	align to word
> 	1 byte
> 	align to word
> 	1 bit
> 	align to word
> 	1 byte
> 	align to word
> 	1 bit
> 	align to word
> 	1 byte
> 	align to word
> 
> which is rather wasteful.  Any chance you can group the bits together
> and the bytes together?

Of course you are right. I will group them later.


