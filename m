Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSKVS0H>; Fri, 22 Nov 2002 13:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265190AbSKVS0G>; Fri, 22 Nov 2002 13:26:06 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:61567 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S265180AbSKVS0G> convert rfc822-to-8bit; Fri, 22 Nov 2002 13:26:06 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org, perex@perex.cz
Subject: sleeping function called from illegal context at mm/slab.c:1304
Date: Fri, 22 Nov 2002 19:33:22 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211221933.22395.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

this is with 2.5.48 (and several kernels before).

Best regards,
Michael




Debug: sleeping function called from illegal context at mm/slab.c:1304
kernel: Call Trace:
kernel:  [__might_sleep+84/96] __might_sleep+0x54/0x60
kernel:  [kmem_flagcheck+30/80] kmem_flagcheck+0x1e/0x50
kernel:  [kmalloc+75/288] kmalloc+0x4b/0x120
kernel:  [<e08a80bb>] build_via_table+0x5b/0x190 [snd-via82xx]
kernel:  [__delay+19/48] __delay+0x13/0x30
kernel:  [<e08a858e>] snd_via82xx_setup_periods+0x2e/0x130 [snd-via82xx]
kernel:  [<e08a888e>] snd_via82xx_playback_prepare+0x7e/0x90 
[snd-via82xx]
kernel:  [<e0897ed1>] snd_pcm_prepare+0x21/0x210 [snd-pcm]
kernel:  [<e0897fd9>] snd_pcm_prepare+0x129/0x210 [snd-pcm]
kernel:  [<e0899ce6>] snd_pcm_common_ioctl1+0x1d6/0x2b0 [snd-pcm]
kernel:  [<e089a05e>] snd_pcm_playback_ioctl1+0x29e/0x2b0 [snd-pcm]
kernel:  [<e089a300>] snd_pcm_playback_ioctl+0x20/0x30 [snd-pcm]
kernel:  [sys_ioctl+537/624] sys_ioctl+0x219/0x270
kernel:  [error_code+45/56] error_code+0x2d/0x38
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

