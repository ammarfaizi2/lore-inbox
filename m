Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVHKQT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVHKQT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVHKQT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:19:57 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:40410 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932278AbVHKQT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:19:56 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: 7eggert@gmx.de, Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org,
       Coywolf Qi Hunt <coywolf@gmail.com>
In-Reply-To: <1123775508.17269.64.camel@localhost.localdomain>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 12:19:44 -0400
Message-Id: <1123777184.17269.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 11:51 -0400, Steven Rostedt wrote:
> 
> And booted it.  The system is up and running, so I really don't think
> that the sysenter_entry is used for system calls.  
> 
> Not so "Clear as day"!

And so, looking into sysenter_entry, it seems that my configurations
don't seem to use it. This jumps straight to system_call without ever
having to turn interrupts on.

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 367.939
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
mca cmov pat pse36 mmx fxsr sse
bogomips        : 722.94


-- Steve


