Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281068AbRKYVck>; Sun, 25 Nov 2001 16:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRKYVcU>; Sun, 25 Nov 2001 16:32:20 -0500
Received: from jik-0.dsl.speakeasy.net ([66.92.77.120]:5380 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id <S281068AbRKYVcK>; Sun, 25 Nov 2001 16:32:10 -0500
Date: Sun, 25 Nov 2001 16:32:09 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
Message-Id: <200111252132.fAPLW9H02704@jik.kamens.brookline.ma.us>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111251617280.7477-100000@coffee.psychology.mcmaster.ca>
	(message from Mark Hahn on Sun, 25 Nov 2001 16:22:39 -0500 (EST))
Subject: Re: IDE: 2.2.19+IDE patches works fine; 2.4.x fails miserably; please
 help me figure out why!
In-Reply-To: <Pine.LNX.4.10.10111251617280.7477-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Responding to E-mail sent to me privately by Mark Hahn....)

>  > This clearly isn't a problem with my cables (and I've just wasted over
>  > $40 to prove it, unless I can convince Staples to take back the opened
>  > cables).
>  
>  are the cables 18"?  lots of places sell 24" cables, which have never
>  been valid...

No, both the new cables I put in and my old ones were 18" cables.

>  > If it's a problem with my drives, then how is it that I don't have any
>  > problems at all when I run 2.2.19+IDE on exactly the same hardware? 
>  
>  2.2 doesn't contain chipset-specific mode tuning code, afaik.
>  in general, it just uses the mode as programmed by the bios.

Perhaps I have not explained myself clearly enough, or perhaps my
understanding of what Andre's 2.2.x IDE patch is, is incorrect.

I am not using stock 2.2.  I am using 2.2 plus Andre Hedrick's IDE
backport patch.  I thought that the whole point of this patch was to
backport the enhanced IDE functionality from 2.4 back to 2.2.

Without Andre's patch, I wouldn't be able to send you the output of
/proc/ide/pdc202xx, because it wouldn't exist, because (as you point
out) there would be no code in the kernel specific to that chipset.
With the patch, there *is* code in the kernel specific to that
chipset.

>  > Bus Clocking                         : 33 PCI Internal
>  
>  my best theory is that this is wrong.  I assume you're not overclocking,
>  but have you scrutinized your bios settings?  the ide clock is usually
>  hung off the PCI clock, divided down from AGP, divided down from FSB.

This is all Greek to me.  Could you translate a bit for the
kernel-internals-impaired?  What should I be looking at/for, exactly?

>  wrong clocking (or the driver somehow using the wrong timing)
>  would explain both the messages you're seeing.

But the settings are the same as those used by 2.2.19+IDE, with which
I'm not having any problems.  Here's /proc/ide/pdc202xx when I'm
running 2.2.19+IDE:

                                PDC20262 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 15
Interrupt Check Status Polling Delay : 13
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          enabled 
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    yes              yes             yes               yes
DMA Mode:       UDMA 4           NOTSET          UDMA 4            NOTSET
PIO Mode:       PIO 4            NOTSET           PIO 4            NOTSET

Thanks,

  Jonathan Kamens
