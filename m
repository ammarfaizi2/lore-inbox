Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266434AbUGUEEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUGUEEu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 00:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUGUEEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 00:04:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:44447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266434AbUGUEEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 00:04:48 -0400
Date: Wed, 21 Jul 2004 00:03:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: mingo@elte.hu, linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040721000348.39dd3716.akpm@osdl.org>
In-Reply-To: <1090380467.1212.3.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
	<20040712163141.31ef1ad6.akpm@osdl.org>
	<1089677823.10777.64.camel@mindpipe>
	<20040712174639.38c7cf48.akpm@osdl.org>
	<20040719102954.GA5491@elte.hu>
	<1090380467.1212.3.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
>  discovered I can reliably produce a large XRUN by toggling Caps Lock, 
> Scroll Lock, or Num Lock.  This is with 2.6.8-rc1-mm1 + voluntary
> preempt

That's odd.  I wonder if the hardware is sick.  What is the duration is the
underrun?  The info you sent didn't include that.

> (I modified the patch by hand to apply on this kernel, as
> 2.6.8-rc2 disables my network card).

eh?  That's a rather more serious problem.  Does the via-rhine.c from
2.6.8-rc1-mm1 work OK if you move it into 2.6.8-rc2?


> 
> ALSA /home/rlrevell/cvs/alsa-driver/alsa-kernel/core/pcm_lib.c:169: XRUN: pcmC0D0p
>  [<c01066f7>] dump_stack+0x17/0x20
>  [<de952477>] snd_pcm_period_elapsed+0x2c7/0x400 [snd_pcm]
>  [<de962477>] snd_emu10k1_interrupt+0x337/0x3c0 [snd_emu10k1]
>  [<c0107913>] handle_IRQ_event+0x33/0x60
>  [<c0107c55>] do_IRQ+0xa5/0x170
>  [<c01062b8>] common_interrupt+0x18/0x20
>  [<c01d3f7f>] __delay+0xf/0x20
>  [<c021881a>] atkbd_sendbyte+0x5a/0xa0
>  [<c0218a35>] atkbd_command+0x1d5/0x200
>  [<c0218bcb>] atkbd_event+0x16b/0x200
>  [<c0215a95>] input_event+0x115/0x3d0
>  [<c01ecaeb>] kbd_bh+0xbb/0x160
>  [<c011a554>] tasklet_action+0x44/0x70
>  [<c011a303>] __do_softirq+0x83/0x90
>  [<c011a345>] do_softirq+0x35/0x40
>  [<c0107cc5>] do_IRQ+0x115/0x170
>  [<c01062b8>] common_interrupt+0x18/0x20
>  [<c014b95e>] sys_read+0x2e/0x50
