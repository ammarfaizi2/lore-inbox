Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUGMEAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUGMEAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 00:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUGMEAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 00:00:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:58503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264595AbUGMEAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 00:00:39 -0400
Date: Mon, 12 Jul 2004 20:59:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040712205917.47d1d58b.akpm@osdl.org>
In-Reply-To: <1089687168.10777.126.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<1089687168.10777.126.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> Here are a few more:
> 
>  Jul 12 22:20:41 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  Jul 12 22:20:41 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
>  Jul 12 22:20:41 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
>  Jul 12 22:20:41 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
>  Jul 12 22:20:41 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
>  Jul 12 22:20:41 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
>  Jul 12 22:20:41 mindpipe kernel:  [unix_stream_recvmsg+135/1088] unix_stream_recvmsg+0x87/0x440
>  Jul 12 22:20:41 mindpipe kernel:  [avc_has_perm+72/96] avc_has_perm+0x48/0x60
>  Jul 12 22:20:41 mindpipe kernel:  [sock_aio_read+155/176] sock_aio_read+0x9b/0xb0
>  Jul 12 22:20:41 mindpipe kernel:  [do_sync_read+125/192] do_sync_read+0x7d/0xc0
>  Jul 12 22:20:41 mindpipe kernel:  [do_select+435/752] do_select+0x1b3/0x2f0
>  Jul 12 22:20:41 mindpipe kernel:  [vfs_read+223/256] vfs_read+0xdf/0x100
>  Jul 12 22:20:42 mindpipe kernel:  [sys_read+45/80] sys_read+0x2d/0x50
>  Jul 12 22:20:42 mindpipe kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
>  Jul 12 22:20:42 mindpipe kernel:
>  Jul 12 22:20:44 mindpipe kernel: ALSA /usr/src/alsa-cvs-1.0.5/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  Jul 12 22:20:44 mindpipe kernel:  [__crc_totalram_pages+1387264/5353478] snd_pcm_period_elapsed+0x2ca/0x410 [snd_pcm]
>  Jul 12 22:20:44 mindpipe kernel:  [__crc_totalram_pages+1455070/5353478] snd_emu10k1_interrupt+0x3c8/0x480 [snd_emu10k1]
>  Jul 12 22:20:44 mindpipe kernel:  [handle_IRQ_event+49/96] handle_IRQ_event+0x31/0x60
>  Jul 12 22:20:44 mindpipe kernel:  [do_IRQ+155/352] do_IRQ+0x9b/0x160
>  Jul 12 22:20:44 mindpipe kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20

Oh dear, these don't make much sense.

You'll have the best chance of getting decent traces with
CONFIG_FRAME_POINTER=y and CONFIG_4KSTACKS=n, but I'm not sure that this
will help a lot.  Are you sure that CONFIG_PREEMPT is enabled on that
kernel?

