Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUCLAoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUCLAoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:44:21 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:7719 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261866AbUCLAoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:44:12 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Fri, 12 Mar 2004 00:42:32 +0000
User-Agent: KMail/1.6
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <200403120022.13534.richard@redline.org.uk> <Pine.LNX.4.58.0403111932400.29087@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0403111932400.29087@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403120042.32166.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 00:36, Zwane Mwaikambo wrote:
> On Fri, 12 Mar 2004, Richard Browning wrote:
> > > For my own curiosity, does switching the processors around do anything?
> > > Those MCEs look confined to the non bootstrap processor package.
> >
> > Switched CPUs. This time I get the following:
> >
> > CPU3: Machine Check Exception: 000.0004
> > CPU2: Machine Check Exception: 000.0004
> > Bank 0: a20000008c010400
> > Kernel Panic: CPU context corrupt
> > In idle task - not syncing
> >
> > Note that the CPU# designations are swapped and that there's only one
> > Bank 0: message. Is this significant?
>
> Ok, but that's still on the same package so it's not moving with the
> processor, thanks. Could you also supply processor info from
> /proc/cpuinfo.

I suppose that's good (for me); indicates no hardware error?

/proc/cpuinfo of course:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2807.537
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5537.79

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 7
cpu MHz         : 2807.537
cache size      : 512 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 5603.32

R
