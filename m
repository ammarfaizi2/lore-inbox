Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUCMMKg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 07:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUCMMKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 07:10:33 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:31444 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263081AbUCMMKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 07:10:31 -0500
Date: Sat, 13 Mar 2004 13:10:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.4 - powerbook 15" - usb oops+backtrace
Message-ID: <20040313121027.GA7434@ucw.cz>
References: <1079097936.1837.102.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079097936.1837.102.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 02:25:36PM +0100, Soeren Sonnenburg wrote:
> Hi!
> 
> I got this oops when inserting mouse/keyboard (both usb).
> 
> usb 1-1: new low speed USB device using address 4
> input: USB HID v1.00 Mouse [Cypress Sem USB Mouse] on usb-0001:01:18.0-1
> Oops: kernel access of bad area, sig: 11 [#1]
> NIP: 5A5A5A58 LR: C026D8B0 SP: ED6B1E10 REGS: ed6b1d60 TRAP: 0401    Not
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
 
Is this reproducible, or does it happen only rarely? I suspect it could
be a race somewhere ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
