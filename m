Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSKSMkg>; Tue, 19 Nov 2002 07:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSKSMkg>; Tue, 19 Nov 2002 07:40:36 -0500
Received: from gwsystems-4.d.gtn.com ([194.231.113.36]:47629 "EHLO
	hydra.colinet.de") by vger.kernel.org with ESMTP id <S264610AbSKSMkf>;
	Tue, 19 Nov 2002 07:40:35 -0500
Subject: Re: DAC960, 2.4.19 alpha problems 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-Id: <kirk-1021119132330.A0216470@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
In-Reply-To: <1037710684.11541.8.camel@irongate.swansea.linux.org.uk> 
From: "T. Weyergraf" <kirk@colinet.de>
Date: Tue, 19 Nov 2002 13:23:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[....]
 
> Does the firmware need to run to make the card work however ? Thats a
> problem on some other raid cards that prevents them running on non x86
> platforms

That is something, I honestly don't know. I've asked on the debian-alpha
mailing-list first and did not get any explanatory response. I've checked
the card in a x86-machine ( just to very it's working and to configure
RAID drives ). In this machine, the card posts a banner, saying it's
a Mylex and - depending on the BIOS enable/disable setting - posting
some keypress options to start the build-in firmware.
That i don't see on my alpha, which does not necessarily mean something.

The SRM firmware contains a small x86-emulator, being capable to at
least run the POST-routines of normal PCI cards. AFAIK, this emulator
works on a lot of cards, but is not capable of doing any screen/terminal
I/O. For example, if you use Matrox vga cards ( quite common on alphas )
you get a working grafics device, but yoy won't see any matrox banner
on the screen. Newer firmware's even support a "run_bios" command,
that allows to start configuration routines, like the RAID setup.
Unfortunately, a version of this newer firmware does not exist for
my machine.

Mylex OEM'd some earlier DAC-models to DEC for use as a RAID
controller. These came with their own firmwaer, which allowed ppl
to setup logical RAID-drives. I can't tell, if the firmware handles any
other POST stuff.

The controller comes with a SA-110 processor running it's own firmware.
I would assume, that the SA-110 handles POST - but that's honestly
just a wild guess.

Regards, 
T.weyergraf


-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


