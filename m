Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSFABvp>; Fri, 31 May 2002 21:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316979AbSFABvo>; Fri, 31 May 2002 21:51:44 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:62212 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S316978AbSFABvn>; Fri, 31 May 2002 21:51:43 -0400
Date: Fri, 31 May 2002 21:51:44 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Dave Jones <davej@suse.de>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre9-ac3
Message-ID: <20020531215144.A4358@light-brigade.mit.edu>
In-Reply-To: <200205302322.g4UNMne06371@devserv.devel.redhat.com> <20020531014935.D9282@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Linux 2.4.19pre9-ac3
>  > o	Cpufreq updates			(Dominik Brodowski, Dave Jones0
>  > 	| Now includes some reverse engineered speedstep support 
> 
> Two points worth mentioning in regard to this.
> 1. The first type of speedstep (found in systems with BX chipsets)
>    isn't supported. Only the later type found in systems with ICH
>    chipsets will work with this driver..
> 2. Dominik did 99.9% of the Spudstop work, so all offers of free moneyi
>    should be directed to him.

This is on an IBM Thinkpad T23:

cpufreq: Intel(R) SpeedStep(TM) support $Revision: 1.7.2.2 $
cpufreq: chipset 0x3 - processor 0x2
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
cpufreq: writing 0x1 to pmbase 0x1000 + 0x50
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x1
cpufreq: change to 0 MHz succeded
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x1
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x1
cpufreq: writing 0x0 to pmbase 0x1000 + 0x50
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
cpufreq: change to 598 MHz succeded
cpufreq: read at pmbase 0x1000 + 0x50 returned 0x0
cpufreq: currently at high speed setting - 598 MHz
CPU clock: 598.500 MHz (731.500-598.500 MHz)

The low speed setting looks ok, but the high one is obviously wrong.
It's a 1.13Ghz CPU, /proc/cpuinfo lists it as this:

vendor_id	: GenuineIntel
cpu family	: 6
model		: 11
model name	: Intel(R) Pentium(R) III Mobile CPU      1133MHz
stepping	: 1
cpu MHz		: 1132.406
cache size	: 512 KB

The chipset in this machine is an Intel i830 chipset.  Let me know if
there's anything else useful I could do to provide further info.

				-- Gerald

