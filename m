Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbUCRUxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262956AbUCRUxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:53:47 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:9406 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S262944AbUCRUxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:53:44 -0500
From: Mark <mark@harddata.com>
Organization: Hard Data Ltd
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Dual Athlon CPU detection..
Date: Thu, 18 Mar 2004 13:52:34 -0700
User-Agent: KMail/1.6
References: <4059FCB9.4070204@lbl.gov>
In-Reply-To: <4059FCB9.4070204@lbl.gov>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403181352.34737.mark@harddata.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 18, 2004 12:47 pm, Thomas Davis <tadavis@lbl.gov> wrote:
> I'm getting this in my /proc/cpuinfo:
>
> [tdavis@lanshark tdavis]$ more /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Athlon(tm) MP 2200+
> stepping        : 0
> cpu MHz         : 1800.902
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips        : 3547.13
>
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 8
> model name      : AMD Athlon(tm) Processor
> stepping        : 0
> cpu MHz         : 1800.902
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips        : 3596.28
> [tdavis@lanshark tdavis]$ uname -a
> Linux lanshark.nersc.gov 2.6.4-rc1-mm1 #1 SMP Tue Mar 2 14:09:44 PST 2004
> i686 athlon i386 GNU/Linux
>
>
> Is this a bad CPU, or a kernel bug?

AFAIK this information comes from the Bios. Some bioses don't verify that the 
second CPU as being an MP. It's been known for some time. Some people were 
using this to run 1 MP and 1 XP to save money on processors. However if you 
were to update your bios, it might start checking both for being MPs. 
Original bioses didn't even check for the first processor at one time but AMD 
complained and the bioses were modified.

-- 
Mark Lane, CET mailto:mark@harddata.com 
Hard Data Ltd. http://www.harddata.com 
T: 01-780-456-9771   F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--
