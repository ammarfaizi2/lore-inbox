Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTATPwJ>; Mon, 20 Jan 2003 10:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTATPwJ>; Mon, 20 Jan 2003 10:52:09 -0500
Received: from [212.18.235.100] ([212.18.235.100]:22535 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S266175AbTATPwI> convert rfc822-to-8bit; Mon, 20 Jan 2003 10:52:08 -0500
Subject: Re: PROBLEM: Incorrect CPUs (Xeon 1.8 with HT) frequency ?
From: Justin Cormack <justin@street-vision.com>
To: "Andrey V. Ignatov" <andrey@emax.ru>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <62115845787.20030120183231@emax.ru>
References: <62115845787.20030120183231@emax.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Jan 2003 16:01:06 +0000
Message-Id: <1043078471.1428.13.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 15:32, Andrey V. Ignatov wrote:
> I think that kernel detect my CPUs not correctly. I have box with dual
> Xeon CPU 1.80GHz and HT feature. Kernel successfully found all 4
> virtual CPUs but frequency of each CPUs is incorrect as I mean.
> My system build on Intel® E7500 chipset.
> I try kernels : 2.4.20 & 2.4.21-pre3...
> Output from /proc/cpuinfo (for each processor the same):
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Xeon(TM) CPU 1.80GHz
> stepping        : 7
> cpu MHz         : 798.659
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 1592.52

Some BIOSs on the Xeon boards dont seem to set the multiplier right. Set
it by hand in the BIOS (as a multiple of real FSB ie 100 for 400MHz bus,
133 for 533 bus).

Justin


