Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268110AbSISNWW>; Thu, 19 Sep 2002 09:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268152AbSISNWV>; Thu, 19 Sep 2002 09:22:21 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:46324
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268110AbSISNWU>; Thu, 19 Sep 2002 09:22:20 -0400
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       johnstul@us.ibm.com, James Cleverdon <jamesclv@us.ibm.com>,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
In-Reply-To: <15753.45833.702405.2357@kim.it.uu.se>
References: <1032305535.7481.204.camel@cog>
	<20020917.163246.113965700.davem@redhat.com>
	<20020918015209.B31263@wotan.suse.de>
	<20020917.164649.110499262.davem@redhat.com>
	<20020918015838.A6684@wotan.suse.de>  <15753.45833.702405.2357@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 14:27:19 +0100
Message-Id: <1032442039.26712.32.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 12:20, Mikael Pettersson wrote:
>  > The local APIC timer is specified in the Intel Manual volume 3 for example.
>  > It's an optional feature (CPUID), but pretty much everyone has it.
> 
> Except that like everything else related to the local APIC, you're at
> the mercy of the competence (or lack thereof) of the BIOS implementors.
> - There are plenty of laptops whose CPUs have local APICs but whose
>   BIOSen go berserk if you enable it. There are also plenty of laptops

Frequently because we don't disable it again before any APM calls I
suspect. When a CPU goes into sleep mode you must disable PMC and local
apic timer interrupts.

>   that don't have one, since Intel removed it from many Mobile P6 CPUs.
> - There are even some desktop boards with BIOS problems, including Intel's
>   AL440LX on which Linux must stay away from the local APIC timer.
> 
> To assume the local APIC works on 686-class UP boxes is not realistic, alas.

Yep

