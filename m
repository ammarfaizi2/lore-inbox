Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTEVT1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 15:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTEVT1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 15:27:42 -0400
Received: from aglaia.aoaioxxysz.net ([64.81.50.67]:148 "EHLO
	aglaia.aoaioxxysz.net") by vger.kernel.org with ESMTP
	id S263171AbTEVT1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 15:27:38 -0400
Date: Thu, 22 May 2003 12:40:42 -0700
From: Forrest L Norvell <ogd@aglaia.aoaioxxysz.net>
To: ross.alexander@uk.neceur.com
Cc: darkshadow@web.de, linux-kernel@vger.kernel.org
Subject: Re: System hang with ASUS Socket-A motherboard
Message-ID: <20030522194042.GW3054@aglaia.aoaioxxysz.net>
References: <OF68BC3E44.0DEA13D3-ON80256D2B.00309280-80256D2B.0032C3B0@uk.neceur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF68BC3E44.0DEA13D3-ON80256D2B.00309280-80256D2B.0032C3B0@uk.neceur.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:14:28AM +0100, ross.alexander@uk.neceur.com wrote:
> Sven,
> 
> Both Forrest and myself have very similar problems with
> the system just completely freezing ie kernel goes catatonic.
> 
> Originally I though this was because of a bug in the AIC7xxx
> driver but I have had my system lock up during a file system
> check (after rebooting from a previous lockup :-(.
> 
> The SCSI driver is a module so that isn't to be faulted (but the
> card could be).  My (very unscientific) conclusion is that it
> probably is a bug in the kernel interrupt handling code.  It
> does tend to happen much more often under high IDE loads,
> for example CD ripping or file system checking so it could
> be getting an interrupt while still dealing with a previous disk
> interrupt but I could well be talking bullsh*t.  Things I haven't
> yet tried include disabling the SATA chipset and pulling
> out the PCI ethernet card (since I don't actually need it
> any more as linux-2.4.21 supports the builtin 3Com device).
> 
> For the mailing list here is my system details.
> 
> Processor: AMD 2800+.
> Motherboard: AUS A7N8X Deluxe
> Chipset: nforce2 SPP + MCP2-T
> Memory: 1.5GB (3 x 512MB)

I'd like to state for the good of the order that since I updated to
2.4.21-rc2 and stopped trying to use the ac patch, I haven't had any
hangs, although I have had a few "8259A Interrupt" messages logged to
kmsg. No uniprocessor APIC support, ACPI + APM compiled in, SCSI
compiled into kernel instead of modularly, all NForce gunch tainting
up the kernel and working just fine.

Forrest

-- 
       . . . the self-reflecting image of a narcotized mind . . .
ozymandias G desiderata     ogd@aoaioxxysz.net     desperate, deathless
(415)823-6356       http://www.pushby.com/forrest/       ::AOAIOXXYSZ::
