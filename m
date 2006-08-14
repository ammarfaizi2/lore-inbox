Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWHNPT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWHNPT7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWHNPT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:19:58 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:21724 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1750790AbWHNPT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:19:58 -0400
Subject: Re: HT not active
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Aug 2006 17:19:47 +0200
Message-Id: <1155568787.2886.265.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 13:38 +0200, Jan Engelhardt wrote:
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


the "ht" flag does not mean what you think it means.....
it does NOT mean "I can use hyperthreading on this machine"; it
basically means "the ht cpuid commands work", so that linux can find the
nr of siblings, which can be..... 1
 
