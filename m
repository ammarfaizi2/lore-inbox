Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270023AbRHGBcw>; Mon, 6 Aug 2001 21:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270022AbRHGBcn>; Mon, 6 Aug 2001 21:32:43 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.159.219.13]:18821 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S270024AbRHGBcc>; Mon, 6 Aug 2001 21:32:32 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Nicholas Knight <tegeran@home.com>
Subject: Re: 3c509: broken(verified)
Date: Tue, 7 Aug 2001 03:00:28 +0200
X-Mailer: KMail [version 1.2.3]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010806230051Z269127-28344+2074@vger.kernel.org> <01080616150000.03359@c779218-a>
In-Reply-To: <01080616150000.03359@c779218-a>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010807013236Z270024-28345+1539@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. August 2001 01:15 schrieb Nicholas Knight:
> On Monday 06 August 2001 04:00 pm, Dieter Nützel wrote:
> > On Monday 06 August 2001 22:30:12, Nicholas Knight wrote:
> > > You mention the problem is being unable to change the media, I was
> > > unaware this was even possible with the current 3c509 driver, and
> > > most people do it on 3c509's and other PNP cards of this sort (such
> > > as NE2000 clones)  by using a DOS boot diskette and the DOS utilities
> > > provided by the manufacturer.
> >
> > That's what I did. I've set it to "auto mode" and it works with RJ45
> > cable. But I can't verify if "full duplex" worked right. So I changed
> > it under Win to "10baseT" for which the 3Com utilities say "full
> > duplex" enabled.
>
> Why do you want full duplex on a DSL connection? I tend to set any NIC's
> I use for a consumer connection to the lower end of their settings to
> avoid possible problems in any OS.

That's not a bad decision...;-)
But I hoped to get most out of the DSL box.

> > Now I get this for my ADSL NIC.
> > My first NIC (Ethernet Pro 100+) is for the LAN.
> >
> > eth1: 3c5x9 at 0x220, 10baseT port, address  00 a0 24 87 4a a6, IRQ 5.
> > 3c509.c:1.18 12Mar2001 becker@scyld.com
> > http://www.scyld.com/network/3c509.html
> > eth1: Setting Rx mode to 1 addresses.
> > eth1: Setting Rx mode to 2 addresses.
> > eth1: Setting Rx mode to 3 addresses.
>
> sorry, did forget to mention that
> this popped up when I compiled the driver in instead of using a module,
> but it doesn't appear to be a problem, I have no idea what's going on
> with it though.

It is compiled as a module.

> > But I am not smarter 'cause there is no full duplex mode mentioned in
> > the logs.
>
> does it get mentioned in the logs for your other NIC?

Not that I remember.
Donald Becker's tool show something about:

SunWave1#3c5x9setup -v
3c5x9setup.c:v1.00 6/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 Interrupt sources are pending.
   Adapter Failure indication.
3c5x9 found at 0x300.
 Indication enable is 00fe, interrupt enable is 009c.
 EEPROM contents:
  Model number 3c509 version 4, base I/O 0x300, IRQ 5, 10baseT port.
  3Com Node Address 00:A0:24:87:4A:A6 (used as a unique ID only).
  OEM Station address 00:A0:24:87:4A:A6 (used as the ethernet address).
  Manufacture date (MM/DD/YY) 4/1/96, division 6, product BZ.
  Options: force full duplex, enable linkbeat.
  The computed checksum matches the stored checksum of 96c0.

But the EEPROM content is different from Kernel PNP.
see above

SunWave1#3c5x9setup -f -p 220
3c5x9setup.c:v1.00 6/19/2000 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
No EtherLink III device exists at address 0x220.
 Interrupt sources are pending.
   Interrupt latch indication.
   Adapter Failure indication.
   Tx Complete indication.
   Tx Available indication.
   Rx Complete indication.
   Rx Early Notice indication.
   Driver Intr Request indication.
   Statistics Full indication.
   DMA Done indication.
   Download Complete indication.
   Upload Complete indication.
   DMA in Progress indication.
   Command in Progress indication.
3c5*9 not found at 0x220, status ffff.
If there is a 3c5*9 card in the machine, explicitly set the I/O port address
  using '-p <ioaddr>
SunWave1#cat /proc/ioports | grep 3c509
0220-022f : 3c509 PnP

Ieeee, it destroy my setup, too. I have to reboot :-(
eth1: Infinite loop in interrupt, status ffff.

> > BTW Is DMA (channel 6 for example) possible with this hardware/driver?
>
> the hardware is capable of it I belive, I do not know about the driver.

Thanks!

-Dieter

PS Before we go full OT I switch to private mode.

