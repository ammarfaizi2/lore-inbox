Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752009AbWHNLqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWHNLqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 07:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWHNLqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 07:46:16 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:54413 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752009AbWHNLqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 07:46:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MGHKzS4TdI7ejDLJHRYYCeXxvj7aB2H/KVgi5tT3hxS0H/FP3h7ZkkT4oVj+RwzsQxuUeXbBskTjbOxTNt4F2T3VrfipBkybaWOmjxLOVCqNl1aRsX+Ed3CON2Us8h0ZA88Q8k0NL/oNdmRPgROmCq93VwClCvz/ZuOt2N6pvEE=
Message-ID: <6bffcb0e0608140446i9508a27y75c234721e3e70d0@mail.gmail.com>
Date: Mon, 14 Aug 2006 13:46:14 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: HT not active
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 14/08/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> Hello list,
>
>
>
> I cannot get HT to be used on some machine:
>
> w04a# cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 0
> model name      : Intel(R) Pentium(R) 4 CPU 1700MHz
> stepping        : 10
> cpu MHz         : 1694.890
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
> bogomips        : 3393.46
>
> 'ht' indicates:
> #define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */
>
> so I installed an SMP kernel, which has
> CONFIG_SMP=y
> CONFIG_SUSPEND_SMP=y
> CONFIG_X86_FIND_SMP_CONFIG=y
> CONFIG_SCHED_SMT=y
> CONFIG_X86_HT=y
>
> yet it shows the 'up' flag in cpuinfo
> #define X86_FEATURE_UP          (3*32+ 9) /* smp kernel running on up */
>
> What could be missing? Some BIOS option perhaps?
> Thanks for any hints.

Do you have CONFIG_NR_CPUS=2 in kernel config?

>
>
> Jan Engelhardt
> --

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
