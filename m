Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWBZVLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWBZVLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWBZVLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:11:13 -0500
Received: from mail.linicks.net ([217.204.244.146]:17896 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S1751400AbWBZVLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:11:12 -0500
From: Nick Warne <nick@linicks.net>
To: Henrik Persson <root@fulhack.info>, Robert Hancock <hancockr@shaw.ca>
Subject: Re: hda: irq timeout: status=0xd0 DMA question
Date: Sun, 26 Feb 2006 21:10:55 +0000
User-Agent: KMail/1.9.1
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Mark Lord <lkml@rtr.ca>,
       linux-kernel@vger.kernel.org
References: <200602261308.47513.nick@linicks.net> <200602261720.34062.nick@linicks.net> <4401EF2C.2000004@fulhack.info>
In-Reply-To: <4401EF2C.2000004@fulhack.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602262110.55324.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I can see the reasoning where the device just doesn't function properly
> > with DMA at all (like on some Compact Flash-to-IDE adapters where the
> > card claims to support DMA but the DMA lines aren't wired through in the
> > adapter properly). In that case not disabling DMA would render it
> > useless. The IDE layer could keep track of whether DMA was previously
> > working on that device however, and not disable DMA on reset if it had
> > previously been working.
> 
> Definitely.  Where these things get sticky is in defining "DMA was working".
> And keeping track of it separately for reads and writes.

Hey guys, keep the CC intact, I missed these.

Yes, all the above points are valid and right, I think.

As a user we know if DMA is OK on a ide device, right?  Then let user have 
option to set it permanent, else carry on as the code does now when idex 
needs a reset.

Nick.
