Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264841AbRGITf0>; Mon, 9 Jul 2001 15:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbRGITfQ>; Mon, 9 Jul 2001 15:35:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264779AbRGITfC>; Mon, 9 Jul 2001 15:35:02 -0400
Date: Mon, 9 Jul 2001 15:34:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gareth Hughes <gareth.hughes@acm.org>
cc: "Ernest N. Mamikonyan" <ernest@newton.physics.drexel.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: increasing the TASK_SIZE
In-Reply-To: <3B49C3C5.1A852029@acm.org>
Message-ID: <Pine.LNX.3.95.1010709152824.1001B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2001, Gareth Hughes wrote:

> "Ernest N. Mamikonyan" wrote:
> > 
> > I was wondering how I can increase the process address space, TASK_SIZE
> > (PAGE_OFFSET), in the current kernel. It looks like the 3 GB value is
> > hardcoded in a couple of places and is thus not trivial to alter. Is
> > there any good reason to limit this value at all, why not just have it
> > be the same as the max addressable space (64 GB)? We have an ix86 SMP
> > box with 4 GB of RAM and want to be able to allocate all of it to a
> > single program (physics simulation). I would greatly appreciate any help
> > on this.
> 
> Sounds like you just need to enable highmem.  Check the help for "High
> Memory Support" in "Processor type and features".
> 
> -- Gareth

Also, additional memory on an ix86, as specified, can only be accessed
via page registers (like the old DOS himem.sys). This is because
the Intel machines have 32 bits of address-space. That's around
4 GB, not 64 GB. So, if you intend to do conventional, user-space
programming,i (like using malloc) you will not be able to get anything
like 4 GB.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


