Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263582AbREYGd3>; Fri, 25 May 2001 02:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263583AbREYGdT>; Fri, 25 May 2001 02:33:19 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:61454 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S263582AbREYGdK>;
	Fri, 25 May 2001 02:33:10 -0400
Date: Fri, 25 May 2001 02:35:58 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: Configure.help entries wanted
Message-ID: <20010525023558.B5622@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010525012200.A5259@thyrsus.com> <23530.990770596@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23530.990770596@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, May 25, 2001 at 04:03:16PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> I claim my erudition prize (do I get steak knives with that?).

Results doubtful.  Consult Magic 8-Ball again :-).

I'm going to critique these individually pour encourager les autres.

> +Disable IA-64 Virtual Hash Page Table
> +CONFIG_DISABLE_VHPT
> +  The Virtual Hash Page Table (VHPT) enhances virtual address
> +  translation performance.  Normally you want the VHPT active but you
> +  can select this option to disable the VHPT for debugging.  If you're
> +  unsure, answer N.

Excellent!  Second sentence a good example of motivation.

> +McKinley A-step specific code
> +CONFIG_MCKINLEY_ASTEP_SPECIFIC
> +  Select this option to build a kernel for an IA64 McKinley system
> +  with any A-stepping CPU.
> +
> +McKinley A0/A1-step specific code
> +CONFIG_MCKINLEY_A0_SPECIFIC
> +  Select this option to build a kernel for an IA64 McKinley system
> +  with an A0 or A1 stepping CPU.

Ah, now I could have written these.  What I was hoping for was extra
information analogous to what's in these:

Enable Itanium B-step specific code
CONFIG_ITANIUM_BSTEP_SPECIFIC
  Select this option to build a kernel for an Itanium prototype system
  with a B-step CPU.  You have a B-step CPU if the "revision" field in
  /proc/cpuinfo has a value in the range from 1 to 4.

Enable Itanium B0-step specific code
CONFIG_ITANIUM_B0_SPECIFIC
  Select this option to build a kernel for an Itanium prototype system
  with a B0-step CPU.  You have a B0-step CPU if the "revision" field in
  /proc/cpuinfo is 1.

Is there a value range in /proc/cpuinfo that tells you you have an A/A0 step?

> +IA64 compare-and-exchange bug checking
> +CONFIG_IA64_DEBUG_CMPXCHG
> +  Selecting this option turns on bug checking for the IA64
> +  compare-and-exchange instructions.  This is slow!  If you're unsure,
> +  select N.
> +
> +IA64 IRQ bug checking
> +CONFIG_IA64_DEBUG_IRQ
> +  Selecting this option turns on bug checking for the IA64 irq_save and
> +  restore instructions.  This is slow!  If you're unsure, select N.

These would be much improved by some indication of what IA64 variants or mask
steppings have these problems.

> +IA64 Early printk support
> +CONFIG_IA64_EARLY_PRINTK
> +  Selecting this option uses the VGA screen for printk() output before
> +  the consoles are initialised.  It is useful for debugging problems
> +  early in the boot process, but only if you have a VGA screen
> +  attached.  If you're unsure, select N.

Good!

> +IA64 Print Hazards
> +CONFIG_IA64_PRINT_HAZARDS
> +  Selecting this option prints more information for Illegal Dependency
> +  Faults, that is, for Read after Write, Write after Write or Write
> +  after Read violations.  This option is ignored if you are compiling
> +  for an Itanium A step processor (CONFIG_ITANIUM_ASTEP_SPECIFIC).  If
> +  you're unsure, select Y.

Excellent!

This is a fine start.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"If I must write the truth, I am disposed to avoid every assembly 
of bishops; for of no synod have I seen a profitable end, but
rather an addition to than a diminution of evils; for the love 
of strife and the thirst for superiority are beyond the power 
of words to express."
	-- Father Gregory Nazianzen, 381 AD
