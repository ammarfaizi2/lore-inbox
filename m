Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288987AbSA3I6z>; Wed, 30 Jan 2002 03:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSA3I6p>; Wed, 30 Jan 2002 03:58:45 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:15000 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S288987AbSA3I61>; Wed, 30 Jan 2002 03:58:27 -0500
Date: Wed, 30 Jan 2002 09:58:26 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020124221630.500F81101@shrek.lisa.de>
Message-ID: <Pine.LNX.4.40.0201300943260.29126-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> System feels fast normally, and feels noticable slower with disconnected
> feature. The problem with vlc is it's timing fragility to get smooth video
> and synchronous audio output. (I also need alsa > 0.9.0 and XVideo scaling
> on my Matrox G450 to get there, btw).

hi hans-peter

i have uploaded a new testing version of the patch to the webserver. you
can get it from:
http://cip.uni-trier.de/nofftz/linux/amd_cool_new.diff
it is only a testing version and an attempt to fix this skippy behavior on
video and audio playback. after some searching through athlon references i
found some hints, how to set up the athlon processor to perform better
when reconnected to the system bus. so i figgured out a way to make this
processor setup from within the kernel (normaly it should be done by the
bios). i am not sure whether it does that what i wanted, cause i have no
sound video problems, so i need someone who tests this with a computer
which has problems with the patch. maybee you could do this ?
the new patch will modify a msr (mashine specific register) on the athlon
cpu, which is used to reset the clock to the right value, when the bus is
reconnected. i used a different setting, i found in one of the reference
guides. i am not sure whether this is the right value to fix the problem,
cause the documentation for the processor bug is only acessable by
registerd bios programmer (i think ... i didn't find it until yet) ...
so -... please give it a try and report whether the problems are going
better with this new testing version.
as befor, you have to enable acpi and acpi-processor ... then you have to
enter amd_discconet=yes at lilo prompt and this time you also have to
enter force_amd_clk=yes ....
at booting time (dmesg) linux will say something like:
Athlon/Duron CLK_Ctrl Value found : 6003d22f
Enabling disconnect in VIA northbridge: KT266/266A chipset found.
and ... when you have force_amd_clk enabed it will say something like
"Athlon/Duron CLK_Ctrl Value set to: ....." ... please include this output
in the replay ti me :)

if someone else with or without the problems want do give the patch a try:
please include this output lines (the values that are found) in the
posting .... expecialy i am interested to get the values from the people
who have no problems with the patch :)

thanks ...

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

