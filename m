Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUH0OZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUH0OZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUH0OZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:25:41 -0400
Received: from [195.23.16.24] ([195.23.16.24]:55213 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265492AbUH0OZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:25:40 -0400
Message-ID: <412F4460.3070609@grupopie.com>
Date: Fri, 27 Aug 2004 15:25:36 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Beattie <beattie@beattie-home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sandisk 256MB Compact Flash (SDCFH-256) hangs on access (2.4.26)
References: <1093548140.2903.35.camel@kokopelli>
In-Reply-To: <1093548140.2903.35.camel@kokopelli>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.35; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Beattie wrote:
> If there is a better forum for this question, please let me know.
> 
> I'm running Debian Sarge/2.4.26-1-i686-smp, trying to access this
> compact flash using a CF/IDE adapter from ACS (ACS-CF-IDEToCFA).  This
> works fine for every other CF I have tried (128 and 64).  I have a
> number of these parts and they all act the same and they work fine in an
> PCMCIA/CF adapter and a USB CF reader.   I have set up what I think is
> the simplest case, I have run fdisk and mkfs on another machine using
> the PCMCIA adapter.
> 
> When I try to mount the CF it hangs and I start getting "lost
> interrupt",  does anybody have experience or clues that might help me?

I had similar problems with almost the same setup because of devfs, and 
specially because of devfsd (the devfs deamon).

I suggest you try first to disable the devfsd, and then disbale devfs 
completely. I think there are very ugly race conditions there that only 
appear on a "fast enough" CF card.

If you're not using devfs, then I don't know what the problem is... :(

-- 
Paulo Marques - www.grupopie.com
