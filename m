Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265706AbSISLPy>; Thu, 19 Sep 2002 07:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266651AbSISLPy>; Thu, 19 Sep 2002 07:15:54 -0400
Received: from kim.it.uu.se ([130.238.12.178]:10926 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S265706AbSISLPx>;
	Thu, 19 Sep 2002 07:15:53 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15753.45833.702405.2357@kim.it.uu.se>
Date: Thu, 19 Sep 2002 13:20:41 +0200
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, johnstul@us.ibm.com,
       jamesclv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
In-Reply-To: <20020918015838.A6684@wotan.suse.de>
References: <1032305535.7481.204.camel@cog>
	<20020917.163246.113965700.davem@redhat.com>
	<20020918015209.B31263@wotan.suse.de>
	<20020917.164649.110499262.davem@redhat.com>
	<20020918015838.A6684@wotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Tue, Sep 17, 2002 at 04:46:49PM -0700, David S. Miller wrote:
 > >    From: Andi Kleen <ak@suse.de>
 > >    Date: Wed, 18 Sep 2002 01:52:09 +0200
 > > 
 > >    On Tue, Sep 17, 2002 at 04:32:46PM -0700, David S. Miller wrote:
 > >    > I know full well it isn't currently :-)
 > >    
 > >    Sorry, it's wrong. The x86 architecture has several such registers
 > > 
 > > Not in the processor, and not architectually specified.
 > > 
 > > All of the things you list are in the scope of things outside
 > > the cpu.
 > 
 > The local APIC timer is specified in the Intel Manual volume 3 for example.
 > It's an optional feature (CPUID), but pretty much everyone has it.

Except that like everything else related to the local APIC, you're at
the mercy of the competence (or lack thereof) of the BIOS implementors.
- There are plenty of laptops whose CPUs have local APICs but whose
  BIOSen go berserk if you enable it. There are also plenty of laptops
  that don't have one, since Intel removed it from many Mobile P6 CPUs.
- There are even some desktop boards with BIOS problems, including Intel's
  AL440LX on which Linux must stay away from the local APIC timer.

To assume the local APIC works on 686-class UP boxes is not realistic, alas.

/Mikael
