Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280664AbRKNPiC>; Wed, 14 Nov 2001 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280656AbRKNPfk>; Wed, 14 Nov 2001 10:35:40 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:49936 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S280665AbRKNPeF>; Wed, 14 Nov 2001 10:34:05 -0500
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Matt Bernstein" <matt@theBachChoir.org.uk>,
        "Arjan van de Ven" <arjanv@redhat.com>
Cc: "Alastair Stevens" <alastair.stevens@mrc-bsu.cam.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Date: Wed, 14 Nov 2001 07:33:28 -0800
Message-ID: <HBEHIIBBKKNOBLMPKCBBKEGJEBAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <Pine.LNX.4.33.0111141502110.8473-100000@nick.dcs.qmul.ac.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hard sums with big matrices? Are you using Atlas? It's tuned (or tunable)
for Athlons. There are some tricks -- you need to use the gcc 2.95.x
compiler; 2.96.x and 3.x apparently slow things down. But I've seen close to
peak rates on my 1.333 GHz Athlon Thunderbird with DDR RAM (1P Asus
motherboard, if it matters). In fact, if you can use 3DNOW2 arithmetic
without your answers going bogus on you, it's even better. Try

https://sourceforge.net/project/showfiles.php?group_id=23725

for the source.

--
"Suppose that tonight, while you sleep, a miracle happens - you wake up
tomorrow with what you have longed for. How will you discover that a miracle
happened? How will your loved ones? What will be different? What will you
notice? What do you need to explode into tomorrow with grace, power, love,
passion and confidence?" -- Michael Hall, PhD

M. Edward (Ed) Borasky
Relax! Run Your Own Brain with Neuro-Semantics!
http://www.borasky-research.net/Flyer.htm
mailto:znmeb@borasky-research.net
http://groups.yahoo.com/group/pdx-neuro-semantics


> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Matt Bernstein
> Sent: Wednesday, November 14, 2001 7:08 AM
> To: Arjan van de Ven
> Cc: Alastair Stevens; linux-kernel@vger.kernel.org
> Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
>
>
> At 14:55 -0000 Arjan van de Ven wrote:
>
> >Alastair Stevens wrote:
> >>
> >> Hi folks - I'm having real problems getting our new dual CPU server
> >> going. It's a 2x Athlon XP 1800+ on a Tyan mobo, AMD 760MP
> chipset, with
> >
> >Ehm you know that XP cpu's don't support SMP configuration ?
>
> I hope they do; I've just set up a very similar beast (looks like the same
> mobo and same CPUs). Is the RAM "registered" ECC? Are your CPUs the same
> stepping? One problem we were bitten by was the Radeon DRI, so we disabled
> it (in XF86Config-4) and it now seems to at least boot into X. However,
> it's not any faster than a dual PIII (1GHz) at the task it's meant to
> perform :( both CPUs report 75% usage, and vmstat 1 doesn't show the IO
> systems being slugged. Very strange. We're wondering if we've hit memory
> bandwidth as the tasks involve some hard sums with big matrices.
>
> $ cat /proc/cpuinfo
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 6
> model		: 6
> model name	: AMD Athlon(tm) Processor
> stepping	: 2
> cpu MHz		: 1526.519
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov
> pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips	: 3047.42
>
> processor	: 1
> vendor_id	: AuthenticAMD
> cpu family	: 6
> model		: 6
> model name	: AMD Athlon(tm) Processor
> stepping	: 2
> cpu MHz		: 1526.519
> cache size	: 256 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
> pge mca cmov
> pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips	: 3047.42
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

