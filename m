Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRCIPbg>; Fri, 9 Mar 2001 10:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130533AbRCIPb1>; Fri, 9 Mar 2001 10:31:27 -0500
Received: from [212.183.11.206] ([212.183.11.206]:5395 "EHLO
	grips_nts2.grips.com") by vger.kernel.org with ESMTP
	id <S130532AbRCIPbT>; Fri, 9 Mar 2001 10:31:19 -0500
Message-ID: <3AA8F713.367A5FFD@grips.com>
Date: Fri, 09 Mar 2001 16:30:27 +0100
From: jury gerold <gjury@grips.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: de-AT, en
MIME-Version: 1.0
To: Will Newton <will@misconception.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: ES1371 driver in kernel 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103082255560.11750-100000@dogfox.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am facing the same trouble but in my case
the parallel printer driver complains about a possible
interrupt sharing problem because i run it on interrupt 7.

The alsa driver however works pretty well with this chip for me.

The sound chip does not generate any interrupts on its own line.
So it does not sound at all.

Maybe i can find something by comparing the alsa driver chip initialisation
with the 2.4.2 driver.
It feels strange having the card generating a completely different interrupt
than the one assigned to it.

Anyone with an idea ?


Gerold

Will Newton wrote:
> 
> I am still having problems with this driver.
> 
> When loading the driver I get:
> 
> es1371: version v0.27 time 00:47:56 Mar  7 2001
> es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
> PCI: Found IRQ 10 for device 00:0b.0
> es1371: found es1371 rev 8 at io 0xa400 irq 10
> es1371: features: joystick 0x0
> ac97_codec: AC97  codec, id: 0x0000:0x0000 (Unknown)
> spurious 8259A interrupt: IRQ7.
> 
> This last line seems strange as /proc/interrupts does not list IRQ7:
> 
>   0:    2515137          XT-PIC  timer
>   1:      18752          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   4:    2438600          XT-PIC  serial
>   5:          0          XT-PIC  bttv
>   8:          1          XT-PIC  rtc
>  10:          0          XT-PIC  es1371
>  12:     310926          XT-PIC  PS/2 Mouse
>  14:     137157          XT-PIC  ide0
>  15:      35714          XT-PIC  ide1
> NMI:          0
> ERR:          1
> 
> The chip is actually a Cirrus Logic CS4297A.
