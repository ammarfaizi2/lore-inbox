Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbTCGAIC>; Thu, 6 Mar 2003 19:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261308AbTCGAIC>; Thu, 6 Mar 2003 19:08:02 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:38348 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id <S261307AbTCGAHH>; Thu, 6 Mar 2003 19:07:07 -0500
Date: Fri, 7 Mar 2003 11:17:24 +1100
From: CaT <cat@zip.com.au>
To: Dominik Brodowski <linux@brodo.de>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.5.64 - cpu freq not turned on
Message-ID: <20030307001724.GB588@zip.com.au>
References: <20030306152616.GB432@zip.com.au> <20030306233228.GK1016@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306233228.GK1016@brodo.de>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 12:32:28AM +0100, Dominik Brodowski wrote:
> > Now I know it worked before cos I noticed it and played about with the 8
> > speed steps I had available to me (and I thought I only had 2).
> 
> Actually, SpeedStep is (so far, Banias isn't out to the public market yet)
> only 2 states. What you had running was probably the p4-clockmod driver for
> Intel Pentium 4 processors. But that does only throttle the CPU, which

Ahhh. I have a P3 though.

> causes (at best) linear energy saving while real "speedstep" is much better
> than that. You can see what cpufreq driver is loaded by cat'ting
> scaling_driver in the cpufreq sysfs directory for that cpu. 

Not there.

> This directory moved in 2.5.64 - and that's why you probably think there was
> some regression (in fact, there is, but patches to fix that are on their
> way...) - the sysfs interface to cpufreq is now in 

2.5.63 doesn't turn speedstep on for me either.

> > What information is needed about my chipset to make the code detect it
> > properly?
> 
> lspci -- maybe it's a ich4-m southbridge, then the attached patch
> (also sent to Linus a few moments ago) might help.

Didn't apply the patch cos I don't see that in the lspci output:

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)

The rest are sound, cardbus etc.

-- 
"Other countries of course, bear the same risk. But there's no doubt his
hatred is mainly directed at us. After all this is the guy who tried to
kill my dad."
        - George W. Bush Jr, 'President' of the United States
          September 26, 2002 (from a political fundraiser in Huston, Texas)

