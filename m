Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUCMA2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUCMA2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:28:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:52952 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262721AbUCMA2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:28:50 -0500
Subject: Re: 2.6.4 - powerbook 15" - usb oops+backtrace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1079097936.1837.102.camel@localhost>
References: <1079097936.1837.102.camel@localhost>
Content-Type: text/plain
Message-Id: <1079137438.1960.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 11:23:59 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 00:25, Soeren Sonnenburg wrote:
> Hi!
> 
> I got this oops when inserting mouse/keyboard (both usb).
> 
> usb 1-1: new low speed USB device using address 4
> input: USB HID v1.00 Mouse [Cypress Sem USB Mouse] on usb-0001:01:18.0-1
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: 5A5A5A58 LR: C026D8B0 SP: ED6B1E10 REGS: ed6b1d60 TRAP: 0401    Not

NIP is the program counter, something tried to jump into nowhereland,
find out who by looking at who "owns" C026D8B0 in System.map

> tainted
> MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = edb87320[1332] 'pbbuttonsd' Last syscall: 5 
> GPR00: 5A5A5A5A ED6B1E10 EDB87320 C1991894 E2DB789C 00000000 E7909300
> ED6B1DC0 
> GPR08: 00000000 00000000 C03DA5A0 00000005 84000428 
> Call trace:
>  [c02704ac] evdev_open+0x64/0x104
>  [c026e814] input_open_file+0x98/0x1cc
>  [c00675a8] chrdev_open+0xe0/0x16c
>  [c005c0b4] dentry_open+0x15c/0x230
>  [c005bf54] filp_open+0x64/0x68
>  [c005c43c] sys_open+0x68/0xa0
>  [c0005d3c] ret_from_syscall+0x0/0x44
> usb 2-1: new low speed USB device using address 4
> input: USB HID v1.00 Keyboard [PTC HID PS/2 Keyboard - PS/2 Mouse] on
> usb-0001:01:19.0-1
> input: USB HID v1.00 Mouse [PTC HID PS/2 Keyboard - PS/2 Mouse] on
> usb-0001:01:19.0-1
> 
> Thanks for any suggestions...
> 
> I can probably give more infos as xmon is compiled in the kernel here.
> 
> Thanks in advance,
> Soeren.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

