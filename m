Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbVAPXSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbVAPXSL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVAPXSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:18:10 -0500
Received: from tim.rpsys.net ([194.106.48.114]:61336 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262647AbVAPXSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:18:04 -0500
Message-ID: <047701c4fc21$a1579b50$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>, "Ian Molton" <spyro@f2s.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Pierre Ossman" <drzeus-list@drzeus.cx>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk> <023c01c4f8f3$1d497030$0f01a8c0@max> <20050112221753.F17131@flint.arm.linux.org.uk> <41E5B177.4060307@f2s.com> <41E7AF11.6030005@drzeus.cx> <41E7DD5E.5070901@f2s.com> <41EA5C8D.8070407@drzeus.cx> <41EA69F0.5060500@f2s.com> <41EAC3FD.1070001@drzeus.cx>
Subject: Re: MMC Driver RFC
Date: Sun, 16 Jan 2005 23:17:59 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King:
> > 2. Card Initialisation Problems
> >
> > One of my cards works fine. The other works when I enable debug and 
> > doesn't when I don't. I suspect the delay while it does a printk gives 
> > something time to happen that doesn't normally when running at full 
> > speed!
>
> Different cards behave differently.  I suspect you have yet another
> quirky card.

For reference, I got the 512MB SD card working by adding an mdelay(3) into 
the middle of mmc_send_op_cond(). Anything shorter and it marks the card as 
bad...

http://www.rpsys.net/openzaurus/2.6.11-rc1/mmc_sd-r2.patch shows the updated 
SD code that works for me on the Sharp SL-C760 with the mdelay included.

Pierre Ossman:
> The patch can be found at:
> http://projects.drzeus.cx/wbsd/sd.php

Now I've got both my cards working, I plan to test this code and compare 
soon. The added features look good.

> That page also contains the legal issues as I've understood them.

I don't see the problems you mention there. Yes companies may have signed 
agreements with the SD card association and yes, that may possibly mean they 
can't distribute Linux with SD support but that would be *their* problem and 
not a reason against including SD support in the kernel. If they remove any 
SD code from Linux then they would still be able to distribute it. I suspect 
that they would be able to distribute SD code already in the public domain 
anyway.

On the subject of patents, the whole idea behind SD is that there aren't 
patents as for a patent to exist, we'd have some publicly available 
information on how SD works. We're not breaking any copyrights as I nobody 
involved with this code has see any code to copy from.

So in short, I can't see any reason we can't put the code we have into the 
kernel...

Richard 

