Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbUJZTIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUJZTIy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUJZTIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:08:54 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:59657 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261432AbUJZTI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:08:29 -0400
Message-ID: <417EA3BB.1090700@techsource.com>
Date: Tue, 26 Oct 2004 15:21:31 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: pbecke <pbecke@javagear.com>
CC: linux-os@analogic.com, Giuseppe Bilotta <bilotta78@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Some discussion points open source friendly graphics [was:  HARDWARE:
 Open-Source-Friendly Graphics Cards -- Viable?]
References: <417D21C8.30709@techsource.com> <417D6365.3020609@pobox.com> <MPG.1be854649d4829f8989704@news.gmane.org> <417E6CF3.503@techsource.com> <Pine.LNX.4.53.0410261118120.338@chaos.analogic.com> <417E7582.6050805@techsource.com> <6.1.2.0.1.20041026110017.021ece28@mail.javagear.com>
In-Reply-To: <6.1.2.0.1.20041026110017.021ece28@mail.javagear.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



pbecke wrote:
> In many of the FPGA designs I have done, I have always tried to use some 
> kind of parallel host interface port, that are built into many FPGAs to 
> program the FPGA.  This allows the FPGA to be loaded as if it is a 
> memory device, Yes, it does mean that some external glue logic is 
> usually required to decode address lines and such, but, it means that 
> you can eliminate the eeprom, and usually the loading to the devices it 
> self if much faster.  I have more experience with the ram based FPGAs 
> from Xilinx, then the eprom based ones from Actel, so it may not be 
> feasible with the eprom based ones.  But I really think that in system 
> configuration is an advantage, that opens some possibilities that are 
> much more difficult to implement if the design relies on a serial prom 
> for the source of the FPGA configuration data.

My first desire is to minimize chip count, which means one FPGA with as 
much of the logic in it as possible.  If we do multi-core designs, it 
would be logical to be able to reprogram each of the chips separately. 
I would bundle the PCI controller with the PROM reprogrammer and any 
other logic which doesn't change much and put the rest into the other 
chip(s).  This way, you could reprogram the core without risking the 
whole thing.

> 
> By the way have you considered opencores.org's VGA controller as a 
> starting point for a design?

I am aware of it, but I've hesitated to even look at it.  I respect the 
author's wish to put it under a GPL-like license, and I don't want to 
"cheat".  (The issue here isn't what's legal but what's ethical. 
Companies do bad things all the time which are perfectly legal, and I 
want to avoid that.)  The author of that VGA core posted to the 
kerneltrap thread.  Perhaps I can make some sort of arrangement with 
him.  For instance, a friend of mine sold a commercial program which had 
some GPL'd components, but he first asked the authors to relicense under 
LGPL.  I'd be happy to release my improvements to any PIECES that I got 
from elsewhere, but I want to have the option of not releasing the WHOLE 
thing.

