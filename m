Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbTCLRq7>; Wed, 12 Mar 2003 12:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbTCLRq7>; Wed, 12 Mar 2003 12:46:59 -0500
Received: from moraine.clusterfs.com ([216.138.243.178]:688 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id <S261822AbTCLRqu>; Wed, 12 Mar 2003 12:46:50 -0500
Date: Wed, 12 Mar 2003 10:56:25 -0700
From: Peter Braam <braam@clusterfs.com>
To: lustre-announce@lists.sf.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Lustre Lite 1.0 beta 1
Message-ID: <20030312175625.GL888@peter.cfs>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Lustre Lite 0.6 released (1.0 beta 1)

Summary
-------

We're pleased to announce that the first Lustre Lite beta (0.6) has
been tagged and released.  Seven months have passed since our last
major release, and Lustre Lite is quickly approaching the goal of
being stable, consistent, and fast on clusters up to 1,000 nodes.

Over the last few months we've spent thousands of hours improving and
testing the file system, and now it's ready for a wider audience of
early adopters.  In particular, Lustre users on ia32 and ia64 Linux
systems running 2.4.19 and Red Hat 2.4.18-based kernels.  Lustre may
work on other Linux platforms, but has not been extensively tested,
and may require some additional porting effort.

We expect that you will find many bugs that we are unable to provoke
in our testing, and we hope that you will take the time to report them
to our bug system (see Reporting Bugs below).

Features
--------

Lustre Lite 0.6:

- has been tested extensively on ia32 and ia64 Linux platforms
- supports TCP/IP and Quadrics Elan3 interconnects
- supports multiple Object Storage Targets (OSTs) for file data storage
- supports multiple Metadata Servers (MDSs) in an active/passive
  failover configuration (requires shared storage between MDS nodes).
  Automatic failover requires an external failover package such as
  Red Hat's clumanager.
- provides a nearly POSIX-compliant filesystem interface (some areas
  remain non-compliant; for example, we do not synchronize atimes)
- aims to recover from any single failure without loss of data or
  application errors
- scales well; we have tested with as many as 1,100 clients and 128 OSTs
- is Free Software, released under the terms and conditions of the GNU
  General Public License

Risks
-----

As with any beta software, but especially kernel modules, Lustre Lite
carries the real risk of data loss or system crashes.  It is very
likely that users will test situations which we have not, and provoke
bugs which crash the system.  We must insist that you

  BACKUP YOUR DATA

prior to installing Lustre, and that you understand that

  we make NO GUARANTEES about Lustre.

Please read the COPYING file included with the distribution for more
information about the licensing of Lustre.

Known Bugs
----------

Although Lustre is for the most part stable, there are some known bugs
with this current version that you should be particularly aware of:

- Some high-load situations involving multiple clients have been known
  to provoke a client crash in the lock manager (bug 984)

- Failover support is incomplete; some access patterns will not
  recover correctly

- Recovery does not gracefully handle multiple services present on the
  same node

- Failures can lead to unrecoverable states, which require the system
  to be umounted and remounted (and, in some case, nodes may require a
  reboot)

- Unmounting a client while an MDS is failed may hang the "umount"
  command, which will need to be "kill"ed manually (bug 978)

- Metadata recovery will time out and abort if there are clients which
  hold uncommitted requests, but which do not detect the death and
  failover of the MDS.  Running a metadata operation on quiescent
  clients will cause them to join recovery.  (bug 957)

Getting Started
---------------

<https://projects.clusterfs.com/lustre/LustreHowto> contains
instructions for downloading, building, configuring, and running
Lustre.  If you encounter problems, you can seek help from others in
the lustre-discuss mailing list (see below).

Reporting Bugs
--------------

We are eager to hear about new bugs, especially if you can tell us how
to reproduce them.  Please visit <http://bugzilla.lustre.org/> to
report problems.

The closer that you can come to the ideal described in
<https://projects.clusterfs.com/lustre/BugFiling>, the better.

Mailing Lists
-------------

See <http://www.lustre.org/lists.html> for links to the various Lustre
mailing lists.

Acknowledgement
---------------

The US government has funded much of the Lustre effort through the
National Laboratories.  In addition to money they have provided
invaluable experience and fantastic help with testing both in terms of
equipment and people.  We thank them all, but in particular Mark
Seager, Bill Boas and Terry Heidelberg's team at LLNL which went far
beyond the call of duty, Lee Ward (Sandia) and Gary Grider (LANL),
Scott Studham (PNNL).  We have also had the benefit of partnerships
with UCSC, HP, Intel, BlueArc and DDN and we are grateful to them.

---

Thank you for your interest in and testing of Lustre.  We appreciate
your effort, patience, and bug reports as we work towards Lustre Lite
1.0.

The Cluster File Systems team

Peter J. Braam     <braam@clusterfs.com>
Phil Schwan        <phil@clusterfs.com>
Andreas Dilger     <adilger@clusterfs.com>
Robert Read        <rread@clusterfs.com>
Eric Barton        <eeb@clusterfs.com>
Radhika Vullikanti <radhika@clusterfs.com>
Mike Shaver        <shaver@clusterfs.com>
Eric Mei           <ericm@clusterfs.com>
Zach Brown         <zab@clusterfs.com>
Chris Cooper       <ccooper@clusterfs.com>
