Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWBZUdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWBZUdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWBZUdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:33:03 -0500
Received: from rtr.ca ([64.26.128.89]:56778 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750972AbWBZUdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:33:01 -0500
Message-ID: <4402106D.60605@rtr.ca>
Date: Sun, 26 Feb 2006 15:32:45 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
References: <5KtPb-2oP-9@gated-at.bofh.it> <5Kxzs-7M7-19@gated-at.bofh.it> <5KxJa-7XQ-31@gated-at.bofh.it> <5KxT2-8a6-15@gated-at.bofh.it> <5KyFa-RL-1@gated-at.bofh.it> <4401F6BA.5010607@shaw.ca>
In-Reply-To: <4401F6BA.5010607@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Henrik Persson wrote:
>> Does happen once or twice a year.. Probably something funky with the
>> cabling or some power-related issues.
>>
>> Anyway, I would be happy if the IDE driver would "just not do that". :)
> 
> I can see the reasoning where the device just doesn't function properly 
> with DMA at all (like on some Compact Flash-to-IDE adapters where the 
> card claims to support DMA but the DMA lines aren't wired through in the 
> adapter properly). In that case not disabling DMA would render it 
> useless. The IDE layer could keep track of whether DMA was previously 
> working on that device however, and not disable DMA on reset if it had 
> previously been working.

Definitely.  Where these things get sticky is in defining "DMA was working".
And keeping track of it separately for reads and writes.

cheers
