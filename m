Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVHKQep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVHKQep (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVHKQep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:34:45 -0400
Received: from nproxy.gmail.com ([64.233.182.206]:50586 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751046AbVHKQeo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:34:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SpjXXUxPwnLb950Dmlkn3GxWXq1eE+GqEwbdTpK9mvAJopga5lT3OMyYAfc5cLCQjrE3jMbb5KWJj0n1lYQ6KsL3Y9XNTt33XMRBLh+QF9KG0bNz13Rf050Ucl3GBGBUeA+HRj5W7d9/N4p7Nrz2WTFM+nEzpdYASeFKSo7/GJk=
Message-ID: <2cd57c90050811093112a57982@mail.gmail.com>
Date: Fri, 12 Aug 2005 00:31:52 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Need help in understanding x86 syscall
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1123777184.17269.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 2005-08-11 at 11:51 -0400, Steven Rostedt wrote:
> >
> > And booted it.  The system is up and running, so I really don't think
> > that the sysenter_entry is used for system calls.
> >
> > Not so "Clear as day"!
> 
> And so, looking into sysenter_entry, it seems that my configurations
> don't seem to use it. This jumps straight to system_call without ever
> having to turn interrupts on.
> 
> # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 3
> cpu MHz         : 367.939
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse
> bogomips        : 722.94
> 
> 
> -- Steve
> 

The cpu does have sep. Is it vanilla kernel?

-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
