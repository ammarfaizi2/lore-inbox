Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUGOUgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUGOUgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 16:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUGOUgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 16:36:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40344 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266223AbUGOUf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 16:35:56 -0400
Date: Thu, 15 Jul 2004 22:35:53 +0200
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: *** Announcement: dmraid 1.0.0-rc2 ***
Message-ID: <20040715203553.GA18640@redhat.com>
Reply-To: mauelshagen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


               *** Announcement: dmraid 1.0.0-rc2 ***

Following a good tradition, dmraid 1.0.0-rc2 is available at
http://people.redhat.com:/~heinzm/sw/dmraid/ in source and i386 rpm,
before I leave for a 2 weeks vacation trip followed by LWE ;)

Won't read my email before July, 30th.

dmraid (Device-Mapper Raid tool) discovers, [de]activates and displays
properties of software RAID sets (ie. ATARAID) and contained DOS
partitions using the device-mapper runtime of the 2.6 kernel.

The following ATARAID types are supported on Linux 2.6:

Highpoint HPT37X
Highpoint HPT45X
Intel Software RAID
Promise FastTrack
Silicon Image Medley

This ATARAID type can be discovered only in this version:
LSI Logic MegaRAID

Please provide insight to support those metadata formats completely.

Thanks.

See files README and CHANGELOG, which come with the source tarball for
prerequisites to run this software, further instructions on installing
and using dmraid!

CHANGELOG is contained below for your convenience as well.


Call for testers:
-----------------

I need testers with the above ATARAID types, to check that the mapping
created by this tool is correct (see options "-t -ay") and access to the ATARAID
data is proper.

You can activate your ATARAID sets without danger of overwriting
your metadata, because dmraid accesses it read-only unless you use
option -E with -r in order to erase ATARAID metadata (see 'man dmraid')!

This is a release candidate version so you want to have backups of your valuable
data *and* you want to test accessing your data read-only first in order to
make sure that the mapping is correct before you go for read-write access.


The author is reachable at <Mauelshagen@RedHat.com>.
Later, I told you ;)

For test results, mapping information, discussions, questions, patches,
enhancement requests and the like, please subscribe and mail
to <ataraid@redhat.com>.

CHANGELOG:
---------

Changelog from dmraid 1.0.0-rc1 to 1.0.0-rc2		2004.07.15

o Intel Software RAID discovery and activation support
o allow more than one format handler name with --format
o display "raid10" sets properly rather than just "mirror"
o enhanced activate.c to handle partial activation of sets (eg, degraded RAID0)
o enhanced command line option checks
o implemented a library context for variables such as debug etc.
o fixed memory leak in discover_partitions
o fixed recursion in _find_set()
o continued writing subsets in case we fail on one because of RAID1
o format handler template update
o fixed dietlibc build
o fixed shared library configure
o use default_list_set() instead of &raid_sets where possible
o name change of list_head members to the more commonly used 'list'
o renamed msdos partition format handler to dos
o lots of inline comments corrected/updated
o streamlined tools/*.[ch]
o moved get.*level() and get_status to metadata.[ch] and changed level
  name to type

--

Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
