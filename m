Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbRL1QLH>; Fri, 28 Dec 2001 11:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286478AbRL1QK5>; Fri, 28 Dec 2001 11:10:57 -0500
Received: from e120116.upc-e.chello.nl ([213.93.120.116]:19727 "EHLO
	stempel.dhs.org") by vger.kernel.org with ESMTP id <S286934AbRL1QKs>;
	Fri, 28 Dec 2001 11:10:48 -0500
Date: Fri, 28 Dec 2001 17:10:43 +0100 (CET)
From: Edward Stempel <eazstempel@cal009001.student.utwente.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: linux-kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: DMA conflicts with soundcard for ide driver via82cxxx 
Message-ID: <Pine.LNX.4.21.0112281708470.2782-100000@nieuw3.stempel.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent! That solved my problem.

Thankx

Edward




Date: Fri, 28 Dec 2001 10:15:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Edward Stempel <eazstempel@cal009001.student.utwente.nl>
Cc: linux-kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: DMA conflicts with soundcard for ide driver via82cxxx

On Fri, Dec 28, 2001 at 03:32:34AM +0100, Edward Stempel wrote:

> I have an Asus a7v266 mother board and an Ensoniq sound card in it. 
> The ide chipset is a VIA VT8233 that is capable of UDMA100. So I built a
> kernel with the es1371 sound driver and the via82cxxx ide driver
> configured in it. Actually I tried the kernel 2.4.17 first, and the latest
> I tried is 4.5.1 with the latest patch (patch-2.5.2-pre3) applied to it.
> I also tried the kernel 2.5.1 with Vojtech  patch (via-3.33.diff from
> his email dated 2001-12-23 23:20:48) applied to it, with the same
> (negative) results.
> 
> The good thing is that hdparm reports appr. 40 MB/sec when using DMA and
> about 6 MB/sec when not using DMA.
> Unfortunately using DMA for ide results in some ugly distortion of the
> sound from my soundcard whenever some IO to the disk is done.  :((
> 
> I have assigned different interrupts to the PCI-cards (ide is 
> on-board) and I even changed the sound card's PCI slot, so it shared
> its interrupt with another device (acpi instead of USB). It did not solve
> the problem. Because the problem only occurs when switching on using_dma
> on the ide driver, I think it is a DMA problem with the ide driver. It may
> be the es1371 driver as well off course, but I suspect it is the ide
> driver (or chipset).
>   
> Reading the list archive from linux-kernel, I discovered there have been
> more problems with DMA using this chipset, but I did not find anyone
> having the same problem as I have now.
> 
> Has someone also dealt with these problems, or can someone help me
> solving this problem? Please help!  
> 
> Below are some outputs using kernel 5.1 with patch-2.5.2-pre3.

You may try changing the PCI latency settings on either the IDE
controller or the sound card. Other than that, I don't know how to help.

-- 
Vojtech Pavlik
SuSE Labs

