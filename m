Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbTILTIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTILTIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:08:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44993 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261860AbTILTHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:07:36 -0400
Date: Fri, 12 Sep 2003 21:07:28 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030912190728.GN27368@fs.tum.de>
References: <20030911062816.GX27368@fs.tum.de> <Pine.GSO.3.96.1030911134447.28174B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030911134447.28174B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 02:10:43PM +0200, Maciej W. Rozycki wrote:
> On Thu, 11 Sep 2003, Adrian Bunk wrote:
> 
> > - X86_GOOD_APIC: Are there really that many processors with a bad APIC?
> 
>  Only early revisions of the P54C (75-200MHz) Pentium processors are
> affected: steppings B1, B3, B5, C2 and cB1 (or 1, 2, 4, 5 and 11) as
> reported by cpuid).  MMX Pentia and later chips are OK as well as any
> systems using external i82489DX APICs (so far i486, P5 (60/66MHz) Pentium
> and P54C Pentium systems with i82489DX APICs has been found, AFAIK).  Once
> I proposed the option to be user-selectable as an advanced CPU option
> (<asm/bugs.h> does appropriate validation), but the proposal was rejected
> as incomprehesible to an average user doing a kernel build. 

[
My questions might sound silly - I simply don't have the x86
knowledge, but I want to get the dependencies as good as possible.
]

All Cyrix/VIA/IDT/Transmeta processors have a working APIC?

What about the original 386?

Then I can simply change it in my patch to

config X86_GOOD_APIC
        bool
	depends on !CPU_586TSC
	default y

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

