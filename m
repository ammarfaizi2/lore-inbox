Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbTGDSra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266122AbTGDSra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 14:47:30 -0400
Received: from 82-43-130-207.cable.ubr03.mort.blueyonder.co.uk ([82.43.130.207]:46221
	"EHLO efix.biz") by vger.kernel.org with ESMTP id S266119AbTGDSrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 14:47:20 -0400
Subject: Re: Linux 2.4.22-pre2 and AthlonMP?
From: Edward Tandi <ed@efix.biz>
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <1056848334.2332.6.camel@wires.home.biz>
References: <1056833424.30265.39.camel@wires.home.biz>
	 <1056837060.6778.2.camel@dhcp22.swansea.linux.org.uk>
	 <1056840603.30264.45.camel@wires.home.biz>
	 <1056842271.6753.19.camel@dhcp22.swansea.linux.org.uk>
	 <1056845040.2315.27.camel@wires.home.biz>
	 <1056848334.2332.6.camel@wires.home.biz>
Content-Type: text/plain
Message-Id: <1057345339.2349.81.camel@wires.home.biz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 04 Jul 2003 20:02:19 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-29 at 01:58, Edward Tandi wrote:
> The what processor thread...

For purely academic interest, and to satisfy my own curiosity, I have
pulled the two processors out of the box to examine their markings.
Here they are:


Processor 1
-----------
| AHX1200AMS3C == Athlon MP 1200MHz (0.18um), CPGA package, 1.75V, 95'C
max temp, 256K L2 cache, 266MHz max bus speed.

| AGKGA 0137MPMW
Athlon XP Palomino core, manufactured 37th week of the year 2001.


Processor 2
-----------
| AHX1200AMS3C == Athlon MP 1200MHz (0.18um), CPGA package, 1.75V, 95'C
max temp, 256K L2 cache, 266MHz max bus speed.

| AGHCA 0129CPAW
Unknown core, manufactured 29th week of the year 2001.


So although they look identical, have the same model number and were
produced only 8 weeks apart, they really do have a different stepping
(and core) identifier. I couldn't find what the AGHCA corresponded to.

Ed-T.


> > I have to admit, I have noticed something a little odd coming out of
> > /proc/cpuinfo:
> > 
> > processor       : 0
> > vendor_id       : AuthenticAMD
> > cpu family      : 6
> > model           : 6
> > model name      : AMD Athlon(tm) MP
> > stepping        : 1
> > cpu MHz         : 1194.690
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat
> > pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips        : 2385.51
> >                                                                                 
> > processor       : 1
> > vendor_id       : AuthenticAMD
> > cpu family      : 6
> > model           : 6
> > model name      : AMD Athlon(tm) Processor
> > stepping        : 2
> > cpu MHz         : 1194.690
> > cache size      : 256 KB
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 1
> > wp              : yes
> > flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
> > cmov pat
> > pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips        : 2385.51
> > 
> > What confuses me here is how on earth the second processor reports
> > itself without the "MP" bit and with a stepping of 2. They were
> > identical processors when I put them in and I haven't touched them
> > since. Is there any way this could be reported wrongly?
> 
> Further info on this, x86info gives the following results:
> 
> x86info v1.7.  Dave Jones 2001
> Feedback to <davej@suse.de>.
>  
> Found 2 CPUs
> CPU #1
> Family: 6 Model: 6 Stepping: 1 [Athlon 4 (Palomino core) Rev A2]
> Processor name string: AMD Athlon(tm) MP
>  
> PowerNOW! Technology information
> Available features:
>         Temperature sensing diode present.
>  
> CPU #2
> Family: 6 Model: 6 Stepping: 2 [Athlon MP]
> Processor name string: AMD Athlon(tm) Processor
>  
> PowerNOW! Technology information
> Available features:
>         Temperature sensing diode present.


