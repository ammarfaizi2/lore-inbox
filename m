Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277603AbRJNU7Z>; Sun, 14 Oct 2001 16:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277608AbRJNU7P>; Sun, 14 Oct 2001 16:59:15 -0400
Received: from [213.97.184.209] ([213.97.184.209]:60547 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S277603AbRJNU7F> convert rfc822-to-8bit;
	Sun, 14 Oct 2001 16:59:05 -0400
Date: Sun, 14 Oct 2001 22:59:13 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Willem Riede <wriede@home.com>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
In-Reply-To: <20011014164913.A1428@linnie.riede.org>
Message-ID: <Pine.LNX.4.33.0110142254470.27070-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2001, Willem Riede wrote:

> I'm not having much luck with this :-(
>
> I also have a Tyan Tiger MP, and have built a 2.4.10-ac12 based kernel
> for it. Actually, I modified the Rawhide kernel SRPM to use linux-2.4.10
> and the ac12 patch, as I run ext3 and software raid installed by RedHat's
> Roswell beta, and I need to stay compatible with that; then made and
> installed the athlon-smp RPM.
>
> It contains 2.6.1 for i2c, and I generated the patch for lm_sensors
> 2.6.1 to replace the older patch for lm_sensors in the SRPM.
>
> The i2c-amd756 module hangs my kernel too, but you seem to have it
> work without it? I don't get anything detected without i2c-amd756.
> This is what the log messages say (but I have to reboot to read them):
>
> Oct 14 16:17:16 linnie kernel: i2c-amd756.o version 2.6.1 (20010830)
> Oct 14 16:17:16 linnie kernel: i2c-dev.o: Registered 'SMBus AMD7X6 adapter
> at 80e0' as minor 1
> Oct 14 16:17:16 linnie kernel: i2c-core.o: client [W83782D chip] registered
> to adapter [SMBus AMD7X6 adapter at 80e0](pos. 0).
> Oct 14 16:17:16 linnie kernel: i2c-core.o: client [W83782D subclient]
> registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 1).
> Oct 14 16:17:16 linnie kernel: i2c-core.o: client [W83782D subclient]
> registered to adapter [SMBus AMD7X6 adapter at 80e0](pos. 2).
>
> Or is it this module (i2c-amd756) that you say must be included in the
> kernel to make 'it' work (English is so ambiguous :-))?

	No, you can compile it as a module, you need to insert manually it
(modprobe) or better modify modules.conf so it gets inserted automatically
when loading i2c. The problem with the machine hanging up was resolved
as Dan Hollis suggested comenting the initialization routine (I mean
the content of the routine, the routine must exist).

> One more question if you don't mind: do you (still) have to first
> read the sensors in the BIOS before booting? If I do that, for some
> reason, I don't get my grub boot screen after exiting setup, instead
> the board tries to boot off the lan; I ctrl-atl-del out of that, and
> then things are back to normal, but that soft reset probably undid
> whatever reading the sensors in the bios changed :-(
> Any other settings in the bios that matter?

	Uhmm, I don't know if reading the sensors in the BIOS would
make it work better, but I must make a sensors -s before reading, if not
I'll get that 70ºC ... the same that you get when you enter the BIOS
until you press a key.

	It's important to change the type of thermal sensor to
3904 transistor ( set sensor1 2 ....) if not you won't get the right
temperatures.

	- german

-------------------------------------------------------------------------
German Gomez Garcia          | Send email with "SEND GPG KEY" as subject
<german@piraos.com>          | to receive my GnuPG public key.

