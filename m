Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265824AbUFDPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265824AbUFDPrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUFDPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:47:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:49028 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265824AbUFDPri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:47:38 -0400
Date: Fri, 4 Jun 2004 08:47:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andy Lutomirski <luto@myrealbox.com>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, suresh.b.siddha@intel.com,
       jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
In-Reply-To: <20040604154142.GF16897@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de>
 <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com>
 <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org>
 <20040604154142.GF16897@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jun 2004, Arjan van de Ven wrote:
> 
> the prelink rpm on Fedora has such a tool already fwiw.
> (it's part of prelink because the elf manipulations needed are quite similar
> to the ones prelink does so infrastructure is shared)

Just for fun, can somebody that has the required hardware just test old 
apps with NX turned on? 

I know we used to put the signal handler trampoline on the stack, but
these days that should all be handled with the magic executable syscall
page, so _normally_ I don't think an old application should even really
care.

In fact, it would be interesting to just hear somebody running an older
distribution with a new CPU and a new kernel, and see just how many
programs need to be marked non-NX in "normal running".

		Linus
