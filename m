Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268802AbUI2Snf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268802AbUI2Snf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268803AbUI2Snf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:43:35 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22546 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268802AbUI2Sn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:43:29 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dave Airlie <airlied@gmail.com>, Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Date: Wed, 29 Sep 2004 21:43:18 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040929102840.GA11325@none> <21d7e99704092905284f48af35@mail.gmail.com>
In-Reply-To: <21d7e99704092905284f48af35@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409292143.18847.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 15:28, Dave Airlie wrote:
> It might help if you enabled AGP for your chipset, you have no agp
> compiled in for your Intel motherboard, you need intel agp chipset
> support..

However kernel shouldn't use using smp_processor_id() in preemptible
regions, with or without Intel AGP support compuled in.
 
> > Sep 29 12:03:07 zmei kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
> > Sep 29 12:03:07 zmei kernel: [drm:radeon_unlock] *ERROR* Process 2807 using kernel context 0
> > Sep 29 12:03:07 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2807
> > Sep 29 12:03:07 zmei kernel:  [dump_stack+23/27] dump_stack+0x17/0x1b
> > Sep 29 12:03:07 zmei kernel:  [smp_processor_id+146/152] smp_processor_id+0x92/0x98
> > Sep 29 12:03:07 zmei kernel:  [add_timer_randomness+274/313] add_timer_randomness+0x112/0x139
> > Sep 29 12:03:07 zmei kernel:  [input_event+72/940] input_event+0x48/0x3ac
> > Sep 29 12:03:07 zmei kernel:  [kbd_rate+76/156] kbd_rate+0x4c/0x9c
> > Sep 29 12:03:07 zmei kernel:  [vt_ioctl+3430/6535] vt_ioctl+0xd66/0x1987
> > Sep 29 12:03:07 zmei kernel:  [tty_ioctl+874/1075] tty_ioctl+0x36a/0x433
> > Sep 29 12:03:07 zmei kernel:  [sys_ioctl+196/511] sys_ioctl+0xc4/0x1ff
> > Sep 29 12:03:07 zmei kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> > Sep 29 12:03:07 zmei kernel: using smp_processor_id() in preemptible code: XFree86/2807
> > Sep 29 12:03:07 zmei kernel:  [dump_stack+23/27] dump_stack+0x17/0x1b
> > Sep 29 12:03:07 zmei kernel:  [smp_processor_id+146/152] smp_processor_id+0x92/0x98
> > Sep 29 12:03:07 zmei kernel:  [add_timer_randomness+274/313] add_timer_randomness+0x112/0x139
> > Sep 29 12:03:07 zmei kernel:  [input_event+72/940] input_event+0x48/0x3ac
> > Sep 29 12:03:07 zmei kernel:  [kbd_rate+103/156] kbd_rate+0x67/0x9c
> > Sep 29 12:03:07 zmei kernel:  [vt_ioctl+3430/6535] vt_ioctl+0xd66/0x1987
> > Sep 29 12:03:07 zmei kernel:  [tty_ioctl+874/1075] tty_ioctl+0x36a/0x433
> > Sep 29 12:03:07 zmei kernel:  [sys_ioctl+196/511] sys_ioctl+0xc4/0x1ff
> > Sep 29 12:03:07 zmei kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
--
vda

