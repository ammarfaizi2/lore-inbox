Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265497AbTF2AoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 20:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265498AbTF2AoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 20:44:13 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:15233
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S265497AbTF2AoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 20:44:08 -0400
Subject: Re: Linux 2.4.22-pre2 and AthlonMP?
From: Edward Tandi <ed@efix.biz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1056845040.2315.27.camel@wires.home.biz>
References: <1056833424.30265.39.camel@wires.home.biz>
	 <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk>
	 <1056840603.30264.45.camel@wires.home.biz>
	 <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
	 <1056845040.2315.27.camel@wires.home.biz>
Content-Type: text/plain
Message-Id: <1056848334.2332.6.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 29 Jun 2003 01:58:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The what processor thread...

On Sun, 2003-06-29 at 01:04, Edward Tandi wrote:
> On Sun, 2003-06-29 at 00:17, Alan Cox wrote:
> > On Sad, 2003-06-28 at 23:50, Edward Tandi wrote:
> > > > > using option 'pci=noacpi' or even 'acpi=off'
> > > > > Jun 28 18:27:46 machine kernel: BIOS failed to enable PCI standards
> > > > > compliance, fixing this error.
> > > > 
> > > > Start by upgrading to their current BIOS
> > > 
> > > Believe or not, it _is_ the latest bios for that board
> > > (Tyan S2460 BIOS v1.05, 2nd Jan 2003).
> > 
> > Then I guess you have a problem. We try and fix up BIOS problems but there
> > is a limit to what we can do, and if it has problems like the one that is
> > logged I'd be worried what else it might do - eg I suspect Nvidia 4x AGP cards
> > aren't too solid on it.
> > 
> > The APIC errors also suggest something isn't happy at all at the hardware
> > layer. Are you using MP processors ?
> 
> I have to admit, I have noticed something a little odd coming out of
> /proc/cpuinfo:
> 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) MP
> stepping        : 1
> cpu MHz         : 1194.690
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat
> pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 2385.51
>                                                                                 
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 6
> model name      : AMD Athlon(tm) Processor
> stepping        : 2
> cpu MHz         : 1194.690
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat
> pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips        : 2385.51
> 
> What confuses me here is how on earth the second processor reports
> itself without the "MP" bit and with a stepping of 2. They were
> identical processors when I put them in and I haven't touched them
> since. Is there any way this could be reported wrongly?

Further info on this, x86info gives the following results:

x86info v1.7.  Dave Jones 2001
Feedback to <davej@suse.de>.
 
Found 2 CPUs
CPU #1
Family: 6 Model: 6 Stepping: 1 [Athlon 4 (Palomino core) Rev A2]
Processor name string: AMD Athlon(tm) MP
 
PowerNOW! Technology information
Available features:
        Temperature sensing diode present.
 
CPU #2
Family: 6 Model: 6 Stepping: 2 [Athlon MP]
Processor name string: AMD Athlon(tm) Processor
 
PowerNOW! Technology information
Available features:
        Temperature sensing diode present.
 

It looks like the processors may have been from two different batches!
How bizarre. Should this make any difference?

Ed-T.


