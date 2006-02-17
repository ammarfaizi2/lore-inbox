Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWBQVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWBQVGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWBQVGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:06:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46469 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751798AbWBQVGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:06:41 -0500
Date: Fri, 17 Feb 2006 22:06:35 +0100
From: Heinz Mauelshagen <mauelshagen@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: *** Announcement: dmraid 1.0.0.rc10 ***
Message-ID: <20060217210635.GA13074@redhat.com>
Reply-To: mauelshagen@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


               *** Announcement: dmraid 1.0.0.rc10 ***

dmraid 1.0.0.rc10 is available at
http://people.redhat.com/heinzm/sw/dmraid/ in source tarball,
source rpm and i386 rpm (with shared and static binary).

This release adds support for Adaptec HostRAID and JMicron JMB36X
(see CHANGELOG below for more information).


dmraid (Device-Mapper RAID tool) discovers, [de]activates and displays
properties of software RAID sets (i.e. ATARAID) and contained DOS
partitions using the device-mapper runtime of the 2.6 kernel.

The following ATARAID types are supported on Linux 2.6:

Adaptec HostRAID ASR
Highpoint HPT37X
Highpoint HPT45X
Intel Software RAID
JMicron JMB36X
LSI Logic MegaRAID
NVidia NForce
Promise FastTrack
Silicon Image Medley
VIA Software RAID

Please provide insight to support those metadata formats completely.

Thanks.


See files README, which comes with the source tarball for
prerequisites to run this software, further instructions on installing
and using dmraid!


Call for testers:
-----------------

I need testers with the above ATARAID types, to check that the mapping
created by this tool is correct (see options "-t -ay") and access to the
ATARAID data is proper.

In case you have a different ATARAID solution from those listed above,
please feel free to contact me about supporting it in dmraid.

You can activate your ATARAID sets without danger of overwriting
your metadata, because dmraid accesses it read-only unless you use
option -E together with -r in order to erase ATARAID metadata
(see 'man dmraid')!

This is a release candidate version so you want to have backups of your valuable
data *and* you want to test accessing your data read-only first in order to
make sure that the mapping is correct before you go for read-write access.


Contacts:
---------

The author is reachable at <Mauelshagen@RedHat.com>.

For test results, mapping information, discussions, questions, patches,
enhancement requests and the like, please subscribe and mail to
<ataraid-list@redhat.com>.

--

Regards,
Heinz    -- The LVM Guy --


Changelog from dmraid 1.0.0.rc9 to 1.0.0.rc10		2006.02.17

FIXES:
------
o metadata.c: want_set() didn't drop sets properly
              (eg, jmicron_raid10 wanted and jmicron_raid1 not dropped)

o scsi.c: avoid retrieving too much data (Al Viro)

o sil.h: magic number fix (some arrays were not recognized)

FEATURES:
---------
o added libdmraid_make_table() to activate.c to be used by installer

o asr.[ch]: added Adaptec HostRAID support

o jm.[ch]: added JMicron JMB36x support

o added '--enable-libselinux' to configure for those who want
  to build without it

o bytorder.h: enhanced to support big endian conversion
              on little endian arch

o nv.c: support RAID5 with dm-raid45 target

o pdc.h: support additional metadata offset

o metadata.c: enhanced to support RAID4 and RAID5 mappings with dm-raid45 target


MISCELANIOUS:
-------------
o misc.c: streamlined remove_white_space() (Al Viro)



=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Red Hat GmbH
Consulting Development Engineer                   Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@RedHat.com                            +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
