Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752016AbWHNMK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbWHNMK0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 08:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbWHNMK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 08:10:26 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:21298 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1752016AbWHNMK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 08:10:26 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HT not active 
In-reply-to: Your message of "Mon, 14 Aug 2006 13:38:22 +0200."
             <Pine.LNX.4.61.0608141335550.7970@yvahk01.tjqt.qr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 22:10:25 +1000
Message-ID: <9327.1155557425@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt (on Mon, 14 Aug 2006 13:38:22 +0200 (MEST)) wrote:
>Hello list,
>
>
>
>I cannot get HT to be used on some machine:
>
>w04a# cat /proc/cpuinfo 
>processor       : 0
>vendor_id       : GenuineIntel
>cpu family      : 15
>model           : 0
>model name      : Intel(R) Pentium(R) 4 CPU 1700MHz
>stepping        : 10
>cpu MHz         : 1694.890
>cache size      : 256 KB
>fdiv_bug        : no
>hlt_bug         : no
>f00f_bug        : no
>coma_bug        : no
>fpu             : yes
>fpu_exception   : yes
>cpuid level     : 2
>wp              : yes
>flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
>cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
>bogomips        : 3393.46
>
>'ht' indicates:
>#define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */                 
>
>so I installed an SMP kernel, which has
>CONFIG_SMP=y
>CONFIG_SUSPEND_SMP=y
>CONFIG_X86_FIND_SMP_CONFIG=y
>CONFIG_SCHED_SMT=y
>CONFIG_X86_HT=y
>
>yet it shows the 'up' flag in cpuinfo
>#define X86_FEATURE_UP          (3*32+ 9) /* smp kernel running on up */
>
>What could be missing? Some BIOS option perhaps?
>Thanks for any hints.

It could be BIOS HT settings.  You could also need CONFIG_ACPI, I have
seen HT systems which required ACPI before Linux could see the extra
threads.

