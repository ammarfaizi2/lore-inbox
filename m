Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbUKWBpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbUKWBpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUKWBi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:38:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46095 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261212AbUKWBhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:37:25 -0500
Date: Tue, 23 Nov 2004 02:37:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
Message-ID: <20041123013720.GA4371@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <1101148138.20008.6.camel@d845pe> <20041123004619.GQ19419@stusta.de> <1101172056.20006.153.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101172056.20006.153.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:07:36PM -0500, Len Brown wrote:
> On Mon, 2004-11-22 at 19:46, Adrian Bunk wrote:
> 
> > Not needed "pressing the power button when you halt the system" is the
> > "killer application" for using ACPI for me...
> 
> Yes, thats certainly one that people notice right away.  Laptops have
> had soft poweroff with APM for a while, but desktops and servers never
> adopted APM, so soft-power-off is generally a new feature with ACPI for
> them.

That's wrong.

My old desktop computer (with a VIA MVP3 chipset and an AMD K6 cpu) 
I bought in 1998 did power off fine under Linux using APM.

> Enabling IOAPIC is one that a lot of people like, because it results in
> less interrupt sharing and better performance than PIC mode.  But if you
> don't load your system much you may not notice any difference.

I saw

  kernel: APIC error on CPU0: 00(02)
...
  kernel: APIC error on CPU0: 02(02)

on my computer and decided disabling APIC was the easiest way to solve 
them...

> Next people tend to notice fan speed, because they can hear it.
> If you load processor and thermal, you'll probably see some
> /proc/acpi/thermal/thermal_zone/*/temperature and you'll
> probably find that it stays lower if you keep processor
> loaded versus when you do not.

/proc/acpi/thermal/thermal_zone is empty on my computer.

> This is usually because of power-saving c-csates in idle,
> which you can observe in /proc/acpi/processor/*/power
> and the higher the C-state, the more power you save.

active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[--] demotion[--] latency[000] usage[00000000]
    C2:                  <not supported>
    C3:                  <not supported>

> Also, CPUFREQ usually often on ACPI, and that can save
> power even when the system is not idle, and this results
> in lower temperatures and hopefully slower fan speeds.

My computer has a desktop Athlon...

> cheers,
> -Len

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

