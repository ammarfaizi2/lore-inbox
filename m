Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUKPBdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUKPBdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUKPBdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:33:23 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:46511 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261744AbUKPBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:33:18 -0500
Subject: Re: Linux 2.6.10-rc2
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Blazejowski <diffie@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Diffie <diffie@blazebox.homeip.net>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <9dda349204111512234f30c60d@mail.gmail.com>
References: <9dda349204111512234f30c60d@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 16:16:31 -0500
Message-Id: <1100553392.4369.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please report ALSA issues to alsa-devel@lists.sourceforge.net.  I have
added them to the cc:.

Lee

On Mon, 2004-11-15 at 15:23 -0500, Paul Blazejowski wrote:
> Starting up ut2004 or doom3 games produces ALSA segfaults, dmesg prints:
> 
> scheduling while atomic: ut2004-bin/0x00000001/8390
>  [<c0331508>] schedule+0x508/0x510
>  [<c03319a3>] schedule_timeout+0x63/0xc0
>  [<c0122c90>] process_timeout+0x0/0x10
>  [<c012306f>] msleep+0x2f/0x40
>  [<f8b9e02f>] snd_intel8x0_setup_pcm_out+0xbf/0x150 [snd_intel8x0]
>  [<f8b9e14c>] snd_intel8x0_pcm_prepare+0x8c/0xb0 [snd_intel8x0]
>  [<f8bfda84>] snd_pcm_do_prepare+0x14/0x40 [snd_pcm]
>  [<f8bfcdd8>] snd_pcm_action_single+0x38/0x80 [snd_pcm]
>  [<f8bfcfd0>] snd_pcm_action_nonatomic+0x80/0x90 [snd_pcm]
>  [<f8bfdb37>] snd_pcm_prepare+0x57/0x80 [snd_pcm]
>  [<f8c001b2>] snd_pcm_playback_ioctl1+0x52/0x310 [snd_pcm]
>  [<f8d25ae9>] snd_pcm_oss_poll+0x49/0x1a0 [snd_pcm_oss]
>  [<c016901a>] poll_freewait+0x3a/0x50
>  [<f8c00828>] snd_pcm_kernel_playback_ioctl+0x38/0x50 [snd_pcm]
>  [<f8d23026>] snd_pcm_oss_prepare+0x26/0x60 [snd_pcm_oss]
>  [<f8d2309d>] snd_pcm_oss_make_ready+0x3d/0x60 [snd_pcm_oss]
>  [<f8d2358d>] snd_pcm_oss_write1+0x3d/0x210 [snd_pcm_oss]
>  [<f8d259d0>] snd_pcm_oss_write+0x40/0x60 [snd_pcm_oss]
>  [<f8d25990>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
>  [<c01563e8>] vfs_write+0xb8/0x130
>  [<c0156531>] sys_write+0x51/0x80
>  [<c010317b>] syscall_call+0x7/0xb
> 
> .config attached
> 
> Regards,
> 
> Paul B.
-- 
Lee Revell <rlrevell@joe-job.com>

