Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316222AbSEQNyq>; Fri, 17 May 2002 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSEQNyq>; Fri, 17 May 2002 09:54:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4737 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316222AbSEQNyp>; Fri, 17 May 2002 09:54:45 -0400
Date: Fri, 17 May 2002 09:56:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "J.P. Morris" <jpm@it-he.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Aralion and IDE blasphemy
In-Reply-To: <20020517142617.5b73a46d.jpm@it-he.org>
Message-ID: <Pine.LNX.3.95.1020517093736.4698A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, J.P. Morris wrote:

> 
> This is probably approaching blasphemy, but has anyone ever considered
> an emergency EIDE driver that uses the extended int13h calls?
> I'm pretty sure there's a protected-mode BIOS interface in modern BIOSes
> these days, so it shouldn't need to go down to real mode to make the
> calls.
> 
> I have just purchased an IDE RAID controller to add tertiary and
> quaternary IDE ports to my system for an extra CDROM drive.
> I thought the days when you couldn't get Linux support for such things
> were long gone, but sadly no.
> 
> The culprit is an ARALION ARS106S chipset card.  Interestingly it works
> in DOS, and if the hard disks are attached to it, it will even boot
> up to LILO, but then the kernel dies because it can't find the HDDs.
> (On their web page message board, some guy asks for the specs but is
>  helpfully pointed to an obsolete binary module for RedHat 7.1.)
> 
> If there was Linux support for BIOS-based EIDE controllers, it should
> in theory work, if slowly.
> 
> Alternatively, can anyone suggest a cheap tertiary EIDE card suitable
> for CDROM or hard disks that Linux can support?


Just install Linux from a current distribution, i.e., like
RedHat (not an Add, just came-to mind because I don't know
how to spell Suse and/or whatever..). The drivers for IDE/EIDE/RAID
are in their installation kernels. If you are trying to build a kernel
to support EIDE, the problem is figuring out what questions to answer
during configuration. The major distributors have already figured that
out.

You can't do 'BIOS-based' stuff in the kernel (although it's been tried
for what should be simple stuff like APM).

The BIOS code itself often makes assumptions about the environment
like it can plug its interrupt vector into the interrupt table and
enable its ISR.

There can't be, as you say, "a protected mode BIOS interface" for
the same reason nobody does general purpose surgery. Every
protected-mode system is different.

Also, when LILO boots, if it didn't get past Uncompressing, then
booting the kernel, it's NOT a lack of hard-disk support. You
probably have built the kernel for a processor you don't have.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

