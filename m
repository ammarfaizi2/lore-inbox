Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUI2Stk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUI2Stk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUI2Ssn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:48:43 -0400
Received: from smtp05.web.de ([217.72.192.209]:13707 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S268824AbUI2SrC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:47:02 -0400
Date: Wed, 29 Sep 2004 20:46:56 +0200
From: Gundolf Kiefer <gundolf.kiefer@web.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jens Axboe <axboe@suse.de>, gundolfk@web.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: IRQ blocking when reading audio CDs
Message-ID: <20040929184656.GK1100@lilienthal>
Reply-To: gundolfk@web.de
References: <20040926120849.GG3134@lilienthal> <20040927055234.GA2288@suse.de> <1096399282.2852.24.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1096399282.2852.24.camel@krustophenia.net>
X-Mailer: Balsa 1.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I applied Andrew Morton's updated CDROMREADAUDIO DMA patch from Jan 2003 
(http://lwn.net/Articles/19386/) to kernel 2.4.25, and everything seems to 
work fine now.

Thanks, Jens & Lee!


On 2004.09.28 21:21 Lee Revell wrote:
> On Mon, 2004-09-27 at 01:52, Jens Axboe wrote:
>> On Sun, Sep 26 2004, Gundolf Kiefer wrote:
>> > Dear Jens (& Christoph),
>> >
>> > on my media PC (a Pentium II 350 MHz running Debian Woody with Kernel
>> > 2.4.25), I have problems using LIRC 0.6.6 with a serial IR reveiver when
> at
>> > the same time some application (cdparanoia, xmms/Audio CD reader) is
>> > reading audio data from a CD.
>> 
>> Upgrade to 2.6, it can use DMA for cdda extraction. If you cannot for
>> some reason, Andrew had an ide-cd hack to enable dma in 2.4 for this.
> 
> Seems like it should also work in PIO mode as long as unmask_irq is set.
> 
> Lee
> 
