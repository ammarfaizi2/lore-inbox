Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWAXM7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWAXM7r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 07:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWAXM7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 07:59:47 -0500
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:5125 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030468AbWAXM7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 07:59:46 -0500
Message-ID: <43D624B4.5070300@superbug.co.uk>
Date: Tue, 24 Jan 2006 12:59:32 +0000
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Harish K Harshan <harish@arl.amrita.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA Transfer problem
References: <43D5B473.3060006@arl.amrita.edu>
In-Reply-To: <43D5B473.3060006@arl.amrita.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harish K Harshan wrote:
> Hello,
>
>   Im having problems with DMA transfer on Linux, for an ADC card. The 
> card is AxiomTek AX5621H, and can use DMA channels 1 and 3. I tried 
> both the channels, but the DMA transfers are irregular (i.e.) at 
> different speeds (which of course is not acceptable, since that 
> application is time critical). The device driver (which I wrote) seems 
> to work fine for all the other systems I tried it on. But this problem 
> occurs only on one particular model of computer (Chino-Laxsons 
> Pentium-4 boards). I tried another system with the same configuration, 
> but the same resulted. After some time of execution, I get the kernel 
> panic screen, which says the CPU context is corrupt. Please help me 
> with this problem, as I need to get this driver working somehow on the 
> P4 systems. I tried the Redhat-9 kernel (2.4.20-8) and the debian 
> kernel too (2.2.20).... gave the same results.
>
Could an ADC card be treated as a ALSA sound card PCM device.
That card seems to have features very similar to a sound card.
Sample rate.
Variable gain.
Multi-channels.
ADC
DMA

I only suggest this, because it could result in a driver that is much 
easier to implement as ALSA supplies a lot of generalised support code 
at the kernel level.

James

