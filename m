Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUJBRYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUJBRYp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUJBRVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:21:05 -0400
Received: from pyramid-02.kattare.com ([69.59.195.3]:35270 "EHLO
	pyramid-02.kattare.com") by vger.kernel.org with ESMTP
	id S267438AbUJBRQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:16:23 -0400
Message-ID: <415EE25D.5090200@sherman.ca>
Date: Sat, 02 Oct 2004 13:16:13 -0400
From: Adam Sherman <adam@sherman.ca>
User-Agent: Mozilla Thunderbird 0.8 (Macintosh/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: linux-kernel@vger.kernel.org
Subject: Re: DMA timeout error
References: <cjmk3s$gjs$1@sea.gmane.org> <58cb370e04100209432ec9c9ee@mail.gmail.com>
In-Reply-To: <58cb370e04100209432ec9c9ee@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
>>I have a VIA M6000 board with an ATA CompactFlash adaptor containing a
>>512MB SanDisk card.
>>
>>I get the following error during boot:
>>
>>hdb: dma_timer_expiry: dma status == 0x41
>>hdb: DMA timeout error
>>hdb: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> 
> If this is a new CF capable of DMA but CF-to-IDE adapter doesn't support
> DMA (most don't) then "ide=nodma" kernel command line parameter should
> do the job.  It might be also bug in via82cxxx host driver.
> 
> Maybe DMA should be off by default for CF but it requires fixing almost
> every IDE host driver and why punish good hardware.

This makes quite a bit of sense seeing as it's a SanDisk "Ultra II" card.

beber@setibzh.com writes:
> add pci=noapic to your boot option

Since the hardware is not reachable from here, I can not test it until 
Monday. I'll note my results though.

Thanks,

A.
