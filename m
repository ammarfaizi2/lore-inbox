Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286332AbRLJRo5>; Mon, 10 Dec 2001 12:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286335AbRLJRor>; Mon, 10 Dec 2001 12:44:47 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S286332AbRLJRol>; Mon, 10 Dec 2001 12:44:41 -0500
Date: Mon, 10 Dec 2001 12:44:40 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Keith Warno <krjw@optonline.net>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16: scsi "PCI error Interrupt"?!
In-Reply-To: <Pine.LNX.4.40.0112101205560.6819-100000@behemoth.hobitch.com>
Message-ID: <Pine.LNX.3.95.1011210123827.517A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001, Keith Warno wrote:
[Snipped...]

> 
> Any ideas?  I really don't like the SCSI controller sharing an interrupt
> with anyone but I can't seem to force it to be in its own land.
> 

If the controller is a separate board, not built onto the motherboard,
move it to a different slot! There is only one interrupt line going
to each PCI slot. This should move the IRQ to something else.

In the same manner, if a board-mounted device is sharing an IRQ with
some slot device, move the slot device to another slot or swap it with
something that isn't using an interrupt.

Also, if your BIOS has an Y/N entry for (PnP OS), say "N". This
will force the BIOS to more-properly allocate resources. This gives
Linux at least a "correct" set-up to start with when it configures
the PCI interface.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


