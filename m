Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTGHMCJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265166AbTGHMCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:02:09 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48850 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265144AbTGHMCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:02:07 -0400
Date: Tue, 8 Jul 2003 14:16:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: siimage, 2.5.74 and irq 19: nobody cared!
In-Reply-To: <bee8s6$jqf$1@news.cistron.nl>
Message-ID: <Pine.SOL.4.30.0307081414260.12802-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Please send dmesg from 2.5.62-mm2 and 'lspci -vvv' output.
--
Bartlomiej

On Tue, 8 Jul 2003, Miquel van Smoorenburg wrote:

> I was running 2.5.72-mm2 on our transit usenet news server
> (700 GB in/day and 1 TB out/day) which ran just fine, until I
> had some ext3 corruption on the /news partition. I remember
> having seen something about this in the -mm changelogs.
>
> So I tried 2.5.74 and 2.5.74-mm2, but with those kernels the
> siimage.c driver doesn't work. The card is detected, but a bit
> later in the boot process its IRQ is disabled and it won't work.
> Log is below. As said, it worked fine with 2.5.72-mm2 (OK, needed
> to enabled UDMA with hdparm, but other than that, no problems):
>
> Jul  8 12:23:09 quantum kernel: irq 19: nobody cared!
> Jul  8 12:23:09 quantum kernel: Call Trace:
> Jul  8 12:23:09 quantum kernel:  [__report_bad_irq+50/144] __report_bad_irq+0x32/0x90
> Jul  8 12:23:09 quantum kernel:  [note_interrupt+80/120] note_interrupt+0x50/0x78
> Jul  8 12:23:09 quantum kernel:  [do_IRQ+179/280] do_IRQ+0xb3/0x118
> Jul  8 12:23:09 quantum kernel:  [default_idle+0/52] default_idle+0x0/0x34
> Jul  8 12:23:09 quantum kernel:  [rest_init+0/72] _stext+0x0/0x48
> Jul  8 12:23:09 quantum kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> Jul  8 12:23:09 quantum kernel:  [default_idle+0/52] default_idle+0x0/0x34
> Jul  8 12:23:09 quantum kernel:  [rest_init+0/72] _stext+0x0/0x48
> Jul  8 12:23:09 quantum kernel:  [default_idle+41/52] default_idle+0x29/0x34
> Jul  8 12:23:09 quantum kernel:  [cpu_idle+55/72] cpu_idle+0x37/0x48
> Jul  8 12:23:09 quantum kernel:  [rest_init+69/72] _stext+0x45/0x48
> Jul  8 12:23:09 quantum kernel:  [start_kernel+322/328] start_kernel+0x142/0x148Jul  8 12:23:09 quantum kernel:
> Jul  8 12:23:09 quantum kernel: handlers:
> Jul  8 12:23:09 quantum kernel: [ide_intr+0/352] (ide_intr+0x0/0x160)
> Jul  8 12:23:09 quantum kernel: [ide_intr+0/352] (ide_intr+0x0/0x160)
> Jul  8 12:23:09 quantum kernel: Disabling IRQ #19
>
> Mike.

