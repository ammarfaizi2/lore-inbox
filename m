Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310789AbSCVK5d>; Fri, 22 Mar 2002 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310940AbSCVK5Y>; Fri, 22 Mar 2002 05:57:24 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37383 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310789AbSCVK5N>; Fri, 22 Mar 2002 05:57:13 -0500
Message-ID: <3C9B0D9F.5030102@evision-ventures.com>
Date: Fri, 22 Mar 2002 11:55:27 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: John Langford <jcl@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <E16oAs1-0006SJ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>There seems to be some fundamental incompatibility between the kernel
>>and the IDE chipset.  On several kernels in the 2.4 series including
>>2.4.18, I observe a hang in the bootsequence at:
>>
>>ALI15X3: IDE controller on PCI bus 00 dev 78
>>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci=biosirq.
>>ALI15X3: chipset revision 195
>>ALI15X3: not 100% native mode: will probe irqs later
>><hang>
> 
> 
> And does pci=bios help ?

There is a but in this driver, where it is refferencing hwif->index instead
of hwif->channel. It may cause a hossed setup.

