Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263305AbTD0DCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 23:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTD0DCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 23:02:49 -0400
Received: from colin.muc.de ([193.149.48.1]:57354 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id S263305AbTD0DCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 23:02:48 -0400
Message-ID: <20030427051451.43064@colin.muc.de>
Date: Sun, 27 Apr 2003 05:14:51 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternative patching for prefetches & cleanup
References: <20030427021958.GA27897@averell> <Pine.LNX.4.44.0304262005460.25292-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <Pine.LNX.4.44.0304262005460.25292-100000@home.transmeta.com>; from Linus Torvalds on Sun, Apr 27, 2003 at 05:09:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +++ linux-gencpu/arch/i386/kernel/setup.c	2003-04-27 04:12:32.000000000 +0200
> > @@ -795,41 +795,42 @@
> >  		pci_mem_start = low_mem_size;
> >  }
> >  
> > +asm("nops: " 
> > +    ASM_NOP1 ASM_NOP2 ASM_NOP3 ASM_NOP4 ASM_NOP5 ASM_NOP6
> > +    ASM_NOP7 ASM_NOP8); 
> > +
> 
> This in particular is just too ugly for words. Why can't you just have a

Hmm. I thought using the Fibonaci sequence for this was clever :-)

But ok I'll change it to the array.

-Andi
