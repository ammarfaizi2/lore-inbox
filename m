Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbTI1MxE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 08:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTI1MxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 08:53:04 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:35839 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262539AbTI1MxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 08:53:01 -0400
Date: Sun, 28 Sep 2003 14:52:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Oliver Pitzeier <oliver@linux-kernel.at>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.6.0-test6
In-Reply-To: <200309281216.h8SCGWsl026399@indianer.linux-kernel.at>
Message-ID: <Pine.GSO.4.21.0309281451160.7085-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003, Oliver Pitzeier wrote:
> Linus Torvalds wrote:
> > Ok, too long between test5 and test6 again, so the patch is 
> > pretty big. Lots of driver updates and architectures fixed, 
> > but also lots of merges from Andrew Morton. Most notably 
> > perhaps Con's scheduler changes that have been discussed 
> > extensively and made it into the -mm tree for testing.
> 
> It work's on my Intel machine, but on Alpha, I get this:
> <snip>
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o: In function `try_to_wake_up':
> kernel/built-in.o(.text+0x438): undefined reference to `sched_clock'
> kernel/built-in.o(.text+0x43c): undefined reference to `sched_clock'
> kernel/built-in.o: In function `schedule':
> kernel/built-in.o(.text+0x13e4): undefined reference to `sched_clock'
> kernel/built-in.o(.text+0x13ec): undefined reference to `sched_clock'
> kernel/built-in.o: In function `copy_process':
> kernel/built-in.o(.text+0x5014): undefined reference to `sched_clock'
> kernel/built-in.o(.text+0x503c): more undefined references to `sched_clock' follow

There's a new architecture-specific routine sched_clock() to be implemented
(which was BTW not announced on the secret all-architectures mail alias ;-).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

