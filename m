Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUBXXGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUBXXGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:06:13 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:55244 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262520AbUBXXGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:06:07 -0500
Date: Wed, 25 Feb 2004 00:06:03 +0100
From: Manuel Estrada Sainz <ranty@debian.org>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: firmware.agent Opps
Message-ID: <20040224230603.GB18091@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <20040224221900.GA5954@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040224221900.GA5954@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 02:19:01PM -0800, Jean Tourrilhes wrote:
> 	Hi,
> 
> 	Using 2.6.3 (SMP), prism54 driver and firmware.agent from
> Debian unstable. I got the following nice Ooops :

 [snip]

> kernel: Oops: 0000 [#1]
> kernel: CPU:    0
> kernel: EIP:    0060:[dnotify_flush+17/120]    Not tainted
> kernel: EFLAGS: 00010246
> kernel: EIP is at dnotify_flush+0x11/0x78
 [snip]
> kernel: Call Trace:
> kernel:  [filp_close+84/108] filp_close+0x54/0x6c
> kernel:  [sys_close+84/108] sys_close+0x54/0x6c
> kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> kernel: 
> kernel: Code: 0f b7 41 20 25 00 f0 ff ff 66 3d 00 40 75 54 b8 a4 06 29 c0 
> -----------------------------------------
> 
> 	If you think the driver is at fault, please tell me and I'll
> forward that to the prism54 guys. If you need more info, just yell at
> me.

 No, the driver is not at fault.

 It is a known problem, I have some pending patches which fix some races
 and should fix that. I´ll update them and send them to Andrew for
 inclusion (Simon Kelley promised to bug me until I do so :-)). I´ll cc
 lkml like usual.

 Thanks for the report,
 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
