Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267212AbUGMXG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267212AbUGMXG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUGMXG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:06:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:26832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267212AbUGMXG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:06:57 -0400
Date: Tue, 13 Jul 2004 16:10:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XRUN traces
Message-Id: <20040713161004.37a4654e.akpm@osdl.org>
In-Reply-To: <1089758294.2747.4.camel@mindpipe>
References: <1089758294.2747.4.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> This one is 100% reproducible, happens immediately when I start JACK.  I
> have set CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n as you requested.
> 
> Jul 13 18:30:21 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
> Jul 13 18:30:21 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
> Jul 13 18:30:21 mindpipe kernel:  [__crc_totalram_pages+1279533/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
> Jul 13 18:30:21 mindpipe kernel:  [__crc_totalram_pages+1463213/3558647] snd_emu10k1_interrupt+0x377/0x400 [snd_emu10k1]
> Jul 13 18:30:21 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
> Jul 13 18:30:21 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
> Jul 13 18:30:21 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> Jul 13 18:30:21 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
> Jul 13 18:30:21 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
> Jul 13 18:30:21 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
> Jul 13 18:30:21 mindpipe kernel:  [get_user_pages+258/880] get_user_pages+0x102/0x370

OK, I'll fix get_user_pages().
