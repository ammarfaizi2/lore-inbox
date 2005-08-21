Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVHUOrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVHUOrV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 10:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbVHUOrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 10:47:21 -0400
Received: from a82-92-179-183.adsl.xs4all.nl ([82.92.179.183]:31815 "EHLO
	samwel.tk") by vger.kernel.org with ESMTP id S1751030AbVHUOrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 10:47:20 -0400
Message-ID: <43089400.1060603@samwel.tk>
Date: Sun, 21 Aug 2005 16:47:28 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrea gelmini <andrea.gelmini@linux.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA problem with kernel >2.6.10
References: <20050807164824.GA3312@gelma.net>
In-Reply-To: <20050807164824.GA3312@gelma.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea gelmini wrote:
> 	Hardware: Toshiba Satellite P20 (P4-3200 MHz, 512MB RAM) [1]
> 	Software: Debian Unstable
> 	GCC: 3.4.5 [2]
> 	Memtest86+: v.1.60 (stress tools, CPU/RAM and so on, are all happy)
> 	Problem: with kernel <=2.6.10 everything is all right...
> 	but with any kernel released after 2.6.10 (pre, rc, stable, mm, and
> 	so on), I've got this:
> 
> hda: dma_timer_expiry: dma status == 0x21
> hda: DMA timeout error
> hda: dma timeout error: status=0xd0 { Busy }
[...]
> 	It happen quickly if I do also something like this:
> 	
> 	cd /proc/sys/vm
> 	echo 100 > dirty_background_ratio
> 	echo 1000000 > dirty_expire_centisecs
> 	echo 100 > dirty_ratio
> 	echo 1000000 > dirty_writeback_centisecs

I've had a report about this before, from someone who was using laptop 
mode -- same error message. Funny thing is, the laptop mode tools 
scripts also modify the above values, so it's probably the same problem. 
Until now I thought it was a Thinkpad hardware problem, because I only 
heard about these problems on Thinkpads, but apparently it's a kernel 
problem after all. Don't know anything about the causes though.

--Bart
