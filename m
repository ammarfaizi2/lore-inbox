Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262390AbSI2Elv>; Sun, 29 Sep 2002 00:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262391AbSI2Elv>; Sun, 29 Sep 2002 00:41:51 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:56849 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262390AbSI2Elu>; Sun, 29 Sep 2002 00:41:50 -0400
Date: Sun, 29 Sep 2002 06:46:38 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.39, SMP, pre-empt: snd_ctl_iotcl 'sleeping function called from illegal context'
Message-ID: <20020929044638.GB739@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sleeping function called from illegal context at slab.c:1374
f6b6fbfc c0118554 c02df2e0 c02e3d90 0000055e f7b32390 c0135dd3 c02e3d90 
       0000055e 0000004c f7bafe08 f6b6fcec f7b32390 00000002 c1b0f3f0 c0254345 
       0000004c 000001d0 f7b32360 f6b6fcec c0255903 0000004c 000001d0 bffff628 
Call Trace:
 [<c0118554>]__might_sleep+0x54/0x58
 [<c0135dd3>]kmalloc+0x5b/0x1d4
 [<c0254345>]snd_kcalloc+0x11/0x38
 [<c0255903>]snd_ctl_notify+0xf3/0x1c0
 [<c02567f2>]snd_ctl_elem_write+0x17a/0x230
 [<c0256ce1>]snd_ctl_ioctl+0x175/0x310
 [<c01544e9>]sys_ioctl+0x28d/0x2dc
 [<c0107c5d>]error_code+0x2d/0x38
 [<c01071fb>]syscall_call+0x7/0xb

This is with an EMU10K1 card, and the ALSA drivers in the kernel.

Good luck,
Jurriaan
-- 
Once I lay hands on you, the issue is closed. Prepare to learn the full extent
of the infinite hereafter.
      Jack Vance - Lyonesse II - The Green Pearl
GNU/Linux 2.5.39 SMP/ReiserFS 2x1380 bogomips load av: 0.52 0.60 0.34
