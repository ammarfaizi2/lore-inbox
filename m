Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUGNPYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUGNPYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUGNPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:24:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56045 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267403AbUGNPY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:24:28 -0400
Subject: Re: XRUN traces
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713235655.263ce5f3.akpm@osdl.org>
References: <1089758294.2747.4.camel@mindpipe>
	 <20040713161004.37a4654e.akpm@osdl.org> <1089787542.3360.11.camel@mindpipe>
	 <20040713235655.263ce5f3.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089818669.2789.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Jul 2004 11:24:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few new ones:

Jul 14 10:39:20 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 14 10:39:20 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 10:39:20 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 10:39:20 mindpipe kernel:  [__crc_totalram_pages+705405/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 10:39:20 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 10:39:20 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 10:39:20 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:39:20 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 14 10:39:20 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 14 10:39:20 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 14 10:39:20 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:39:20 mindpipe kernel:  [sock_alloc_send_pskb+184/464] sock_alloc_send_pskb+0xb8/0x1d0
Jul 14 10:39:20 mindpipe kernel:  [sock_alloc_send_skb+26/32] sock_alloc_send_skb+0x1a/0x20
Jul 14 10:39:20 mindpipe kernel:  [unix_stream_sendmsg+387/976] unix_stream_sendmsg+0x183/0x3d0
Jul 14 10:39:20 mindpipe kernel:  [sock_sendmsg+129/176] sock_sendmsg+0x81/0xb0
Jul 14 10:39:20 mindpipe kernel:  [sock_readv_writev+101/144] sock_readv_writev+0x65/0x90
Jul 14 10:39:20 mindpipe kernel:  [sock_writev+59/80] sock_writev+0x3b/0x50
Jul 14 10:39:20 mindpipe kernel:  [do_readv_writev+504/592] do_readv_writev+0x1f8/0x250
Jul 14 10:39:20 mindpipe kernel:  [vfs_writev+68/80] vfs_writev+0x44/0x50
Jul 14 10:39:20 mindpipe kernel:  [sys_writev+46/80] sys_writev+0x2e/0x50
Jul 14 10:39:20 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Jul 14 10:41:59 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 14 10:41:59 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 10:41:59 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 10:41:59 mindpipe kernel:  [__crc_totalram_pages+705405/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 10:41:59 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 10:41:59 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 10:41:59 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:41:59 mindpipe kernel:  [send_group_sig_info+32/64] send_group_sig_info+0x20/0x40
Jul 14 10:41:59 mindpipe kernel:  [it_real_fn+17/96] it_real_fn+0x11/0x60
Jul 14 10:41:59 mindpipe kernel:  [run_timer_softirq+204/416] run_timer_softirq+0xcc/0x1a0
Jul 14 10:41:59 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 14 10:41:59 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 14 10:41:59 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 14 10:41:59 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:41:59 mindpipe kernel: 

Jul 14 10:41:59 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 14 10:41:59 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 10:41:59 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 10:41:59 mindpipe kernel:  [__crc_totalram_pages+705405/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 10:41:59 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 10:41:59 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 10:41:59 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:41:59 mindpipe kernel:  [poll_freewait+68/80] poll_freewait+0x44/0x50
Jul 14 10:41:59 mindpipe kernel:  [sys_poll+472/544] sys_poll+0x1d8/0x220
Jul 14 10:41:59 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Jul 14 10:42:00 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 14 10:42:00 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 10:42:00 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 10:42:00 mindpipe kernel:  [__crc_totalram_pages+704791/3558647] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 14 10:42:00 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 10:42:00 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 10:42:00 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:42:00 mindpipe kernel:  [do_anonymous_page+124/384] do_anonymous_page+0x7c/0x180
Jul 14 10:42:00 mindpipe kernel:  [do_no_page+78/784] do_no_page+0x4e/0x310
Jul 14 10:42:00 mindpipe kernel:  [handle_mm_fault+193/368] handle_mm_fault+0xc1/0x170
Jul 14 10:42:00 mindpipe kernel:  [do_page_fault+805/1356] do_page_fault+0x325/0x54c
Jul 14 10:42:00 mindpipe kernel:  [error_code+45/64] error_code+0x2d/0x40

Jul 14 10:57:36 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
Jul 14 10:57:36 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 10:57:36 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 10:57:36 mindpipe kernel:  [__crc_totalram_pages+705405/3558647] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
Jul 14 10:57:36 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 10:57:36 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 10:57:36 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 10:57:36 mindpipe kernel:  [__crc_totalram_pages+617342/3558647] snd_pcm_common_ioctl1+0x168/0x300 [snd_pcm]
Jul 14 10:57:36 mindpipe kernel:  [__crc_totalram_pages+618749/3558647] snd_pcm_capture_ioctl1+0x47/0x330 [snd_pcm]
Jul 14 10:57:36 mindpipe kernel:  [sys_ioctl+256/608] sys_ioctl+0x100/0x260
Jul 14 10:57:36 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Jul 14 11:11:08 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 14 11:11:08 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 11:11:08 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 11:11:08 mindpipe kernel:  [__crc_totalram_pages+704791/3558647] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 14 11:11:08 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 11:11:08 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 11:11:08 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 11:11:08 mindpipe kernel:  [poll_freewait+46/80] poll_freewait+0x2e/0x50
Jul 14 11:11:08 mindpipe kernel:  [sys_poll+472/544] sys_poll+0x1d8/0x220
Jul 14 11:11:08 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Jul 14 11:11:16 mindpipe kernel: ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D2c
Jul 14 11:11:16 mindpipe kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Jul 14 11:11:16 mindpipe kernel:  [__crc_totalram_pages+639837/3558647] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
Jul 14 11:11:16 mindpipe kernel:  [__crc_totalram_pages+704791/3558647] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
Jul 14 11:11:16 mindpipe kernel:  [handle_IRQ_event+51/96] handle_IRQ_event+0x33/0x60
Jul 14 11:11:16 mindpipe kernel:  [do_IRQ+165/368] do_IRQ+0xa5/0x170
Jul 14 11:11:16 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Jul 14 11:11:16 mindpipe kernel:  [i8042_timer_func+14/32] i8042_timer_func+0xe/0x20
Jul 14 11:11:16 mindpipe kernel:  [run_timer_softirq+204/416] run_timer_softirq+0xcc/0x1a0
Jul 14 11:11:16 mindpipe kernel:  [__do_softirq+131/144] __do_softirq+0x83/0x90
Jul 14 11:11:16 mindpipe kernel:  [do_softirq+53/64] do_softirq+0x35/0x40
Jul 14 11:11:16 mindpipe kernel:  [do_IRQ+277/368] do_IRQ+0x115/0x170
Jul 14 11:11:16 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20

Lee

