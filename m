Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSBVV0o>; Fri, 22 Feb 2002 16:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293003AbSBVV0e>; Fri, 22 Feb 2002 16:26:34 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:46604 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S287552AbSBVV01>; Fri, 22 Feb 2002 16:26:27 -0500
X-AuthUser: davidel@xmailserver.org
Date: Fri, 22 Feb 2002 13:28:48 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Aloni <da-x@gmx.net>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] C exceptions in kernel
In-Reply-To: <1014412325.1074.36.camel@callisto.yi.org>
Message-ID: <Pine.LNX.4.44.0202221326180.1484-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Feb 2002, Dan Aloni wrote:

> The attached patch implements C exceptions in the kernel, which *don't*
> depend on special support from the compiler. This is a 'request for
> comments'. The patch is very initial, should not be applied.
>
> I actually got this code to work in the kernel:
>
>         try {
>                 printk("TEST: before throwing \n");
>                 throw(1000);
>                 printk("TEST: won't run\n");
>         }
>         catch(unsigned long, value) {
>                 printk("TEST: caught: %ld\n", value);
>         } yrt;
>
> I know it would a *hugh* task to get all existing code in the kernel
> to use exceptions, but the design allows exceptions to be used locally
> within the local call branches in *new* code. Basically, exception
> handling needs to be added only to functions who call functions which
> already use exceptions.
>
> Although this patch is against 2.4, it should go to 2.5 (2.5.5-dj1
> currently breaks here, so I am temporarily developing it using 2.4)
>
> This patch implements only for i386 at the moment. Theoretically can be
> ported to other archs. Of course, the arch dependant functions in this
> code are separated for the ease of porting.
>
> I haven't written it with interrupts and SMP in mind. I wonder what
> are the race conditions and what should be protected there.
>
> For unhandled exceptions, there's a possibility to add a function that
> printk's the information about the unhandled exception (file, line
> number, etc), and optionally calls panic() or BUG().
>
> The code supports re-throwing from catches.
>
> Last thing: I must get rid of that yrt closer macro. Suggestions?

Is today the 1st of April ? You kidding, don't you ?



- Davide



