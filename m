Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSEHPYS>; Wed, 8 May 2002 11:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314469AbSEHPYS>; Wed, 8 May 2002 11:24:18 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:4856 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S314465AbSEHPYQ>; Wed, 8 May 2002 11:24:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net
Subject: [ANNOUNCE] EVMS Release 1.0.1
Date: Wed, 8 May 2002 10:18:10 -0500
X-Mailer: KMail [version 1.2]
Cc: evms-announce@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02050810181004.26176@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The EVMS team is announcing the next full release of the Enterprise Volume 
Management System. Package 1.0.1 is now available for download at the project 
web site:
http://www.sf.net/projects/evms
Version 1.0.1 is primarily minor bug fixes for the previous version (1.0.0), 
as noted below.

This release again contains an extra package for experimental File System 
Interface Module (FSIM) support. Along with the libparted-based FSIM, there 
is also a new JFS FSIM. The parted FSIM requires parted version 1.6.x, and 
the JFS FSIM requires version 1.0.9 or later of the JFS utilities.


Highlights for version 1.0.1:

v1.0.1 - 5/8/02
- Bug fixes from 1.0.0
  - RAID-5 size bug - math overflow bug in the engine when creating a RAID-5
    with objects greater than 4 GB.
  - RAID-1 engine discover - calculate size of a discovered region by getting
    the appropriate superblock field, instead of looking at the size of the
    consumed object.
  - Volume rename bug - was not releasing old name from the engine's name
    registry.
  - BBR engine - always keep BBR tables up-to-date on disk for inactive
    BBR objects.
  - Drivelinking kernel - added size checks to I/O request path.
  - Kernel compile - fixed compile errors for 2.4.9 and earlier kernels.
  - Engine fault handler - fixed compile errors on alpha, mips, and sparc.
  - Engine - get rid of unnecessary messages when reverting a compatibility
    volume.
  - Command line - corrected query for plugin extended-info.
  - S/390 segment manager - engine seg-fault when displaying plugin details.
- Simplified engine build options
  - Removed --with-evmslib_dir and --with-evmsheaders_dir, and replaced with
    built in options --libdir and --includedir


Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://evms.sourceforge.net/
