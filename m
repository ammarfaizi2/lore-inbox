Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbWHNMGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbWHNMGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWHNMGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:06:54 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65245 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751635AbWHNMGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:06:54 -0400
Date: Mon, 14 Aug 2006 14:06:46 +0200 (MEST)
Message-Id: <200608141206.k7EC6kwR023320@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
Subject: Re: HT not active
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 13:38:22 +0200 (MEST), Jan Engelhardt wrote:
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
...
> What could be missing? Some BIOS option perhaps?

The HT cpuid capability flag does not imply that HT actually is present.
You also have to count #siblings. See Intel's IA32 SDM Vol3 for details.

There are often BIOS options to enable or disable HT. However, your model 0
P4 is quite old and probably doesn't have HT.
