Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbSI0GlV>; Fri, 27 Sep 2002 02:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSI0GlV>; Fri, 27 Sep 2002 02:41:21 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:676 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S261308AbSI0GlU>;
	Fri, 27 Sep 2002 02:41:20 -0400
Date: Fri, 27 Sep 2002 08:46:01 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
Message-ID: <20020927084601.C25704@fi.muni.cz>
References: <3D9330ED.4080105@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9330ED.4080105@colorfullife.com>; from manfred@colorfullife.com on Thu, Sep 26, 2002 at 06:08:13PM +0200
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
: The errata is not PS/2 mouse specific:
: it says that the io apic doesn't implement masking interrupts correctly.

	Yes, but it says that problem has not been observed when running
with PS/2 mouse. Which is exactly what I observe on my system.
: 
: Linux uses masking aggressively - disable_irq() is implemented by 
: masking the interrupt in the io apic. I'm surprised that this doesn't 
: cause frequent problems.

	The errata does not say that the interrupt masking in the IO-APIC
does not work in all situations. I read it as the lock-up (caused by
nonfunctional IRQ masking) sometimes occurs, nobody knows when,
and it has been observed on some Netware boxes w/o the PS/2 mouse.
Maybe even AMD does not know exactly what is going on there.

: Regarding Jan's problem: I'm not sure if his problems are related to 
: this errata. It says that using a PS/2 mouse instead of a serial mouse 
: with Novell Netward avoids the hang during shutdown, probably because 
: then netware doesn't mask the irq.

	Yes, it may be a faulty board as well, but I think it is
too close to this AMD errata.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
