Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbSJ2Io4>; Tue, 29 Oct 2002 03:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSJ2Io4>; Tue, 29 Oct 2002 03:44:56 -0500
Received: from [212.3.242.3] ([212.3.242.3]:36081 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S261668AbSJ2Ioz>;
	Tue, 29 Oct 2002 03:44:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.5.44] 8250_cs does not work.
Date: Tue, 29 Oct 2002 09:51:14 +0100
User-Agent: KMail/1.4.3
References: <200210290908.49320.devilkin-lkml@blindguardian.org> <20021029082449.A17852@flint.arm.linux.org.uk>
In-Reply-To: <20021029082449.A17852@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210290938.45646.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 October 2002 09:24, Russell King wrote:
> On Tue, Oct 29, 2002 at 09:08:49AM +0100, DevilKin wrote:
> > Since I've started to test the 2.5 series, I've noticed that 8250_cs
> > doesn't really work - it doesn't detect my pcmcia card (psion global gold
> > card).
> >
> > I had a patch for 2.5.40 from Russell King that fixed it, but I can't get
> > it to apply to 2.5.44, and well - out of the box it still doesn't work.
> >
> > Is there any plan to get that fix in the kernel?
>
> The fix went in, so something else must have broken it.  There were some
> changes to the PCMCIA layer resource handling.  Please supply:
>
> 1. kernel messages
> 2. cardmgr-related messages from /var/log/messages
> 3. /proc/ioports
> 4. /proc/tty/driver/serial

Ah. Looks like I owe you an apology.

I hadn't rebooted after symlinking 8250_cs.o to serial_cs.o. I did a depmod 
-a, and then manually loaded the module - this caused it to not detect my 
serial pcmcia card.

Rebooting and getting it loaded through cardmgr does work. Odd. Anyway, I'm 
happy :oP

DK

-- 
"When you are in it up to your ears, keep your mouth shut."

