Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267482AbUHJQDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267482AbUHJQDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267485AbUHJQDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:03:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63211 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267482AbUHJQDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:03:11 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810124020.GA18904@elte.hu>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <20040810085849.GC26081@elte.hu> <20040810092249.GA29875@elte.hu>
	 <1092137588.16885.4.camel@localhost.localdomain>
	 <20040810124020.GA18904@elte.hu>
Content-Type: text/plain
Message-Id: <1092153809.10794.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 12:03:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 08:40, Ingo Molnar wrote:

> it's a 10 msec latency that got measured, for a single page copy (!) -
> if it's memory latency then it must be something really bad...
> 

Here's another one that I have seen a few times.

(gnome-terminal/850): 15487us non-preemptible critical section violated 1100 us preempt threshold starting at add_wait_queue+0x15/0x50 and ending at add_wait_queue+0x2c/0x50
 [<c0106717>] dump_stack+0x17/0x20
 [<c0113eec>] dec_preempt_count+0x3c/0x50
 [<c011406c>] add_wait_queue+0x2c/0x50
 [<c01e334d>] normal_poll+0x3d/0x177
 [<c01df281>] tty_poll+0x61/0x80
 [<c015f0a1>] do_pollfd+0x91/0xa0
 [<c015f10f>] do_poll+0x5f/0xc0
 [<c015f2a1>] sys_poll+0x131/0x220
 [<c01060b7>] syscall_call+0x7/0xb
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/pcm_lib.c:139: XRUN: pcmC0D2c
 [<c0106717>] dump_stack+0x17/0x20
 [<de93d64b>] snd_pcm_period_elapsed+0x27b/0x3e0 [snd_pcm]
 [<de9791d1>] snd_emu10k1_interrupt+0xd1/0x3c0 [snd_emu10k1]
 [<c011a7d3>] generic_handle_IRQ_event+0x33/0x60
 [<c01079c2>] do_IRQ+0xb2/0x180
 [<c01062d8>] common_interrupt+0x18/0x20
 [<c015f0a1>] do_pollfd+0x91/0xa0
 [<c015f10f>] do_poll+0x5f/0xc0
 [<c015f2a1>] sys_poll+0x131/0x220
 [<c01060b7>] syscall_call+0x7/0xb

Lee



