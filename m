Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130949AbRCJGv2>; Sat, 10 Mar 2001 01:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130950AbRCJGvT>; Sat, 10 Mar 2001 01:51:19 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:34067 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S130949AbRCJGvL>; Sat, 10 Mar 2001 01:51:11 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: dprobes@oss.lotus.com, linux-kernel@vger.kernel.org
Message-ID: <CA256A0B.0025892C.00@d73mta05.au.ibm.com>
Date: Sat, 10 Mar 2001 12:12:45 +0530
Subject: [ANNOUNCE] Dynamic Probes 2.0 released 
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Version 2.0 of the Dynamic Probes facility is now available at
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes

This release includes a new feature called "watchpoint probes" which
exploits hardware watchpoint capabilities of the underlying hardware
architecture to allow probing specific types of storage accesses.
Watchpoint probes are specified by the location (virtual address) and the
type of access (rw/w/x) on which the probe is fired.

This capability enables fine-grained storage profiling when Dprobes is used
in conjunction with LTT from Opersys as it permits tracing of memory read
and write access at specific locations.

Changes in this version:
----------------------------------
- New watchpoint probes feature allows probes to be fired on specific type
of memory accesses(execute|write|read or write|io), implemented using the
debug registers available on Intel x86 processors.
- New RPN instructions: divide/remainder and propagate bit/zero
instructions.
- Kernel data can now be referenced symbolically in the probe program
files.
- Memory logging instructions like "log mrf" now write the fault location
in the log buffer in case a page fault occurs when accessing the concerned
memory area.
- Log can now be optionally saved using the new keyword logonfault=yes even
 if the probed instruction faults.
- Bug fixes in the interpreter
     - validity check for the selector in segmented to flat address
conversion in case where the selector references the GDT.
     - log memory and log ascii functions now don't log if the logmax was
set to zero.


About Dprobes
-----------------------
Dprobes is a generic and pervasive non-interactive system debugging
facility designed to operate under the most extreme software conditions
such as debugging a deep rooted operating system problem in a live
environment. It allows the insertion of fully automated breakpoints or
probepoints, anywhere in the system and user space along with a  set of
probe instructions that are interpreted when a specific probe fires. These
instructions allow memory and CPU registers to be examined and altered
using conditional logic and a log to be generated.

Dprobes is currently available only on the IA32 platform.

An interesting aspect of Dprobes is that it allows the probe program to
conditionally trigger any external debugging facility that registers for
this purpose, e.g. crash dump, kernel debugger. Dprobes interfaces with
Opersys's LTT to provide a Universal Dynamic Trace facility.

For more information on DProbes please visit the dprobes homepage at
http://oss.software.ibm.com/developerworks/opensource/linux/projects/dprobes/



  Suparna Bhattacharya
  Linux Technology Center
  IBM Software Lab, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525







