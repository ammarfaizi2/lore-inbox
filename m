Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWJDPyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWJDPyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWJDPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:54:10 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6313 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161263AbWJDPyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:54:08 -0400
Subject: [ANNOUNCE] libhugetlbfs 1.0 released
From: Adam Litke <agl@us.ibm.com>
To: libhugetlbfs-devel@lists.sourceforge.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       nacc@us.ibm.com, "Steven J. Fox [imap]" <drfickle@us.ibm.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Wed, 04 Oct 2006 10:53:54 -0500
Message-Id: <1159977235.10255.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

libhugetlbfs-1.0 Released

After roughly one year in development, version 1.0 of libhugetlbfs is here.
It can be downloaded from SourceForge or the OzLabs mirror:

	http://sourceforge.net/project/showfiles.php?group_id=156936
	http://libhugetlbfs.ozlabs.org/snapshots/

=====================

What is libhugetlbfs?

In Linux, access to hugepages is provided through a virtual file
system, "hugetlbfs".  The libhugetlbfs library interface works with
hugetlbfs to provide more convenient specific application-level
services.  In particular libhugetlbfs has three main functions:

        * library functions
libhugetlbfs provides functions that allow an applications to
explicitly allocate and use hugepages more easily they could by
directly accessing the hugetblfs filesystem

        * hugepage malloc()
libhugetlbfs can be used to make an existing application use hugepages
for all its malloc() calls.  This works on an existing (dynamically
linked) application binary without modification.

        * hugepage text/data/BSS
libhugetlbfs, in conjunction with included special linker scripts can
be used to make an application which will store its executable text,
its initialized data or BSS, or all of the above in hugepages.  This
requires relinking an application, but does not require source-level
modifications.

This HOWTO explains how to use the libhugetlbfs library.  It is for
application developers or system administrators who wish to use any of
the above functions.

The libhugetlbfs library is a focal point to simplify and standardise
the use of the kernel API.

=====================


After a series of preview releases, we have tested a huge array of the
supported usage scenarios using benchmarks and real HPC applications.
Usability and reliability have greatly improved.  But... due to the
incredible diversity of applications that exist, there is bound to be a few
that will not work correctly.  

If using libhugetlbfs makes your application slower:

 * Play around with the different combinations of hugetlb malloc and the
   two different supported link types to see which combination works best.

 * Keep in mind that huge pages are a niche performance tweak and are not
   suitable for every type of application.  They are specifically known to
   hurt performance in certain situations.

If you experience problems:

 * You've already read the HOWTO document, but read through it again.  It
   is full of hints, notes, warnings, and caveats that we have found over
   time.  This is the best starting point for a quick resolution to your
   issue.

 * Make sure you have enough huge pages allocated.  Even if you think you
   have enough, try increasing it to a number you know you will not use.

 * Set HUGETLB_VERBOSE=99 and HUGETLB_DEBUG=yes.  These options increase
   the verbosity of the library and enable extra checking to help diagnose
   the problem.

If the above steps do not help, send as much information about the problem
(including all libhugetlbfs debug output) to
libhugetlbfs-devel@lists.sourceforge.net and we'll help out as much as we
can.  We will probably ask you to collect things like: straces,
/proc/pid/maps and gdb back traces.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

