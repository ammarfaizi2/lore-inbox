Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312888AbSDEOot>; Fri, 5 Apr 2002 09:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312887AbSDEOoj>; Fri, 5 Apr 2002 09:44:39 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:40344 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312872AbSDEOob>; Fri, 5 Apr 2002 09:44:31 -0500
Date: Fri, 5 Apr 2002 16:31:02 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Chris Wilson <chris@jakdaw.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4/i845 Strange clock drifting
In-Reply-To: <20020405132810.4728c01d.chris@jakdaw.org>
Message-ID: <Pine.LNX.4.44.0204051614230.31733-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, Chris Wilson wrote:

> > -dj2 P4 thermal patch is a bit broken (my bad), but the fact that it 
> > doesn't detect an APIC means that code would, erm do interesting things...
> 
> <grin>
> 
> I've now tried a couple more kernels to no avail - nothing can find APICs.
> Is it even possible for a P4 to not have a local APIC? System is a
> supermicro 5012B*. 
> 
> /proc/cpuinfo shows:
> 
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> 
> (notice no "apic"). Is this normal/correct? If just just removed the check
> from apic.c and tried to enable the apic anyway then are bad things going
> to happen? 

All P4s have a local APIC, however your bios can play a part in making it 
unavailable (global enable flag in apic base MSR). Please send me your 
dmesg.

> I've also noticed [probably unrelated but...] that I can't reboot the box
> without use of the reset button - it doesn't come up after /sbin/reboot -f
> either. It's at a colo facility so I can't see what's being displayed
> until I find out a null modem and go for a drive... :)

Have you tried the various reboot kernel parameters? You can try the 
following.

reboot=w - Sets warm reboot flag
reboot=c - Sets cold reboot flag
reboot=b - Reboot via jump to BIOS

and finally if you're really desperate ;)

reboot=h - do a hard reboot, i think this is does a triple fault

Cheers,
	Zwane

-- 
http://function.linuxpower.ca
		


