Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277700AbRJVTLJ>; Mon, 22 Oct 2001 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277692AbRJVTLA>; Mon, 22 Oct 2001 15:11:00 -0400
Received: from air-1.osdl.org ([65.201.151.5]:40966 "EHLO water.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S277708AbRJVTKs>;
	Mon, 22 Oct 2001 15:10:48 -0400
From: Nathan Dabney <smurf@osdlab.org>
Date: Mon, 22 Oct 2001 12:08:09 -0700
To: linux-kernel@vger.kernel.org
Subject: (STP) automated Kernel testing
Message-ID: <20011022120809.D17527@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Here at the OSDL we have been working on an automated testing system for the
Linux kernel.  The hope is to provide a full framework for environment 
documentation, test configuration, execution and report presentation. 

  Currently we have a working implementation available at:

http://www.osdlab.org/stp 

We are calling this project the "Scalable Test Platform" or "STP".

The following tests are available (keep in mind, this is early-phase material):

  bash-memory
  UNIXbench
  lmbench (both with or without memory test options)
  bonnie++ (includes various runs for file sizes and number-of-files stress)
  dbench (short run of samples from 1-100 clients and a long run for graphing)

We are working on:

  LTP tests (not the full suite, but a large portion)
  iozone
  AIM
  More bonnie++ tests
  Methods to test varying file systems
  The ability to run tests requiring more than one host (i.e. client/server)
  Automatic patch generator (to include patches with response reports)

We maintain a kernel CVS repository available at khack.osdlab.org:/var/cvs 
as anonymous (via pserver) with write access (via ssh) available upon request.

The way the system works is a developer checks their patch into their own 
development tree in our kernel CVS repository and tags it.  Then, using the
web interface the developer requests what test to run, points it at the kernel
tag and specifies what type of machine to execute the test on.  After that
point the entire process is automated and when it's completed the user will
receive a EMail notifying them their test has completing and possibly 
including a summary of the results (if that feature is supported by the
particular test).

Currently we have multiple 2, 4 and 8 way machines up and running.  We have a
load of single processor machines to add to the group within (hopefully) the 
next week.

Sample test runs against 2.4.12 are available at:

dbench long:
2-way: http://fire.osdlab.org/stp/results/38/
4-way: http://fire.osdlab.org/stp/results/39/
8-way: http://fire.osdlab.org/stp/results/40/

UNIXbench:
4-way: http://fire.osdlab.org/stp/results/41/

lmbench (with memory test):
2-way: http://fire.osdlab.org/stp/results/36/

Bonnie++:
4-way: http://fire.osdlab.org/stp/results/46/

We are highly interested in comments regarding the user interface, the 
environment documentation data gathered and possible enhancements to the 
system.  If you have a moment, please look at some of the above tests and
let me know what additional information would be useful.

The SourceForge project for the STP framework is available at:

http://www.sourceforge.net/projects/stp

The system is available for OSDL associates (free quick sign up - no spam) who
want to do Linux kernel testing.  Please let me know if you would like access
to the CVS repository.

Thanks,
Nathan Dabney
Open Source Development Lab

