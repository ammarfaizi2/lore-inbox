Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290459AbSAXX2x>; Thu, 24 Jan 2002 18:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290460AbSAXX2e>; Thu, 24 Jan 2002 18:28:34 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:43790 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S290459AbSAXX2W>; Thu, 24 Jan 2002 18:28:22 -0500
Date: Fri, 25 Jan 2002 00:28:21 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Grover <andrew.grover@intel.com>,
        <acpi-devel@lists.sourceforge.net>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
 chipset)
In-Reply-To: <20020124212507Z290307-13996+11382@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0201242329150.1355-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> > > > However, after disabling APM and enabling ACPI, my system won't power
> > > > off anymore :-(

> > When running '/sbin/poweroff' from single-user, 'halt -i -d p' is the
> > last command run by the halt script. The I get the message 'Power down.'
> > from the kernel and my system just hangs here.
> 
> What if you do it by hand?

Eh, it signals init to go to runlevel 0. Apparently it is some kind of 
wrapper.

> > When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> > again the last command run, follwing this from the kernel:
> >
> > Power down.
> >  hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5
> 
> Maybe this is an indication of broken BIOS.

Another broken BIOS implementation...

Btw. I'm running with BIOS 1005A. I did not dare to flash to 1007 as the 
flash program is telling me, that the 1007 BIOS is for "A7V133-C" while 
my current BIOS is for "<A7V133>"...

> You should grep for the ACPI diagnosis tools and send your results to the 
> acpi-devel list.

Eh, is that the pmtools package? If so, I have put output from the 
programs at http://www.amagerkollegiet.dk/~moffe/acpi/

> > And again my system hangs. Pressing the power button for 4 seconds turns
> > off the computer (the BIOS is set to 'immediate power off').
> 
> What? This is contradictorily.

If the Linux ACPI implementation takes over control of the button, it 
should be ok or what?

> > From my 'make menuconfig:
> >
> > [*] Power Management support
> > [*]   ACPI support
> > [*]     ACPI Debug Statements
> > <*>     ACPI Bus Manager
> > <*>       System
> > <*>       Processor
> > < >       Button
> > < >       AC Adapter
> > < >       Embedded Controller
> > < >   Advanced Power Management BIOS support
> 
> I have Button enabled, too. Please try.

I just tried the same ACPI configuration as you; no change - it still 
hangs at 'Power off.'.

> > At bootup I get the following regarding ACPI:
> 
> Can you send the fist lines from your boot log?

I have put it in the same place 
(http://www.amagerkollegiet.dk/~moffe/acpi/) as acpi-old.txt. Also there 
is the dmesg from the kernel with the acpi-patch (from the intel site) 
applied.

> Maybe you should CC to acpi-devel.

Done (however I'm not a list member myself).

> > My motherboard is an Asus A7V133-C. Output from lspci -v:
> 
> > 00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
> > 40) Subsystem: Asustek Computer, Inc.: Unknown device 8042
> > 	Flags: medium devsel, IRQ 9
> > 	Capabilities: <available only to root>
> 
> Unknown device 8042
> 
> Maybe here is something missing, too.
> 
> The ACPI people should lighten this. --- Andrew?

I've put the output from 'lspci -vvv -xx' on the same site 
(http://www.amagerkollegiet.dk/~moffe/acpi/) if it should show up to be 
helpful.

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
He has his own opinions
- just like the others.
  - Burnin' Red Ivanhoe
----------------------------------[ moffe at amagerkollegiet dot dk ] --





