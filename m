Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269403AbUINMkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269403AbUINMkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUINMd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:33:26 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:35153 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S269390AbUINM2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:28:13 -0400
Date: Tue, 14 Sep 2004 14:27:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: notify_parent (was: Re: Linux 2.6.9-rc2)
In-Reply-To: <Pine.GSO.4.58.0409141420570.9444@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0409141425360.8147@anakin>
References: <Pine.GSO.4.58.0409141420570.9444@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Linus Torvalds wrote:
> Roland McGrath:
>   o cleanup ptrace stops and remove notify_parent

However, there are still a few users of notify_parent():

| arch/m68k/kernel/signal.c:			notify_parent(current, SIGCHLD);
| arch/m68k/kernel/signal.c:					notify_parent(current, SIGCHLD);
| arch/ia64/kernel/signal.c:		 * get_signal_to_deliver() may have run a debugger (via notify_parent())
| arch/parisc/kernel/ptrace.c:			//notify_parent(child, SIGCHLD);
| arch/m68knommu/kernel/signal.c:			notify_parent(current, SIGCHLD);
| arch/m68knommu/kernel/signal.c:					notify_parent(current, SIGCHLD);
| arch/h8300/kernel/signal.c:			notify_parent(current, SIGCHLD);
| arch/h8300/kernel/signal.c:                                        notify_parent(current, SIGCHLD);

Any suggestion how to convert them?

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
