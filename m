Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWEOXAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWEOXAu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWEOXAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:00:49 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:45777 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750726AbWEOXAr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:00:47 -0400
Message-ID: <4469081D.7080608@garzik.org>
Date: Mon, 15 May 2006 19:00:45 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515230256.GB4699@animx.eu.org>
In-Reply-To: <20060515230256.GB4699@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Jeff Garzik wrote:
>> After much development and review, I merged a massive pile of libata
>> patches from Tejun Heo and Albert Lee.  This update contains the
>> following major libata
>>
>> CHANGES:
>> * Rewritten error handling. This is a major piece of work, even
>>   though it will be rarely seen.  The new libata EH provides the
>>   foundation for not only improved error handling, but also new features
>>   such as device hotplug or command queueing. (Tejun Heo)
>>
>> * PIO-based I/O is now IRQ-driven by default, rather than polled
>>   in a kernel thread.  The polling path will continue to exist for
>>   controllers that need it, and other special cases. (Albert Lee)
>>
>> * Core support for command queueing (Jens Axboe, Tejun Heo)
>>
>> * Support for NCQ-style command queueing (Jens Axboe, Tejun Heo)
>>
>> * Increase max-sectors dramatically, for LBA48 devices (Tejun Heo?)
>>
>> * Other minor changes, from myself and others.
> 
> How about PATA?  Specifically intel's IDE chip.  I have a machine that I can
> blow the hard drive away if I want to.

Always helpful.  ata_piix should support Intel PATA controllers, modulo 
some bugs that Alan is fixing / has fixed.  If your PCI ID isn't listed, 
you will have to add it, and an associated info entry.  Again, take a 
look at Alan's libata PATA patches for guidance.

	Jeff



