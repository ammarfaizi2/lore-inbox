Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284100AbRLANjw>; Sat, 1 Dec 2001 08:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284098AbRLANjm>; Sat, 1 Dec 2001 08:39:42 -0500
Received: from smtp3.libero.it ([193.70.192.53]:8587 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S281662AbRLANjj>;
	Sat, 1 Dec 2001 08:39:39 -0500
Date: Sat, 1 Dec 2001 14:39:43 +0100
From: Emmanuele Bassi <emmanuele.bassi@iol.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Deadlock on kernels > 2.4.13-pre6
Message-ID: <20011201143943.A1851@wolverine.lohacker.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011130221334.A15353@wolverine.lohacker.net> <E169wJt-00052j-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E169wJt-00052j-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
X-Mailer: Mutt 1.3.23i (2001-10-09)
X-OS: Linux 2.4.13-pre6 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

> > Even if it shows up to be a VIA problem, what do I have to do, to get my
> > system work properly with this chipset?
> 
> The reason I ask is VIA have had a history of weird ISA DMA hangs when doing
> certain other operations. It could be some combination of these triggering
> problems.

Considering this issue, and that everything else I've tried this far, I
beginning to think that the controller is, indeed, guilty as charged.

> > 01:00.0 VGA compatible controller: nVidia Corporation Riva TnT [NV04] (rev 04) (prog-if 00 [VGA])
> 
> Are you seeing the hangs in X11, and which X setup (one with agp loaded ?)

I see hangs in both X11 and console, but under console I use the
framebuffer device (rivafb).

This is the section about my hardware inside /etc/X11/XF86Config-4:

# **********************************************************************
# Graphics device section
# **********************************************************************

# Device configured by xf86config:

Section "Device"
    Identifier  "Creative VideoBlaster"
    Driver      "nv"
    VideoRam    16384
EndSection

+++

Just to be certain, I have an old PCI graphic card (a Matrox Mystique)
that worked nicely since three years now... If that works nice, this
should be the final proof...

> Also does it print "Activiating ISA DMA workarounds" during the boot ?

Yes.

Bye,
 Emmanuele.

-- 
Emmanuele Bassi (Zefram)               [ http://digilander.iol.it/ebassi ]
GnuPG Key fingerprint = 4DD0 C90D 4070 F071 5738  08BD 8ECC DB8F A432 0FF4
