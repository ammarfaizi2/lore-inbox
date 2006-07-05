Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWGESmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWGESmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWGESmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 14:42:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964961AbWGESmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 14:42:54 -0400
Date: Wed, 5 Jul 2006 11:41:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@suse.de>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: early pagefault handler
In-Reply-To: <1152124139.6533.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607051139160.12404@g5.osdl.org>
References: <200607050745_MC3-1-C42B-9937@compuserve.com>  <p73veqcp58s.fsf@verdi.suse.de>
 <44ABEB20.2010702@zytor.com>  <Pine.LNX.4.64.0607050952190.12404@g5.osdl.org>
 <1152124139.6533.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jul 2006, Alan Cox wrote:
>
> Ar Mer, 2006-07-05 am 09:54 -0700, ysgrifennodd Linus Torvalds:
> > Anybody with that old a CPU will have learnt to to say "no-hlt" or 
> > whatever the kernel command line is, and we could probably retire the 
> > silly old hlt check (which I'm not even sure really ever worked).
> 
> The one specific case I know precisely details of was the Cyrix 5510. A
> hlt by the CPU on that chipset during an IDE DMA transfer hangs the
> system forever.

Yeah, now that you say it, another "halt" problem was some floppy DMA 
apparently being broken by halt on some machines.

The indirect point of that being that the boot-time hlt test wouldn't 
actually have triggered that anyway (no DMA taking place at that time).

Although I suspect back when this mattered (a long long time ago ;), the 
boot-time hlt test made a lot of people more _aware_ of the fact that halt 
could cause problems.

Sometimes the solutions are purely psychological ;)

		Linus
