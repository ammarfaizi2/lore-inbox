Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbVBQTRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbVBQTRA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVBQTP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:15:57 -0500
Received: from fsmlabs.com ([168.103.115.128]:55497 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262364AbVBQTPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:15:23 -0500
Date: Thu, 17 Feb 2005 12:16:13 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Joshua Kwan <joshk@triplehelix.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, hostap@shmoo.com
Subject: Re: 2.6.10: irq 12 nobody cared!
In-Reply-To: <4214EA6C.8040101@triplehelix.org>
Message-ID: <Pine.LNX.4.61.0502171215110.26742@montezuma.fsmlabs.com>
References: <4214450B.6090006@triplehelix.org>
 <Pine.LNX.4.61.0502170713110.26742@montezuma.fsmlabs.com>
 <4214EA6C.8040101@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005, Joshua Kwan wrote:

> Zwane Mwaikambo wrote:
> > Check that the hostap interrupt handler is 2.6 aware (IRQ_HANDLED etc)
> 
> It shows up even before the hostap module is loaded (and in fact appears
> to stop showing up when that happens.) Here's the full output of dmesg.

>  [<c012b574>] irq_exit+0x34/0x40
>  [<c0103d7d>] do_IRQ+0x3d/0x60
>  [<c010271a>] common_interrupt+0x1a/0x20
>  [<c012b914>] setup_irq+0x94/0x120
>  [<c01f20a0>] i8042_interrupt+0x0/0x180
>  [<c012baf2>] request_irq+0x72/0xa0
>  [<c03ab9a1>] i8042_check_aux+0x21/0x140
>  [<c01f20a0>] i8042_interrupt+0x0/0x180
>  [<c03abe78>] i8042_init+0xf8/0x180
>  [<c039c80b>] do_initcalls+0x2b/0xc0
>  [<c0100440>] init+0x0/0xe0
>  [<c0100467>] init+0x27/0xe0
>  [<c010084d>] kernel_thread_helper+0x5/0x18
> handlers:
> [<c01f20a0>] (i8042_interrupt+0x0/0x180)
> Disabling IRQ #12

Oh, KBC interrupt, can you track down which change in 2.6.10 induced that?
