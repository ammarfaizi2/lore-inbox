Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281678AbRK0RVd>; Tue, 27 Nov 2001 12:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280948AbRK0RVX>; Tue, 27 Nov 2001 12:21:23 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:2176 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S281678AbRK0RVI>; Tue, 27 Nov 2001 12:21:08 -0500
Message-ID: <002d01c17767$e89e7480$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Matteo Sasso" <icemaze@tiscalinet.it>, <linux-kernel@vger.kernel.org>
In-Reply-To: <GAELJDOEMJGDLHEONDIOEEBOCBAA.icemaze@tiscalinet.it>
Subject: Re: Bug (?) report - Nope
Date: Tue, 27 Nov 2001 18:21:10 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Matteo Sasso" <icemaze@tiscalinet.it>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 27, 2001 4:04 PM
Subject: Bug (?) report


> I'm quite a new linux user and system administrator (my own!) and I
> encountered the following problems:
> 1) As the system starts up and the mixer settings are loaded, modprobe
> complains that 'sound-slot-0' and 'sound-service-0-0' modules are not
> present (in my kernel/drivers/sound directory I got just ac97_codec.o,
> emu10k1, sound.o and soundcore.o). I've got a Sound Blaster Live! 5.1, a
> '2.4.16-pre1' kernel and kmod usually works good, failing only with sound
> (both with 'gom' mixer and with 'mpg123' player), so I have to 'modprobe
> emu10k1' manually.

You have to alias sound-slot-0 and/or sound-service-0-0 to the correct
module.
"man modules.conf" will propably tell you more

> 2) I tried for the first time to play a bit with kernel source and I was
> trying to lower console_loglevel in order to have all the startup printk's
> disappear. I lowered the DEFAULT_CONSOLE_LOGLEVEL constant in
> 'kernel/printk.c' from '7' to '5' (just to be sure) but that wasn't enough
> to get rid of all those annoying KERN_INFO. Why didn't it work?

Propably you just block the console messages *after* boot. I suspect there
is already a kernel parameter to set this though, so you don't need to mess
with the source. Browse a bit in "Documentation/kernel-parameters.txt"

(hint: try appending "quiet=1" when you boot your kernel)

>
> Please feel free not to answer if you don't feel like. I know I can be
buggy
> sometimes! :P

Hmm. Yes. Read the FAQ for lkml:
http://www.tux.org/lkml/


