Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbTAOXfO>; Wed, 15 Jan 2003 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbTAOXfO>; Wed, 15 Jan 2003 18:35:14 -0500
Received: from air-2.osdl.org ([65.172.181.6]:1006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267476AbTAOXfK>;
	Wed, 15 Jan 2003 18:35:10 -0500
Subject: 2.5.58-dcl1
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1042674245.31201.430.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Jan 2003 15:44:05 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest version of the OSDL common and DCL specific patches.

The generic patches are for enhancements that are yet to make the
mainline kernel but are requested by both Carrier Grade Linux (CGL)
and Data Center Linux (DCL). 


The latest release is available in downloadable patches from
        http://sourceforge.net/projects/osdldcl

or public BitKeeper repositories
        Common code:            bk://bk.osdl.org/linux-2.5-osdl
        Common code + CGL:      bk://bk.osdl.org/linux-2.5-cgl
        Common code + DCL:      bk://bk.osdl.org/linux-2.5-dcl

The OSDL common includes RAS related enhancements, bugfixes, and 
latest version of drivers for the OSDL server test machines.
   Linux Trace Toolkit (LTT)	        (Karim Yaghmour)
   Linux Kernel Crash Dump (LKCD)	(Matt Robinson, LKCD team)
   Kernel Probes (kprobes)		(Rusty Russell)

   Megaraid 2 driver			(Matt Domsch)
   DAC960 driver			(Dave Olien)
	

The DCL-only patch applies after the first one (OSDL patch) and has
enhancements that are applicable mostly to NUMA systems used in 
data center systems.

The kernel compiles and runs on an UP and SMP system.  
The LTP, contest, and other benchmarks have been run using the OSDL
Scalable Test Platform.  LKCD has been tested for oops,
panic and NMI handling on SMP systems with preempt.
Kprobes has been exercised using the "noisy" test device.


New in this release:
. Bug fixes for sysfs with initrd	(Pat Mochel)
. Update to LKCD for multiple schemes	(Bharata B Rao)
. Bug fixes for LKCD locking		(me)
. Improved i386 fatal event notifiers   (me)
. Kprobe using notify_die               (me)

The DCL patch set is focused on projects related to large machines
typically used in the data center and benchmarking.

  NUMA scheduler		   (Eric Focht, Michael Hohnbaum)
  RCU statistics		   (Dipankar Sarma)
  Scheduler tunables		   (Robert Love)

New in this release:
  mini NUMA scheduler		   (Martin Bligh)


Plans:
-----
. Numa scheduler update
. Lock free xtime
. Cluster APIC support
. Improved APIC routing


Getting Involved
----------------
If interested in development of DCL, please subscribe to the mailing
list at http://lists.osdl.org/mailman/listinfo/dcl_discussion .

This kernel has been built and run on a small set of machines, SMP
and UP.  Testers are encouraged to exercise the features.  If a
problem is found, please compare the result with a standard 2.5.51
kernel.  Please report any problems or successes to the mailing list.

Developers are encouraged to send any enhancements or bug fix
patches.  Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.

Project information:
        http://www.osdl.org/projects/dcl/
        http://osdldcl.sourceforge.net
        http://sourceforge.net/projects/osdldcl



