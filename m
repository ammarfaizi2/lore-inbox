Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUBHLkW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 06:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUBHLkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 06:40:22 -0500
Received: from demotivation.org ([150.101.226.158]:51876 "EHLO
	shenthet.demotivation.org") by vger.kernel.org with ESMTP
	id S263475AbUBHLkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 06:40:18 -0500
Date: Sun, 8 Feb 2004 22:21:12 +1030
From: hedj@ares.demotivation.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 ALSA problems
Message-ID: <20040208115112.GA14500@ares.demotivation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 2.6.2 ( but not under 2.6.1 ) , I get a lot of this type of thing
in the logs:
Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c011cd81>] __might_sleep+0xab/0xc9
 [<c03267fd>] ap_cs8427_sendbytes+0x3b/0xce
 [<c031ae57>] snd_i2c_sendbytes+0x22/0x26
 [<c0319e88>] snd_cs8427_reg_write+0x36/0x73
 [<c031a47d>] snd_cs8427_reset+0x4f/0x1d7
 [<c031ab7f>] snd_cs8427_iec958_pcm+0xe5/0x162
 [<c0323d03>] snd_ice1712_playback_pro_hw_params+0x73/0x75
 [<c02f8890>] snd_pcm_hw_params+0x263/0x28f
 [<c02f8943>] snd_pcm_hw_params_user+0x87/0xf4
 [<c02fc548>] snd_pcm_playback_ioctl1+0x5e/0x4b2
 [<c0165e79>] sys_ioctl+0x119/0x298
 [<c0109225>] sysenter_past_esp+0x52/0x71

This also seems to produce rather bad noises....

Cheers,
John Hedditch
