Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281057AbRKDSMb>; Sun, 4 Nov 2001 13:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281056AbRKDSMW>; Sun, 4 Nov 2001 13:12:22 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:34967 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S281074AbRKDSMN>; Sun, 4 Nov 2001 13:12:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net
Subject: [ANNOUNCE] Enterprise Volume Management System (EVMS) Release 0.2.2
Date: Sun, 4 Nov 2001 12:10:57 -0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01110412105700.30243@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.2.2 of EVMS is now available for download at the project web site:
http://www.sf.net/projects/evms

Highlights for version 0.2.2

v0.2.2 - 11/04/01
- Support for Devfs
   - If devfs is enabled in the kernel, all necessary device files for
      discovered volumes will appear at boot time in /dev/evms.
   - Updated code in engine for creating device files in the case when devfs
      is not enabled.
- Dual on-disk copies of EVMS-native metadata (system data and
   feature headers)
   - Kernel and engine common code responsible for recognizing and reconciling
      the redundant copies of system data and feature headers
   - Individual plugins responsible for maintaining multiple copies of
      their private metadata.
- LVM plugin
   - Creating snapshot LVs and contiguous LVs, and deleting snapshot LVs.
   - All metadata is now read/written in endian-neutral format
   - Improved option handling and information displays.
- Default Segment Manager plugin
   - Fixed a bug with removing the last segment from a disk.
   - When assigning the segment manager to a new disk, it now adds OS/2 boot
      sector code to the MBR.
- Drivelinking and BBR engine plugins now commit using the new
   dual-metadata format.
   - BBR discovery works, but there is a known I/O bug when running mkfs on
      a BBR volume.
- OS/2 Region Manager
   - Kernel and engine discovery of OS/2 compatibility volumes
   - Kernel discovery of OS/2 LVM volumes
- Fixed kernel-side volume quiesce/rediscover bug
- Modifed kernel patching process
   - EVMS package now comes with several small patches specific to particular
      2.4 kernel versions for patching the common files modified by EVMS.
   - See the EVMS-HOWTO for more details.


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
