Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbTGHLko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbTGHLko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:40:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38276 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267258AbTGHLkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:40:42 -0400
Date: Tue, 8 Jul 2003 07:56:49 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
In-Reply-To: <3F09E6EF.8000806@redhat.com>
Message-ID: <Pine.LNX.4.53.0307080754550.24488@chaos>
References: <Pine.LNX.4.53.0307071655470.22074@chaos> <3F09E6EF.8000806@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Ulrich Drepper wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Richard B. Johnson wrote:
>
> > write(1, "Addr = 000b8000\n", 16)       = 16
> > open("/dev/mem", O_RDWR)                = 3
> > mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xb8000) = 0xb8000
>
> mmap64() (and if you compile glibc with an adequate minimal kernel
> requirement mmap as well) is implemented using mmap2.  It works nicely.
>  Admittedly, I haven't used the stock 2.4 kernel.  And I also haven't
> used /dev/mem.  But at least for the first part I would expect to see
> problem reports since the code is used and glibc wouldn't work.
>
> In your code, assuming this is x86, do you really want to read the
> memory starting at address 0xb8000000?  This is what your code does.  I
> don't know enough about the kernel memory layout to say whether
> something is supposed to be there or not.
>

Yes. Thanks. There is no known documentation that states that
the address to the function is in PAGES. Certainly, this will
work once I use pages instead of bytes.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

