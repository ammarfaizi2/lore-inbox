Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276828AbRJPWla>; Tue, 16 Oct 2001 18:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276814AbRJPWlV>; Tue, 16 Oct 2001 18:41:21 -0400
Received: from akkar.interpost.no ([139.117.8.12]:51722 "EHLO
	akkar.interpost.no") by vger.kernel.org with ESMTP
	id <S276813AbRJPWlB>; Tue, 16 Oct 2001 18:41:01 -0400
Date: Wed, 17 Oct 2001 00:40:28 +0200
From: Roy-Magne Mo <rmo@sunnmore.net>
To: Willem Riede <wriede@home.com>
Cc: German Gomez Garcia <german@piraos.com>, Dan Hollis <goemon@anime.net>,
        Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on the 760MP
Message-ID: <20011017004028.G8329@akkar.interpost.no>
In-Reply-To: <20011013102128.A1414@linnie.riede.org> <20011014164913.A1428@linnie.riede.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011014164913.A1428@linnie.riede.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 04:49:13PM -0400, Willem Riede wrote:
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
> 
> One more question if you don't mind: do you (still) have to first
> read the sensors in the BIOS before booting? If I do that, for some
> reason, I don't get my grub boot screen after exiting setup, instead
> the board tries to boot off the lan; I ctrl-atl-del out of that, and 
> then things are back to normal, but that soft reset probably undid
> whatever reading the sensors in the bios changed :-(
> Any other settings in the bios that matter?

I've turned on APIC in bios and kernel, set all parallel ports and
serial ports to auto in BIOS and removed support parllel ports in the
kernel. I'm now able to insert the drivers unpatched from lm_sensors
cvs-version. 

Seems like it's the autoprobing in the parallel driver that messes it
up.

-- 
carpe noctem
