Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUKOHZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUKOHZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 02:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbUKOHZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 02:25:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:19404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261504AbUKOHZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 02:25:41 -0500
Date: Sun, 14 Nov 2004 23:25:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2 doesn't boot
Message-Id: <20041114232523.2d157f22.akpm@osdl.org>
In-Reply-To: <20041115040710.GA2235@stusta.de>
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
	<20041115040710.GA2235@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> 2.6.10-rc2 doesn't boot.
> 
>  It stops at the following place (from a 2.6.10-rc1-mm5 log):
> 
>  <--  snip  -->
> 
>  ...
>  ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
>  ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
>  ACPI: PS/2 Mouse Controller [PS2M] at irq 12
>  serio: i8042 AUX port at 0x60,0x64 irq 12
>  serio: i8042 KBD port at 0x60,0x64 irq 1
>  Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing 
>  disabled
>  ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>  parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
>  parport0: irq 7 detected
>  lp0: using parport0 (polling).
>  io scheduler noop registered
>  io scheduler anticipatory registered
>  io scheduler deadline registered
>  io scheduler cfq registered
> 
> 
>  ---->  2.6.10-rc2 stops here
> 
> 
>  loop: loaded (max 8 devices)

Suggest you add initcall_debug to the kernel boot command line so we can
see which subsystem is causing the hang.
