Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVKQLi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVKQLi1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 06:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVKQLi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 06:38:27 -0500
Received: from bsamwel.xs4all.nl ([82.92.179.183]:16968 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S1750768AbVKQLi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 06:38:26 -0500
Message-ID: <437C6B3E.1090905@samwel.tk>
Date: Thu, 17 Nov 2005 12:36:30 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5 (Windows/20051025)
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
References: <20051116181612.GA9231@knautsch.gondor.com> <437B912B.7090505@samwel.tk> <20051116214222.GB4935@knautsch.gondor.com> <437C4C8B.4030502@samwel.tk> <20051117103352.GA4832@knautsch.gondor.com>
In-Reply-To: <20051117103352.GA4832@knautsch.gondor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> No ide errors at all in the kernel logs, which cover more than one
> month.
 >
>> What's your hardware? A Thinkpad perhaps?
> 
> ASUS M2400N with a SAMSUNG MP0804H 80GB hard drive (this is not
> the original hard drive - the notbook was delivered with a 60GB
> drive). Centrino chipset, 1.6GHz Pentium M. Hard drive running in udma5
> mode. 512MB RAM, Intel Pro Wireless 2100 replaced with an Intel Pro
> Wireless 2200 wireless lan card, and a CardMan 4000 card reader in the
> pccard slot - not that I think these have any influence on the hard drive,
> but this is the complete hardware description.

Thanks. The reason I asked whether it was a Thinkpad is that the DMA 
problems usually occur on Thinkpads. You don't have a thinkpad, and you 
don't see the log messages, so that's not it. The filesystem's block 
bitmaps were OK, so that's not it. Quoting you in your previous message:

# I suspected the hard drive to mess up write requests during spin-up.
# Or perhaps giving some kind of error message, which could trigger a
# bug in a rarely tested error-handling path in the kernel. But the fact
# that you never got similar reports makes this less likely. In the end,
# I have to consider there may be some bad hardware in my laptop.

If there are no other reports on different hardware, then I'm afraid you 
might be right about the hardware thing. :( I think problems like these 
usually don't get noticed/fixed because modern Windows versions are 
actually very lousy at spinning down disks -- in my experience it 
doesn't really happen, even though you can set the timeouts.

I'm sorry I'm not able to help you out here.

--Bart
