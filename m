Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSALU7m>; Sat, 12 Jan 2002 15:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287472AbSALU7d>; Sat, 12 Jan 2002 15:59:33 -0500
Received: from web20910.mail.yahoo.com ([216.136.226.232]:46957 "HELO
	web20910.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287003AbSALU7R>; Sat, 12 Jan 2002 15:59:17 -0500
Message-ID: <20020112205916.92247.qmail@web20910.mail.yahoo.com>
Date: Sat, 12 Jan 2002 12:59:16 -0800 (PST)
From: Paul Lorenz <p1orenz@yahoo.com>
Subject: Re: Driver via ac97 sound problem (VT82C686B)
To: salvador@inti.gov.ar
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C3F452F.3F477169@inti.gov.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Salvador,
    I appreciate your help. I added the following line
to drivers/sound/ac97_codec.c
       
{0x41445361, "Analog Devices AD1886",   &default_ops},

I then recompiled. Now when I load the module I get
the following...


Jan 12 10:24:57 debian kernel: Via 686a audio driver
1.9.1
Jan 12 10:24:57 debian kernel: PCI: Found IRQ 11 for
device 00:07.5
Jan 12 10:24:57 debian kernel: IRQ routing conflict
for 00:07.5, have irq 5, want irq 11
Jan 12 10:24:57 debian kernel: PCI: Sharing IRQ 11
with 00:0a.0
Jan 12 10:24:57 debian kernel: PCI: Sharing IRQ 11
with 00:0b.0
Jan 12 10:24:57 debian kernel: ac97_codec: AC97 Audio
codec, id: 0x4144:0x5361 (Analog Devices AD1886)
Jan 12 10:24:57 debian kernel: via82cxxx: board #1 at
0x1000, IRQ 5

So now it recognizes the card. However, still no sound
:(

Any further suggestions? I'm going to try and play
around w/alsa a bit more and see if that leads to
anythings.

thanks again,
Paul

--- salvador <salvador@inti.gov.ar> wrote:
> Hi Paul
> 
> Alan is right this problem seems to be that the EAPD
> control is turning off
> the external amplifier, try  modifying the
> ac97_codec module to detect your
> codec and use default_ops.
> 
> SET
> 
> 
> --
> Salvador Eduardo Tropea (SET). (Electronics
> Engineer)
> Visit my home page: http://welcome.to/SetSoft or
> http://www.geocities.com/SiliconValley/Vista/6552/
> Alternative e-mail: set@computer.org set@ieee.org
> Address: Curapaligue 2124, Caseros, 3 de Febrero
> Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759
> 0013
> 
> 
> 


__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
