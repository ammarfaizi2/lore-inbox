Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131559AbRCQGFu>; Sat, 17 Mar 2001 01:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbRCQGFk>; Sat, 17 Mar 2001 01:05:40 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:7831 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131554AbRCQGFe>; Sat, 17 Mar 2001 01:05:34 -0500
Date: Sat, 17 Mar 2001 01:05:51 -0500
From: "Michael B. Allen" <mballen@erols.com>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport not detected
Message-ID: <20010317010551.A1865@nano.foo.net>
In-Reply-To: <20010316185253.A865@nano.foo.net> <3AB2C527.667F774D@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AB2C527.667F774D@bigfoot.com>; from timothymoore@bigfoot.com on Fri, Mar 16, 2001 at 06:00:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yup!

nano kernel: parport0: PC-style at 0x378, irq 7 [SPP,PS2,EPP] 
nano kernel: parport0: Printer, Hewlett-Packard HP LaserJet 6L

I setup everything as you describe below. I don't remember having to
do all this stuff before(on other machines anyway). I guess I'm used to
RH's fluffed-up stock kernels.

Thanks,
Mike

On Fri, Mar 16, 2001 at 06:00:07PM -0800, Tim Moore wrote:
> > The parallel port is not being detected on my ABIT KT7A KT133 w/ Athlon
> 
> Also try comp.os.linux.hardware.
> 
> BIOS
> ----
> 278/irq5
> 378/irq7
> EPP 1.9
> 
> .config
> -------
> CONFIG_PARPORT=y
> CONFIG_PARPORT_PC=y
> CONFIG_PNP=y
> CONFIG_PNP_PARPORT=y
> CONFIG_PRINTER=y
> CONFIG_PRINTER_READBACK=y
> 
> kernal boot params
> ------------------
> append="parport=0x378,7 parport=0x278,5"
> 
> options for /etc/rc.d/rc.local
> ------------------------------
> # abort on error, careful error check, trust IRQ.
> # see tunelp(8) & /usr/src/linux/drivers/misc/lp.c
> 
> /usr/sbin/tunelp /dev/lp0 -a on -o on -T on
> /usr/sbin/tunelp /dev/lp1 -a on -o on -T on
> 
> looks like this (lp1 was powered down at boot time)
> 
> Feb 25 02:57:39 dell kernel: parport0: PC-style at 0x378, irq 7
> [SPP,PS2,EPP] 
> Feb 25 02:57:39 dell kernel: parport0: Printer, Hewlett-Packard HP
> LaserJet 1100 
> Feb 25 02:57:39 dell kernel: parport1: PC-style at 0x278, irq 5
> [SPP,PS2,EPP] 
> Feb 25 02:57:39 dell kernel: parport1: no IEEE-1284 device present. 
> Feb 25 02:57:40 dell kernel: lp0: using parport0 (interrupt-driven). 
> Feb 25 02:57:40 dell kernel: lp1: using parport1 (interrupt-driven). 
> 
> 
> --
