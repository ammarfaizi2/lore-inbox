Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWFRMZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWFRMZe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWFRMZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:25:33 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38054 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932196AbWFRMZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:25:33 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16] 2.6.17-rc6 perfmon2 patch for review: new i386 files
Date: Sun, 18 Jun 2006 07:24:07 -0500
User-Agent: KMail/1.8.3
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Stephane Eranian <eranian@frankl.hpl.hp.com>
References: <200606180210_MC3-1-C2BF-E5CE@compuserve.com>
In-Reply-To: <200606180210_MC3-1-C2BF-E5CE@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606180724.08069.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun June 18 2006 1:07 am, Chuck Ebbert wrote:
> In-Reply-To: <200606150907.k5F97e7A008202@frankl.hpl.hp.com>
> On Thu, 15 Jun 2006 02:07:40 -0700, Stephane Eranian wrote:
> > --- linux-2.6.17-rc6.orig/arch/i386/perfmon/Kconfig   1969-12-31
> > 16:00:00.000000000 -0800 +++ linux-2.6.17-rc6/arch/i386/perfmon/Kconfig  
> >      2006-06-13 06:58:08.000000000 -0700 @@ -0,0 +1,48 @@
> > +menu "Hardware Performance Monitoring support"
> > +config PERFMON
> > +     bool "Perfmon2 performance monitoring interface"
> > +     select X86_LOCAL_APIC
> > +     default y
> > +     help
> > +       include the perfmon2 performance monitoring interface
> > +       in the kernel. See <http://perfmon2.sf.net/> for
> > +       more details. If you're unsure, say Y.
> > +
> > + config PERFMON_P6
> > +     tristate "Support for P6/Pentium M processor hardware performance
> > counters" +     depends on PERFMON
> > +     default m
> > +     help
> > +     Enables support for the P6-style hardware performance counters.
> > +     To be used for P6 processors (Pentium III, PentiumPro) and also
> > +     for Pentium M.
> > +     If unsure, say M.
> > +
> > +config PERFMON_P4
> > +     tristate "Support for 32-bit P4/Xeon hardware performance counters"
> > +     depends on PERFMON
> > +     default m
> > +     help
> > +     Enables support for the 32-bit P4/Xeon style hardware performance
> > +     counters.
> > +     If unsure, say M.
> > +
> > +config PERFMON_GEN_IA32
> > +     tristate "Support for the architected IA-32 PMU"
> > +     depends on PERFMON
> > +     default m
> > +     help
> > +     Enables support for the architected IA-32 hardware performance
> > counters. +     You need a Core Duo/Solo processor or newer for this
> > work. +     If unsure, say M.
> > +
> > +config PERFMON_P4_PEBS
> > +     tristate "Support for Intel P4 PEBS sampling format"
> > +     depends on PERFMON_P4
> > +     default m
> > +     help
> > +     Enables support for Precise Event-Based Sampling (PEBS) on the
> > Intel P4 +     processors which support it.  Does not work with P6
> > processors. +     If unsure, say m.
> > +
> > +endmenu
>
> What do I pick for i386 kernel on Athlon64 hardware?  P6?  There's no help
> for that (or Athlon/Sempron processors.)

P6 is only for Intel Pentium-Pro, Pentium-II, Pentium-III, and Pentium-M.

See arch/x86_64/perfmon/Kconfig for the config options for AMD Athlon64 and 
Intel EM64T.

I'm not sure if 32-bit Athlons are supported yet.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
http://evms.sourceforge.net/
