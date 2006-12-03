Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935790AbWLCK4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935790AbWLCK4n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 05:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935788AbWLCK4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 05:56:43 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:45758 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S935793AbWLCK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 05:56:42 -0500
Date: Sun, 3 Dec 2006 11:56:40 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Adrian Bunk <bunk@stusta.de>, Linux/m68k <linux-m68k@vger.kernel.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] cleanup asm/setup.h userspace visibility
In-Reply-To: <20061202180233.GA26111@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.62.0612031154220.20605@pademelon.sonytel.be>
References: <20061202175539.GV11084@stusta.de> <20061202180233.GA26111@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006, Russell King wrote:
> On Sat, Dec 02, 2006 at 06:55:39PM +0100, Adrian Bunk wrote:
> > This patch makes the contents of the userspace asm/setup.h header 
> > consistent on all architectures:
> > - export setup.h to userspace on all architectures
> > - export only COMMAND_LINE_SIZE to userspace
> 
> On ARM, all the ATAGs are exported to userspace because they are an API
> for boot loaders to use.  Everything down to the comment "Memory map
> description" should be exported.

Same for m68k: at least MACH_*, CPU*, MMU*, and FPU* are needed to compile
m68kboot.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
