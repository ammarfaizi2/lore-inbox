Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFPFTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 01:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFPFTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 01:19:42 -0400
Received: from mailg.telia.com ([194.22.194.26]:63704 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id S263354AbTFPFTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 01:19:34 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: presario laptop and 2.5.71
References: <Pine.LNX.4.44.0306151511290.1056-100000@lap.molina>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jun 2003 07:33:18 +0200
In-Reply-To: <Pine.LNX.4.44.0306151511290.1056-100000@lap.molina>
Message-ID: <m2llw2lh7l.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cox.net> writes:

> I have two problems with 2.5.71 and my Presario 12XL325 laptop.  
> 
> Problem one is that my synaptics mousepad does not work.  Previously, it 
> was recognized as a PS/2 device.  With this kernel I get nothing.  I am 
> including my configuration.  I've tried with the synaptics-specific driver 
> loaded as well as simply just using the generic ps/2 support which has 
> worked in the past.
> 
> The second problem is that the yenta module is not auto loaded with this 
> kernel.  Doing a modprobe yenta brings the pcmcia ethernet card to life, 
> but it is aggravating.  
> 
> The last kernel I tried (which worked) was 2.5.70-bk as of June 07.
> 
> Relevant dmeg extract from this kernel (2.5.70-0607) is:
> 
> Jun 15 14:58:13 lap kernel: mice: PS/2 mouse device common for all mice
> Jun 15 14:58:13 lap kernel: input: PS/2 Synaptics TouchPad on 
> isa0060/serio1
> Jun 15 14:58:13 lap kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> Jun 15 14:58:13 lap kernel: input: AT Set 2 keyboard on isa0060/serio0
> Jun 15 14:58:13 lap kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> Relevant dmesg extract from 2.5.71 is:
> (Note:  This is 2.5.71 with plain PS/2 configured.  The only difference in 
> dmesg output when the new synaptics support is compile in is that the 
> "synaptics reset failed" message does not appear in the latter case.)

I think this is some kind of build problem. The messages you quote
should not even be compiled into the kernel if you disable
CONFIG_MOUSE_PS2_SYNAPTICS in the kernel configuration.

Also note that this driver needs user space support, see:

        http://w1.894.telia.com/~u89404340/touchpad/index.html

Also make sure the evdev module is loaded.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
