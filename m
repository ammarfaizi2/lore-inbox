Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVLBAKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVLBAKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbVLBAKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:10:04 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:33370 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932574AbVLBAKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:10:03 -0500
Subject: core-iSCSI project stack v1.6.2.0 & tools v3.0
From: "Nicholas A. Bellinger" <nab@kernel.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 01 Dec 2005 16:04:58 -0800
Message-Id: <1133481898.22350.20.camel@haakon>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings All!

After months of discussion and anticipation, I am pleased to announce
the latest stable release from the core-iscsi project sponsored by SBEi,
Inc.  The main goal behind this release is to encourage the adoption of
RFC-3720 on Linux by abstracting away implementation dependant iSCSI
Initiator stack complexity from configuration, management and general
day-to-day administration involved with a iSCSI SAN for the average
Linux/iSCSI user.  The end result is a set of stable and accepted
configuration files and management scripts that allow multiple iSCSI
stacks to be run, transparently to the end user.  This is achieved by
separating discussions into two major iSCSI 'building blocks' that each
itself contain many smaller building blocks within.  These are the
core-iscsi-tools and core-iscsi-stack.  Detailed discussion of both of
these blocks are included inside of the release listed below.  Also
included is the core-iscsi ROADMAP that has been updated to reflect the
major improvements/features since the project was first launched in
April 2005 by PyX Technologies.  Note that this release is a source
release only, and binaries+specs are planned to be released in the
upcoming weeks.  Please see the INSTALL files included for more
information:

http://www.kernel.org/pub/linux/kernel/people/nab/iscsi-initiator-core/core-iscsi-v1.6.2.0.tar.bz2
http://www.kernel.org/pub/linux/utils/storage/iscsi/core-iscsi-tools-v3.0.tar.bz2

Please note that the Core-iSCSI configuration files & management scripts
has been designed to be independent of the Core-iSCSI stack.  Recently,
interest has been shown for development to resume on core-iscsi so a
combination of logical and portable scripts+files+tools and proven
implementation+stack can be made available immediately to Linux 2.6
users.  Now that this milestone has been reached, work can begin in
preparation for the port of the tools package to open/iscsi.  This is
something that I have begun documenting, and as efforts continue to rise
and OSS code appears, when in such time that open/iscsi is deemed stable
for production use via core-iscsi validation scripts, preexisting
core-iscsi users will be able to make this upgrade 'futureproof' to the
iSCSI SAN admins of today and 2nd generation iSCSI designers and
implementers of tomorrow.

Note that core-iscsi-tools defines multiple network interconnects of IP
based Storage to remote iSCSI Target Nodes presenting iSCSI Logical
Units.  Some of the number of configuration options core-iscsi-tools
provides that are deployed and validated today involve running multiple
concurrent connections across linear scalable ethernet ports on a wide
assortment of hardware platforms and adapaters from a number of
different vendors.  For core-iscsi this involves running MC/S across
multiple connection Linux/TCP sessions and single Linux/SCTP connection
sessions to iSCSI Target Nodes.  This also involves planning for iSCSI
Extentions for RDMA (iSER) considerations for future hardware and
software RCaPs.

Some of the types of things that are involved are IQN naming, iSNS
registration, iSCSI Target node discovery, iSCSI LUN management, and
consistent filesystem mountpoints on boot are just some of the few.
Also the ability to shutdown a system effectively with mounted and/or
active iSCSI LUNs through core-iscsi scripts is something that is needed
in real-world iSCSI deployments.  Future releases of core-iscsi will
also contain initrd images and instructions for true 'diskless' booting,
as well as a 'LiveCD' concept of using existing OSS backup programs and
allowing any machine to boot and pretty effortlessly backup it's local
storage media to a iSCSI Logical Unit via a iSCSI Target Node within
your iSCSI SAN.  More of this is discussed in iSCSI Channel management
HOWTO for those interested.

The release can be located at the following locations, please check the
Section 1 of the HOWTO for installation instruction.  The core-iscsi
manual pages initiator(5), initiator_auth(5), and iscsi_device_maps(5)
are installed by default with core-iscsi tools, and detailed information
on the configuration of core-iscsi is located in Section 2, and typical
iSCSI usage scenarios are located in Section 3.  Note that as with
previous releases of core-iscsi, all configuration files are backwards
compatible, and will not be overwritten during the installation process
if they previously exist.

And finally, in keeping with tradition of past core-iscsi releases, the
release tarballs above where packaged on remote iSCSI LUNs provided by
the release itself on an iSCSI Initiator Node (LinuxPPC 32-bit 2.6)
connected to an iSCSI Target Node (AlphaLinux 64-bit 2.6).  I hope this
project will go a long way for Linux 2.6 and beyond, and most
importantly, easy to use for ALL users on these next generation devices
based on the Linux and other open platforms.

Enjoy!

-- 
Nicholas A. Bellinger <nab@kernel.org>

