Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319230AbSHUWYM>; Wed, 21 Aug 2002 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319231AbSHUWYM>; Wed, 21 Aug 2002 18:24:12 -0400
Received: from dial-3-30.emitel.hu ([194.149.57.30]:63366 "EHLO
	bazooka.enclave.net") by vger.kernel.org with ESMTP
	id <S319230AbSHUWYL>; Wed, 21 Aug 2002 18:24:11 -0400
Date: Wed, 21 Aug 2002 23:55:03 +0200
To: Kelsey Hudson <khudson@compendium.us>
Cc: James Bourne <jbourne@mtroyal.ab.ca>, Hugh Dickins <hugh@veritas.com>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
Message-ID: <20020821215503.GC1669@bazooka.saturnus.vein.hu>
References: <Pine.LNX.4.44.0208211242440.10117-100000@skuld.mtroyal.ab.ca> <Pine.LNX.4.44.0208211414190.6621-100000@betelgeuse.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208211414190.6621-100000@betelgeuse.compendium-tech.com>
User-Agent: Mutt/1.4i
From: Banai Zoltan <bazooka@emitel.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 02:16:11PM -0700, Kelsey Hudson wrote:
> On Wed, 21 Aug 2002, James Bourne wrote:
> 
> > On Wed, 21 Aug 2002, Hugh Dickins wrote:
> > 
> > > You do need CONFIG_SMP and a processor capable of HyperThreading,
> > > i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> > > just appropriate to that processor in other ways.
> > 
> > I was under the impression that the only CPU capable of hyperthreading was
> > the P4 Xeon.  Is this not correct?  I don't know of any other CPUs that
> > have the ht feature.
> 
> This is currently correct, although I believe Intel has plans to release a 
> Hyperthreading-capable version of its desktop P4. 

If this is correct, and there is not destop P4 capable of ht,
then what does mean the ht flag in cpuinfo?

$cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
stepping        : 2
cpu MHz         : 1694.907
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3381.65
                                                         ^^

> 
> > Also, looking at setup.c it's hard to determine if CONFIG_SMP is
> > actually required, but it doesn't look like it...
> 
> Of course it's required. How are you to take advantage of a "second CPU" 
> if your scheduler only works on a uniprocessor machine?
> 
> -- 
>  Kelsey Hudson                                       khudson@compendium.us
>  Software Engineer/UNIX Systems Administrator
>  Compendium Technologies, Inc                               (619) 725-0771
> ---------------------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Banai Zoltan
