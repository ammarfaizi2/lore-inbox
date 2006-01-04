Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbWADK1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbWADK1S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWADK1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:27:18 -0500
Received: from vvv.conterra.de ([212.124.44.162]:49055 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1751655AbWADK1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:27:18 -0500
Message-ID: <43BBA2FE.5060006@conterra.de>
Date: Wed, 04 Jan 2006 11:27:10 +0100
From: =?ISO-8859-1?Q?Dieter_St=FCken?= <stueken@conterra.de>
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X86_64 + VIA + 4g problems
References: <43B90A04.2090403@conterra.de> <p73k6difvm3.fsf@verdi.suse.de>	<43BA4C3D.4060206@conterra.de> <p731wzpjtvm.fsf@verdi.suse.de>
In-Reply-To: <p731wzpjtvm.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> [can you please not always drop me from cc with each reply?] 

sorry, I thought the other way around: it would be annoying
to get each mail twice...

I just found a mailing list "discuss@x86-64.org". Would it be
better to turn over there, instead of polluting linux.kernel
by this?

>> But swiotlb=force works well! 
>
> This means your PCI bridge doesn't support addresses >4GB. 
>
>> The pci-gart.c patch seems to disable dma.
> 
> Only DMA for addresses >4GB.
> 
> If your torture test involves more than 64MB of IO in flight
> you might also need to increase the bounce buffer area
> with swiotlb=128M or somesuch. 

I'm about to understand whats going on. So should I use the
dma patch INSTEAD of "swiotlb=force"? I'll try that tonight.

> When you not compile in the SKGE network driver does everything else work? 

I may test it again, but all seemed to work without any patch or
swiotlb settings when running without the SKGE network driver.

So, how does this work, if my PCI bridge generally fails above 4G?

Problems arise not until I enable/use the network driver.
Does the dma-patch disable DMA for all PCI devices or only
for those which cause problems (like my SKGE)?

Dieter.
-- 
Dieter Stüken, con terra GmbH, Münster
     stueken@conterra.de
     http://www.conterra.de/
     (0)251-7474-501
