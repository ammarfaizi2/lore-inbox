Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbTFKQPM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTFKQPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:15:12 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20711 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262703AbTFKQPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:15:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16103.22708.916304.319353@gargle.gargle.HOWL>
Date: Wed, 11 Jun 2003 18:28:36 +0200
From: mikpe@csd.uu.se
To: Timothy Miller <miller@techsource.com>
Cc: Steven Cole <elenstev@mesatop.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Samuel Flory <sflory@rackable.com>, John Appleby <john@dnsworld.co.uk>,
       xyko_ig@ig.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Wrong number of cpus detected/reported
In-Reply-To: <3EE7561C.9010202@techsource.com>
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
	<3EE64161.5010102@rackable.com>
	<1055279041.2270.42.camel@spc9.esa.lanl.gov>
	<1055280955.32661.35.camel@dhcp22.swansea.linux.org.uk>
	<1055281927.2269.47.camel@spc9.esa.lanl.gov>
	<16102.22713.50999.54138@gargle.gargle.HOWL>
	<3EE7561C.9010202@techsource.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller writes:
 > 
 > 
 > mikpe@csd.uu.se wrote:
 > > Steven Cole writes:
 > >  > On Tue, 2003-06-10 at 15:35, Alan Cox wrote:
 > >  > > > wp		: yes
 > >  > > > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
 > >  > > > bogomips	: 2798.38
 > >  > > > 
 > >  > > > See that ht flag near the end?
 > >  > > 
 > >  > > The ht flag means the ht facilities (mtrr etc) are present, doesnt mean
 > >  > > HT necessarily is
 > >  > 
 > >  > Is there a reliable method, apart from knowing 'a priori' the mapping
 > >  > from CPU models and stepping to hyperthreading capability?
 > > 
 > > Yes. Execute cpuid with eax=1 on each CPU. ebx describes among other things
 > > the number of threads and which thread you're on. If you ever find yourself
 > > on a non-zero thread, you have HT.
 > 
 > 
 > I presume, however, that to get into a non-zero thread, you have to turn 
 > HT on.  That is, when the machine first powers up, there is nothing for 
 > the second thread to execute, so it's turned off.  (I'm assuming 
 > something similar for SMP boxes.)  So, the real question should be, 
 > before you attempt to turn on HT, how do you find out whether or you CAN 
 > turn on HT.

If the CPUs can't do it at all, #threads < 2 by the definition of CPUID.

I don't know that happens to the CPUID #threads value if the CPUs are
HT-capable but BIOS has disabled HT. (I'm not going to reboot our
Dual Xeon just to check this.) Why does it matter? If people BIOS-disable
HT in their Xeon boxes they get what they deserve. (Which is not to
say that doing so is wrong. HT isn't always a gain.)
