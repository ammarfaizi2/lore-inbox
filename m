Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288862AbSAXT3h>; Thu, 24 Jan 2002 14:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSAXT32>; Thu, 24 Jan 2002 14:29:28 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:2573 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S288862AbSAXT3P>; Thu, 24 Jan 2002 14:29:15 -0500
Date: Thu, 24 Jan 2002 20:27:39 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble (Was: Re: [patch] amd athlon cooling on kt266/266a
 chipset)
In-Reply-To: <200201241749.g0OHnbG02468@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-ID: <Pine.LNX.4.44.0201242014410.1347-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Wayne Whitney wrote:

> In mailing-lists.linux-kernel, Rasmus Bøg Hansen wrote:
> 
> > When running /sbin/poweroff from runlevel 3 or 5, 'halt -i -d -p' is
> > again the last command run, follwing this from the kernel: 
> >   Power down.  
> >   hwsleep-0178 [02] Acpi_enable_sleep_state: Entering S5 
> > And again my system hangs.
> 
> I have an ASUS A7V motherboard, similar to your ASUS A7V133.  I find
> that stock kernel (2.4.18-pre7) APM powers off the machine, but stock
> kernel ACPI does not.  However, the Intel ACPI patch, available from
> http://developer.intel.com/technology/IAPC/acpi/downloads.htm against
> kernel 2.4.16, does power down my machine.  I was able to forward port
> this to 2.4.18-pre7 without too much trouble by starting with 2.4.16,
> applying the Intel ACPI patch first, and then applying kernel
> patch-2.4.17 and kernel patch-2.4.18-pre7.

Thanks for the tip; now it works. And besides I installed acpid - pretty 
cool to get a clean shutdown when the power-button is pressed :-)

> As to the merits of the amd_disconnect patch that started this thread,
> under 2.4.18-pre7-acpi, I get an idle CPU temperature of about 48 C.
> With the amd_disconnect patch, it drops to 32-35 C, wow!  As
> previously discussed, APM + amd_disconnect on an Athlon does not
> provide any power savings, one needs ACPI + amd_disconnect.
> 
> Note that on this motherboard (and perhaps all ASUS Via chipset
> motherboards, including the A7V133), one needs the following line in
> /etc/sensors.conf to get reasonable lm_sensors CPU temperatures:
>   compute temp2 @*2, @/2
> This is as described at http://www2.lm-sensors.nu/~lm78/support.html
> in Ticket 775.

Eek, so my BIOS was right after all :-) The system is 63C at high load 
and 45C with the disconnection patch and ACPI enabled. With normal APM 
and no disconnection it is around 60C.

Thanks anyway.

Regards
Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Drink wet cement: Get Stoned.
----------------------------------[ moffe at amagerkollegiet dot dk ] --


