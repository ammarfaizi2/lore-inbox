Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130140AbRACBEq>; Tue, 2 Jan 2001 20:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130316AbRACBEg>; Tue, 2 Jan 2001 20:04:36 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:21767 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129734AbRACBES>; Tue, 2 Jan 2001 20:04:18 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE568@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Andreas Bombe'" <andreas.bombe@munich.netsurf.de>,
        acpi@phobos.fachschaften.tu-muenchen.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: [Acpi] [OOPS] kacpid dies on boot 2.4.0-prerelease
Date: Tue, 2 Jan 2001 16:32:16 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm keeping the CC to l-k, but let's move this to the acpilist, ok?)

acpi_get_battery_info is brand new code. It worked on my box, though ;-) can
you help me narrow down which of the assignments near the end of the
function is to blame? (via printk, I guess)

If you could post your DSDT that would be great too.

Concerning the slowness issue you mention. I'm not convinced this is a real
issue if just bogomips is less. I could be wrong..Does the system actually
feel slow?

Regards -- Andy

> From: Andreas Bombe [mailto:andreas.bombe@munich.netsurf.de]
> Attached is a ksymoops processed oops which kacpid creates as part of
> its initialization (i.e. at boot time).  It was connected to AC power
> with a full battery, if that is significant.
> Kernel is 2.4.0-prerelease.  The machine is a IBM Thinkpad 
> i1200 series
> (to be more specific model 1161-267), Coppermine Celeron CPU 550MHz,
> 64MB RAM, BIOS updated to 1.0R.
> 
> This machine works fine under APM except that it sucks as 
> much power on
> suspend than when running (LCD and HD shut off, that's all).  
> With ACPI
> I have the contrary problem that it goes into CPU powersave 
> even when it
> should be running normally.  The userspace bogomips program normally
> reports 546bm but only 64bm when running ACPI (and it is slow; kernel
> cpuinfo reports 1040bm in both cases, it is reduced in speed 
> only after
> kernel did its own measurement).  This could be related to the kacipd
> failure however.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
