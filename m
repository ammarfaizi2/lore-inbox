Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbULUHyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbULUHyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 02:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULUHyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 02:54:12 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:61847 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261585AbULUHyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 02:54:07 -0500
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Dec 2004 08:53:41 +0100
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2004.12.21.07.53.37.708238@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: <1103389648.5967.7.camel@gaston>
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 17:07:28 +0000, Benjamin Herrenschmidt wrote:

> Hi Takashi !
> 
> I get that regulary with latest kernel when using Alsa. Can't tell if it's new
> as I used dmasound so far, just wanted to give Alsa a try...
> 
> Ben.
> 
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: 00000000 LR: C278B664 SP: BA901DB0 REGS: ba901d00 TRAP: 0400    Not tainted
> MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = bf4ef2a0[4821] 'gtkpbbuttons' THREAD: ba900000
> Last syscall: 4
> GPR00: 00000000 BA901DB0 BF4EF2A0 C2231000 00000FD7 00000000 00000000 C2550000
> GPR08: C2231000 C2550000 00000001 00000000 00000001 1002317C 100C0000 100A0000
> GPR16: 00000000 0022E480 00004002 00000000 00000000 00000800 BF384460 BB52A260
> GPR24: 00000000 00000FD8 00000000 00000000 BAAE36AC BAAE3690 BAAE3620 00000800
> NIP [00000000] 0x0
> LR [c278b664] rate_transfer+0x80/0x88 [snd_pcm_oss]
> Call trace:
>  [c278b664] rate_transfer+0x80/0x88 [snd_pcm_oss]
>  [c278853c] snd_pcm_plug_write_transfer+0xd4/0x14c [snd_pcm_oss]
>  [c2783520] snd_pcm_oss_write2+0xb0/0x128 [snd_pcm_oss]
>  [c27837b8] snd_pcm_oss_write1+0x220/0x26c [snd_pcm_oss]
>  [c2785fec] snd_pcm_oss_write+0x64/0xb4 [snd_pcm_oss]
>  [8005c620] vfs_write+0xdc/0x128
>  [8005c750] sys_write+0x50/0x94
>  [800042e0] ret_from_syscall+0x0/0x44
> benh@gaston:~$

I also get the very same oops - though very rarely - with pbbuttons and
kernel 2.6.9 on my 1GHz-pbook 15"

However I am not 100% sure whether this is 2.6.9 + alsa from sid or
vanilla 2.6.9...

Soeren



