Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268490AbUI2PBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268490AbUI2PBJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 11:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268592AbUI2O54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:57:56 -0400
Received: from p5089E8E5.dip.t-dialin.net ([80.137.232.229]:3076 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S268490AbUI2O5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:57:09 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Date: Wed, 29 Sep 2004 16:57:06 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040929102840.GA11325@none> <200409291517.58750.petkov@uni-muenster.de> <21d7e9970409290649520a882c@mail.gmail.com>
In-Reply-To: <21d7e9970409290649520a882c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409291657.06174.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 15:49, Dave Airlie wrote:
> > do you mean the CONFIG_AGP_INTEL option? Because my chipset is ICH4 and
> > the help text for that option doesn't mention support for ICH4 chipsets.
>
> you have an i845 GMCH, so you need intel AGP support, the ICH4 is the
> other chip if I remember my Intel chipsets correctly...
>
> Dave.
Hmm,
compiled as you said, here's what i get now (pretty much the same oops):

Sep 29 16:51:08 zmei kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Sep 29 16:51:08 zmei kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Sep 29 16:51:08 zmei kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Sep 29 16:51:08 zmei kernel: [drm] Loading R200 Microcode
Sep 29 16:51:09 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2809
Sep 29 16:51:09 zmei kernel:  [dump_stack+23/27] dump_stack+0x17/0x1b
Sep 29 16:51:09 zmei kernel:  [smp_processor_id+146/152] smp_processor_id+0x92/0x98
Sep 29 16:51:09 zmei kernel:  [add_timer_randomness+274/313] add_timer_randomness+0x112/0x139
Sep 29 16:51:09 zmei kernel:  [input_event+72/940] input_event+0x48/0x3ac
Sep 29 16:51:09 zmei kernel:  [kbd_rate+76/156] kbd_rate+0x4c/0x9c
Sep 29 16:51:09 zmei kernel:  [vt_ioctl+3430/6535] vt_ioctl+0xd66/0x1987
Sep 29 16:51:09 zmei kernel:  [tty_ioctl+874/1075] tty_ioctl+0x36a/0x433
Sep 29 16:51:09 zmei kernel:  [sys_ioctl+196/511] sys_ioctl+0xc4/0x1ff
Sep 29 16:51:09 zmei kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 16:51:09 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2809
Sep 29 16:51:09 zmei kernel:  [dump_stack+23/27] dump_stack+0x17/0x1b
Sep 29 16:51:09 zmei kernel:  [smp_processor_id+146/152] smp_processor_id+0x92/0x98
Sep 29 16:51:09 zmei kernel:  [add_timer_randomness+274/313] add_timer_randomness+0x112/0x139
Sep 29 16:51:09 zmei kernel:  [input_event+72/940] input_event+0x48/0x3ac
Sep 29 16:51:09 zmei kernel:  [kbd_rate+103/156] kbd_rate+0x67/0x9c
Sep 29 16:51:09 zmei kernel:  [vt_ioctl+3430/6535] vt_ioctl+0xd66/0x1987
Sep 29 16:51:09 zmei kernel:  [tty_ioctl+874/1075] tty_ioctl+0x36a/0x433
Sep 29 16:51:09 zmei kernel:  [sys_ioctl+196/511] sys_ioctl+0xc4/0x1ff
Sep 29 16:51:09 zmei kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
