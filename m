Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266809AbUBRAOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUBRAOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:14:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:3236 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266809AbUBRAOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:14:02 -0500
Subject: Re: Radeonfb problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Cc: Damian Kolkowski <damian@kolkowski.no-ip.org>,
       Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402180102.42276.vergata@stud.fbi.fh-darmstadt.de>
References: <200402172008.39887.vergata@stud.fbi.fh-darmstadt.de>
	 <20040217215738.ALLYOURBASEAREBELONGTOUS.B9706@kolkowski.no-ip.org>
	 <1077056532.1076.27.camel@gaston>
	 <200402180102.42276.vergata@stud.fbi.fh-darmstadt.de>
Content-Type: text/plain
Message-Id: <1077063096.1076.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 11:11:36 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 11:02, Sergio Vergata wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Well, just build 2.6.3-rc4 and the problem still exists.
> 
> I tried also booting with commandline parameter and reduced the size to 
> 1280x1024 and 1024x768 both works fine for me 
> 
> The dmesg output, from booting without any parameter,  autodetection of the 
> displaysize works fine.

I'm getting mixed up in all the reports, especially since you are
replying to Damian, but I don't think you have the same problem.

So please, do a short summary of the problem, include full context
information in your email.

> Sergio
> 
> ....
> radeonfb_pci_register BEGIN
> PCI: Found IRQ 6 for device 0000:01:00.0
> PCI: Sharing IRQ 6 with 0000:00:1d.0
> PCI: Sharing IRQ 6 with 0000:02:00.0
> PCI: Sharing IRQ 6 with 0000:02:01.0
> radeonfb: probed DDR SGRAM 65536k videoram
> radeonfb: mapped 16384k videoram
> radeonfb: Invalid ROM signature 0 should be 0xaa55
> radeonfb: Retreived PLL infos from BIOS
> radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=252.00 Mhz, System=200.00 MHz
> 1 chips in connector info
>  - chip 1 has 2 connectors
>   * connector 0 of type 2 (CRT) : 2300
>   * connector 1 of type 4 (DVI-D) : 4201
> Starting monitor auto detection...
> Non-DDC laptop panel detected
> radeonfb: Monitor 1 type LCD found
> radeonfb: Monitor 2 type no found
> radeonfb: panel ID string: SXGA+ Single (85MHz)    
> radeonfb: detected LVDS panel size from BIOS: 1400x1050
> BIOS provided panel power delay: 1000
> radeondb: BIOS provided dividers will be used
> ref_divider = 6
> post_divider = 2
> fbk_divider = 4c
> Scanning BIOS table ...
>  320 x 350
>  320 x 400
>  320 x 400
>  320 x 480
>  400 x 600
>  512 x 384
>  640 x 350
>  640 x 400
>  640 x 475
>  640 x 480
>  800 x 600
>  1024 x 768
>  1152 x 864
>  1280 x 1024
>  1400 x 1050
> Found panel in BIOS table:
>   hblank: 200
>   hOver_plus: 72
>   hSync_width: 40
>   vblank: 12
>   vOver_plus: 2
>   vSync_width: 1
>   clock: 8496
> Setting up default mode based on panel info
> radeonfb: Power Management enabled for Mobility chipsets
> radeonfb: ATI Radeon Lf  DDR SGRAM 64 MB
> radeonfb_pci_register END
> SBF: Simple Boot Flag extension found and enabled.
> SBF: Setting boot flags 0x1
> Machine check exception polling timer started.
> speedstep-centrino: found "Intel(R) Pentium(R) M processor 1600MHz": max 
> frequency: 1600000kHz
> ikconfig 0.7 with /proc/config*
> Initializing Cryptographic API
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> hStart = 1472, hEnd = 1512, hTotal = 1600
> vStart = 1052, vEnd = 1053, vTotal = 1062
> h_total_disp = 0xae00c7	   hsync_strt_wid = 0x505ba
> v_total_disp = 0x4190425	   vsync_strt_wid = 0x1041b
> pixclock = 11770
> freq = 8496
> lvds_gen_cntl: 003dffa1
> Console: switching to colour frame buffer device 175x65
> ...
> 
> On Tuesday 17 February 2004 23:22, Benjamin Herrenschmidt wrote:
> > On Wed, 2004-02-18 at 08:57, Damian Kolkowski wrote:
> > > * Kronos <kronos@kronoz.cjb.net> [2004-02-17 22:51]:
> > > > > 2.6.3-rc4 with new radeonfb looks better, but in lilo.con append for
> > > > > radeonfb wont work.
> > > >
> > > > What do you mean? What are passing to the kernel?
> > >
> > > For example:
> > >
> > > append = "video=radeon:1024x768-32@100" works for 2.4.x
> > > append = "video=radeonfb:1024x768-32@100 works for 2.6.x
> > >
> > > but for new radeonfb _radeonfb_ in append won't work, my screean start
> > > with small res on 36 Hz ;-) So I need to use fbset.
> > >
> > > Besides don't use 2.6.x even on desktop, that was only a test with new
> > > radeonfb from Ben H.
> >
> > Ugh ? Send me a dmesg log at boot please without any command
> > line. radeonfb should set your display to the native panel size
> > by default
> >
> > Ben.
> 
> - --
> Microsoft is to operating systems & security ....
>              .... what McDonalds is to gourmet cooking
> 
> PGP-Key http://vergata.it/GPG/F17FDB2F.asc
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
> 
> iD8DBQFAMqueVP5w5vF/2y8RAl1cAKDbvE0+Rw5IlzaLBIQOTbFdhtN+cACgxvYi
> NagkT2Buid3GhhQQdyNwfk4=
> =veYH
> -----END PGP SIGNATURE-----
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

