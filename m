Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUBJWpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUBJWpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:45:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:64657 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261890AbUBJWpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:45:09 -0500
Subject: Re: ieee1394 and fbdev oops in 2.6.3rc2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040210165202.GA7590@suse.de>
References: <20040210165202.GA7590@suse.de>
Content-Type: text/plain
Message-Id: <1076453077.2285.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 11 Feb 2004 09:44:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-11 at 03:52, Olaf Hering wrote:

> NIP: C0101000 LR: C0100F90 SP: EF185CF0 REGS: ef185c40 TRAP: 0700    Not tainted
> MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = ef1938a0[4325] 'X' Last syscall: 54 
> GPR00: 00000002 EF185CF0 EF1938A0 EFFA3C00 EF185CF8 00000000 EF185D94 00000000 
> GPR08: 00000000 FFFFFF00 00000001 00000000 28004884 101E6A58 101EEE08 101EED88 
> GPR16: 101EF108 101EEF88 101EEE08 7FFFF438 101ECCF8 101E0000 101E0000 101E0000 
> GPR24: 00000001 C02EBA40 000000A0 00000040 00000400 00000010 EFFA3C00 00000008 
> Call trace:
>  [<c01011ac>] fbcon_switch+0x11c/0x288
>  [<c00c56c4>] redraw_screen+0x1c0/0x22c
>  [<c00c027c>] complete_change_console+0x44/0xf8
>  [<c00bfa34>] vt_ioctl+0x16c0/0x1d60
>  [<c00b8604>] tty_ioctl+0x160/0x5d4
>  [<c006c51c>] sys_ioctl+0xdc/0x2fc
>  [<c0007c7c>] ret_from_syscall+0x0/0x44

Can you check the value of NIP in System.map ? May it be accel_clear_margins ?

In this case, james, it's the same crash I saw for ages occasionally when
using stty. Something doggy is happening in there.

Olaf, is it 100% reproduceable ?

Ben.



