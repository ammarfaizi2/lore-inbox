Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290783AbSAYSs2>; Fri, 25 Jan 2002 13:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSAYSsW>; Fri, 25 Jan 2002 13:48:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13585 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S290785AbSAYSrt>; Fri, 25 Jan 2002 13:47:49 -0500
Date: Fri, 25 Jan 2002 19:47:48 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rasmus B?g Hansen <moffe@amagerkollegiet.dk>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a chipset)
Message-ID: <20020125184748.GA9932@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020124184011.GA23785@vana.vc.cvut.cz> <Pine.LNX.4.44.0201251044210.1519-100000@grignard.amagerkollegiet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0201251044210.1519-100000@grignard.amagerkollegiet.dk>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In mailing-lists.linux-kernel, Rasmus B?g Hansen wrote:
> > > 
> > > > When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> > > > again the last command run, follwing this from the kernel: 
> > > >   Power down.  
> > > >   hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5 
> > > > And again my system hangs.
> > > 
> > > I have an ASUS A7V motherboard, similar to your ASUS A7V133.  I find
> > > that stock kernel (2.4.18-pre7) APM powers off the machine, but stock
> > > kernel ACPI does not.  However, the Intel ACPI patch, available from
> > > http://developer.intel.com/technology/IAPC/acpi/downloads.htm against
> > > kernel 2.4.16, does power down my machine.  I was able to forward port
> > > this to 2.4.18-pre7 without too much trouble by starting with 2.4.16,
> > > applying the Intel ACPI patch first, and then applying kernel
> > > patch-2.4.17 and kernel patch-2.4.18-pre7.
> > 
> > I still have this in my tree. I have no idea who is wrong, whether parser
> > or BIOS.
> 
> Your patch might work on the A7V, but it does not on my A7V133-C. If I 
> modify the OEM string in the patch, it works. It may also be modified to 
> [...] "A7V-133", 7)[...] but then it probably won't work on a A7V...

This should be done properly by DMI blacklist.

> As said in another post, the patch from the intel site also solves the 
> problem.

Which patch?

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
