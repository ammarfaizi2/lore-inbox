Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264764AbRGCO5x>; Tue, 3 Jul 2001 10:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264692AbRGCO5k>; Tue, 3 Jul 2001 10:57:40 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264564AbRGCO5b>; Tue, 3 Jul 2001 10:57:31 -0400
Date: Tue, 3 Jul 2001 10:57:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: =?iso-8859-1?q?Guillaume=20Lancelin?= <guillaumelancelin@yahoo.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: Memory access
In-Reply-To: <20010703144532.11007.qmail@web4201.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1010703105434.511A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2001, [iso-8859-1] Guillaume Lancelin wrote:

> Writing a device driver for a IO card, I have the following message from
> the kernel:
> Unable to handle kernel paging request at virtual address 000d0804.
> [then it gives the register values]
> Segmentation fault."
> 
> This address (0xd0804) is the location of a "mailbox" reserved by the IO
> card, and from which commands are passed to the card.
> 
> My question: is the kernel using or protecting this area of the memory,
> and is there a way to deprotect it??? (how dangerous!)
> 

This is not the correct address!! The addresses in the kernel are
virtual addresses, you need to execute ioremap(0xd0804, LENGTH) to
get the correct virtual address for access.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


