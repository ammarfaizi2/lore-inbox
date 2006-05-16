Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751728AbWEPR1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbWEPR1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 13:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbWEPR1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 13:27:12 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:12423 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751727AbWEPR1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 13:27:11 -0400
Message-ID: <446A0B6C.8050901@garzik.org>
Date: Tue, 16 May 2006 13:27:08 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Kevin Radloff <radsaq@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Fix broken PIO with libata
References: <1147790393.2151.62.camel@localhost.localdomain>	 <3b0ffc1f0605160833k5f6355c5n3f2a9ab1b211a95@mail.gmail.com>	 <1147794791.2151.71.camel@localhost.localdomain> <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com>
In-Reply-To: <3b0ffc1f0605161019j7149f72bv309db19eb9d12dd8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Radloff wrote:
> On 5/16/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> On Maw, 2006-05-16 at 11:33 -0400, Kevin Radloff wrote:
>> > However, I still have a problem with pata_pcmcia (that I actually
>> > experienced also with the ide-cs driver) where sustained reading or
>> > writing to the CF card spikes the CPU with nearly 100% system time.
>>
>> That is normal. The PCMCIA devices don't support DMA. As a result of
>> this the processor has to fetch each byte itself over the ISA speed
>> PCMCIA bus link.
> 
> Hrm, as I recall that only started happening with ide-cs sometime in
> the single digits of 2.6.x.. And note that it's only maxing out at
> about 1.5MB/s. Should that saturate my laptop's 1.1GHz Pentium M
> processor?

Doing data xfer using PIO rather than DMA definitely eats tons of CPU 
cycles.

	Jeff



