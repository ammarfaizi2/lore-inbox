Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261705AbTCNKEm>; Fri, 14 Mar 2003 05:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261715AbTCNKEm>; Fri, 14 Mar 2003 05:04:42 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:8924 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261705AbTCNKEl>;
	Fri, 14 Mar 2003 05:04:41 -0500
Date: Fri, 14 Mar 2003 11:14:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kendall Bennett <KendallB@scitechsoft.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: VESA FBconsole driver?
In-Reply-To: <3E70A68F.9422.AF1599@localhost>
Message-ID: <Pine.GSO.4.21.0303141114210.3569-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003, Kendall Bennett wrote:
> Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
> > Why you need it? To run some parts of VGA BIOS? Why you cannot run
> > them from userspace task? I think that it is much easier,
> > especially now when initramfs is here. 
> 
> The reason why it would nice is so that the VESA FBconsole driver (and in 
> fact all the FBconsole drivers that use the real mode BIOS to set an 
> initial display mode) can restore that mode correctly when an application 
> exists and restores the console. Right now it is up to the application 
> program to restore the console, as the kernel has absolutely no way to do 
> it. If that program has not way to restore it (old SVGALib code for 
> instance) or the application crashes, you are stuck with a black screen 
> if you are using a framebuffer console. If the kernel knew how to call 
> the BIOS to restore the mode, this problem could be completely eliminated 
> and services could be provided to properly restore the system state when 
> console graphics programs crash (or the X server for that matter if it 
> crashes and does not properly clean up).

Assumed the BIOS can recover from whatever the application has done to the
graphics chipset...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

