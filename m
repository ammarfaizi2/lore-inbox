Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbTGHLiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267256AbTGHLiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:38:18 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37508 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267250AbTGHLiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:38:17 -0400
Date: Tue, 8 Jul 2003 07:54:26 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: syscall __NR_mmap2
In-Reply-To: <20030708003656.GC12127@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0307080749160.24488@chaos>
References: <Pine.LNX.4.53.0307071655470.22074@chaos>
 <20030708003656.GC12127@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xb8000) = 0xb8000
>
> You meant to write:
>
> 	mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE,
> 	      MAP_SHARED|MAP_FIXED, 3, 0xb8000 >> 12);
>
> The offset argument to mmap2 is divided by PAGE_SIZE.
> That is the whole point of mmap2 :)
>
> -- Jamie

Okay. Do you know where that's documented? Nothing in linux/Documentation,
and nothing in any headers. Do you have to read the code to find out?

So, the address is now the offset in PAGES, not bytes. Seems logical,
but there is no clue in any documentation.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

