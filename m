Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbTICMYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbTICMYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:24:04 -0400
Received: from 3E6B2019.rev.stofanet.dk ([62.107.32.25]:30085 "EHLO sysrq.dk")
	by vger.kernel.org with ESMTP id S261987AbTICMYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:24:01 -0400
Subject: Re: Airo Net 340 PCMCIA WiFi Card trouble
From: Martin Willemoes Hansen <mwh@sysrq.dk>
To: tonildg <tonildg@terra.es>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3F555B68.2010408@terra.es>
References: <1062498150.356.9.camel@spiril.sysrq.dk>
	 <20030902113610.D29984@flint.arm.linux.org.uk>
	 <1062500366.642.11.camel@hugoboss.sysrq.dk>  <3F555B68.2010408@terra.es>
Content-Type: text/plain
Message-Id: <1062591834.8758.18.camel@hugoboss.sysrq.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 14:23:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 05:09, tonildg wrote:
>  >The error message:
>  >cardmgr[19]: starting, version is 3.2.4
>  >cs: memory probe 0x0c0000-0x0ffff: excluding >0xc0000-0xcbfff
> 
>   I had the same problem you have (but in other range of memory and with 
> another wireless card) and it started too with 2.4.19. 
> 
>  I solved it testing with memory ranges in the config.opts file that 
> comes with your pcmcia_cs version.
> 
>    You have to play with them until one fits and boots. "I had to use 
> windows to see the memory adresses my cardbus used." 

Umh can I check it out on Linux as well? And how? I can boot correctly
with 2.4.19.

> Usually, when 
> comenting the "include memory 0xc0000-0xfffff" solves it.

Yes when I comment that include out I can boot but the card is not
properly intitialized, here is the errors I get:

airo: register interrupt 0 failed, rc -16
airo_cs: RequestConfiguration: Operation succeeded

cardmgr[20]: get dev info on socket 0 failed: Resource temporarily
unavailable.

> However this problem is not caused by the Airo driver. And, (i think) it 
> is not a  kernel problem. Maybe a pcmcia_cs one.

Okay so the kernel changed something and is now using that memory area?

-- 
Martin Willemoes Hansen

--------------------------------------------------------
E-Mail	mwh@sysrq.dk	Website	mwh.sysrq.dk
IRC     MWH, freenode.net
--------------------------------------------------------               


