Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263277AbSJJGwp>; Thu, 10 Oct 2002 02:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSJJGwp>; Thu, 10 Oct 2002 02:52:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:60319 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263277AbSJJGwn>;
	Thu, 10 Oct 2002 02:52:43 -0400
Date: Thu, 10 Oct 2002 08:58:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: Keyboard unuseable on laptop with current 2.5-BK  linux
Message-ID: <20021010085822.B7152@ucw.cz>
References: <15780.55615.361329.734899@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15780.55615.361329.734899@wombat.chubb.wattle.id.au>; from peter@chubb.wattle.id.au on Thu, Oct 10, 2002 at 11:34:55AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 11:34:55AM +1000, Peter Chubb wrote:
> 
> Hi,
> 	With the current BK linux, my AT keyboard and touchpad (PS/2
> emulation) are unuseable on my laptop.
> 
> The laptop uses an Intel 801 integrated controller.
> This is the log output on boot:
> 
> i8042.c: Detected active multiplexing controller,  rev-15.1.
> serio: i8042  port at 0x60,0x64 irq 12
> drivers/usb/host/uhci-hcd.c: 1800: suspend_hc
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> serio: i8042 AUX2 port at 0x60,0x64 irq 12
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> 
> but then keys pressed are totally bogus (e.g., 1234 generates ulkc;
> `a' generates a carriage return, etc.)
> 
> This worked with 2.5.40 vanilla, so it's a recent changeset that's
> caused the problem.

Please try passing the 'i8042_direct' parameter to the kernel. You're
the first to have a Multiplexing-controller compliant notebook this code
ever ran on (I don't have one). So there may be some bugs still. I see
one right in the dmesg (missing AUX0 in the first line).

-- 
Vojtech Pavlik
SuSE Labs
