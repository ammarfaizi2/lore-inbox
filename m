Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRKIQCF>; Fri, 9 Nov 2001 11:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279952AbRKIQB4>; Fri, 9 Nov 2001 11:01:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S279951AbRKIQBs>; Fri, 9 Nov 2001 11:01:48 -0500
Date: Fri, 9 Nov 2001 11:01:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manfred Spraul <manfred@colorfullife.com>
cc: "David S. Miller" <davem@redhat.com>, jakub@redhat.com, bcrl@redhat.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
In-Reply-To: <3BEBF730.86CAE1CC@colorfullife.com>
Message-ID: <Pine.LNX.3.95.1011109105639.2037A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Manfred Spraul wrote:

> "David S. Miller" wrote:
> > 
> >    From: Manfred Spraul <manfred@colorfullife.com>
> >    Date: Fri, 09 Nov 2001 15:54:03 +0100
> > 
[SNIPPED...]

> smp_processor_id() is definitively not const.
> 
> OTHO 'current' is const.
> --

Not as far as the compiler is concerned! You don't want the compiler
to generate code that reads 'current' once upon startup, and never
again. Further, you don't want that pointer to exist in .rodata, you
want it with the changable variables in .data or .bss .

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


