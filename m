Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129501AbQKOVeW>; Wed, 15 Nov 2000 16:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbQKOVeM>; Wed, 15 Nov 2000 16:34:12 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3844 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129880AbQKOVdy>;
	Wed, 15 Nov 2000 16:33:54 -0500
Message-ID: <20001114222240.A1537@bug.ucw.cz>
Date: Tue, 14 Nov 2000 22:22:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <8uhps8$1tm$1@cesium.transmeta.com>; from H. Peter Anvin on Fri, Nov 10, 2000 at 01:38:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Sensibly configured power saving/speed throttle systems do not change the
> > > frequency at all. The duty cycle is changed and this controls the cpu 
> > > performance but the tsc is constant
> > 
> > Do you have an example of notebook that does powersaving like that?
> > I have 2 examples of notebooks with changing TSC speed...
> > 
> 
> Intel PIIX-based systems will do duty-cycle throttling, for example.

Don't think so. My toshiba is PIIX-based, AFAIC:

root@bug:~# cat /proc/pci
  Bus  0, device   5, function  0:
    Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   5, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.
      I/O at 0x1000 [0x100f].
  Bus  0, device   5, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.
      I/O at 0xffe0 [0xffff].
  Bus  0, device   5, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).

Still, it is willing to run with RDTSC at 300MHz, 150MHz, and
40MHz. (The last one in _extreme_ cases when CPU fan fails -- running
at 40MHz is better than cooking cpu).


-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
