Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbTJVBs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbTJVBs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:48:27 -0400
Received: from fmr05.intel.com ([134.134.136.6]:53431 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263392AbTJVBsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:48:24 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Tue, 21 Oct 2003 18:48:18 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007792A@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOYGcbThD38p9LHT5alI96LMJvnSgAJEqCw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alexander Bokovoy" <ab@altlinux.org>, "M?ns Rullg?rd" <mru@kth.se>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Oct 2003 01:48:19.0922 (UTC) FILETIME=[91DF2320:01C3983E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Alexander Bokovoy
> Sent: Tuesday, October 21, 2003 2:11 PM
> To: M?ns Rullg?rd
> Cc: cpufreq@www.linux.org.uk; linux-kernel@vger.kernel.org
> Subject: Re: [PATCHSET] 0/3 Dynamic cpufreq governor and 
> updates to ACPI P-state driver
> 
> 
> On Tue, Oct 21, 2003 at 10:39:16PM +0200, M?ns Rullg?rd wrote:
> > Alexander Bokovoy <ab@altlinux.org> writes:
> > 
> > >> > Most of the latest CPUs (laptop CPUs in particular) 
> have feature 
> > >> > which enable very low latency P-state transitions 
> > >> > (like Enhanced Speedstep Technology-EST). Using this feature, 
> > >> > we can have a lightweight in kernel cpufreq governor, 
> > >> > to vary CPU frequency depending on the CPU usage. The 
> > >> > advantage being low power consumption and also cooler laptops.
> > >> 
> > >> So, I took this thing for a spin, but it didn't work at 
> all.  I loaded
> > >> the module, and did "echo demandbased > 
> /sys/.../scaling_governor".
> > >> This echo never returned, and the keyboard locked up.  
> After a little
> > >> while, the fan started running at full speed.  I managed 
> to cut and
> > >> paste into an xterm and start top, which showed nothing 
> unusual.  I
> > >> could shut down and reboot normally.
> > > I applied these patches to stock 2.6.0-test8 and selected 
> 'demandbased' as
> > > default governor. In result, everything worked from the 
> very beginning, my
> > > Centrino-based system went to 600MHz and was upping when 
> load was going
> > > higher during compilation or disk access but went down 
> when load was
> > > lowering. So it works well for me.
> > 
> > What's your /proc/cpuinfo?  Mine says
> > 
> > processor	: 0
> > vendor_id	: GenuineIntel
> > cpu family	: 15
> > model		: 2
> > model name	: Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz


AFAIK, Pentium 4 M does not support EST (Frequency transitions with low
latency). 
But that doesn't explain why it is hanging though. Which speedstep
driver are you using?
P4-clockmod? Or acpi? Can you send the complete dmesg.


Thanks,
-Venkatesh
