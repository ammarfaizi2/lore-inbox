Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263241AbSJVXmV>; Tue, 22 Oct 2002 19:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263246AbSJVXmU>; Tue, 22 Oct 2002 19:42:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25274 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263241AbSJVXmP>;
	Tue, 22 Oct 2002 19:42:15 -0400
Subject: Linux 2.5.44-dcl1
From: Stephen Hemminger <shemminger@osdl.org>
To: Kernel List <linux-kernel@vger.kernel.org>
Cc: cgl_discussion@osdl.org, evms-devl@lists.sourceforge.net,
       lkcd-general@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 16:48:24 -0700
Message-Id: <1035330504.1186.110.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OSDL development platform is a conduit for testing patches to the
latest Linux kernel. It (hopefully) follows the standard process model
of open source cooperative development. The goal is to provide
feedback to wider feedback and testing to developers creating Linux
solutions for enterprise systems.

The latest release is available on SourceForge 
   http://sourceforge.net/projects/osdldcl 
and the OSDL Patch Lifecycle Manager (PLM) patch ID #893
    http://www.osdl.org/cgi-bin/plm/  
or public BitKeeper repository is bk://bk.osdl.org/dcl-2.5

The first set of patches focuses mostly on data center issues (DCL)
with some carrier grade (CGL) related items. It is based on Linux
2.5.44 with the following additions: 

 * Trivial build related fixes:
	Fix net/ipv4/raw.c build problem	(many)
	Fix qlogic1280 build 			(Jens Axboe)
	Fix megaraid build			(Mike Anderson, Matt Domsch)
	Fix scsi shutdown			(Patric Mansfield)
	
 * Linux Kernel Crash Dump (LKCD)
	Matt Robinson <yakker@aparity.com>

 * Enterprise Volume Manager (EVMS) 
	Mark Peloquin, Steve Pratt, Kevin Corry
	peloquin@us.ibm.com, slpratt@us.ibm.com, corryk@us.ibm.com
	evms-devel@lists.sourceforge.net
	http://www.sourceforge.net/projects/evms/

 * NUMA scheduler enhancements
	Michael Hohnbaum <hohnbaum@us.ibm.com>

 * Kernel Config storage
        Khalid Aziz <khalid@hp.com>
	Randy Dunlap <rddunlap@osdl.org>

 * DAC960 driver fixes
	Dave Olien <dmo@osdl.org>

Getting Involved
----------------
If interested in development of DCL, please subscribe to dcl_discussion
mailing list at http://lists.osdl.org/mailman/listinfo

This kernel has been built and run on a small set of machines, SMP
and UP. Testers are encouraged to exercise the features especially on
large SMP and NUMA architectures.  If a problem is found, please
compare the result with a standard 2.5.44 kernel.  Please report any
problems or successes to the mailing list.

Developers are encouraged to send any enhancements or bug fixes
patches. Patches should be tested by using the OSDL Scalable Test
Platform (STP) and Patch Lifecycle Manager (PLM) facilities.

STP Test Requests:
ID #	Status	Patch	Test		Host	Completion Date 
=================================================================
6619    running   893	VM_regress	stp4-001
6618	running   893	dbench-quick	stp4-003
6616	queued	  893	LTP
6607	queued	  892	dbt1-1tier
6606	failed	  892	LTP		stp2-000 2002-10-22 14:38:37
	- bug in megaraid (fixed)
6605	completed 892	contest		stp1-000 2002-10-22 16:04:15
6604	failed	  892	dbench-quick	stp2-001 2002-10-22 14:44:46
	- bug in qla1280 (fixed)
6601	completed 890	lmbench_short	stp1-000 2002-10-22 13:57:33


Future plans
------------
This development platform will be released on a frequent basis and
kept up to date with Linux 2.5/2.6 kernel releases.  

Planned features in the short term are:

* Add vsyscall gettimeofday
  - currently deferred because doesn't work with kernel symbols enabled
  - breaks User Mode Linux (UML) so needs to be configurable

* IPC locking enhancement
  - current patch needs more review 

* Shared page tables (from -mm tree)
  - needed for large Oracle
  - current code may not stable enough for general use

* Hires timers
  - may get picked up by baseline kernel anyway

* Testing on large databases

* NUMA testing

Please see the CGL and DCL sections of http://osdl.org for a more
complete list of requirements.








