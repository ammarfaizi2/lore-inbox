Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286788AbRL1JPc>; Fri, 28 Dec 2001 04:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286790AbRL1JPW>; Fri, 28 Dec 2001 04:15:22 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:51467 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S286788AbRL1JPH>; Fri, 28 Dec 2001 04:15:07 -0500
Date: Fri, 28 Dec 2001 10:15:05 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Edward Stempel <eazstempel@cal009001.student.utwente.nl>
Cc: linux-kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: DMA conflicts with soundcard for ide driver via82cxxx
Message-ID: <20011228101505.B23409@suse.cz>
In-Reply-To: <Pine.LNX.4.21.0112280046560.1948-100000@nieuw3.stempel.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112280046560.1948-100000@nieuw3.stempel.dhs.org>; from eazstempel@cal009001.student.utwente.nl on Fri, Dec 28, 2001 at 03:32:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
