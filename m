Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273358AbRJTP6s>; Sat, 20 Oct 2001 11:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJTP6h>; Sat, 20 Oct 2001 11:58:37 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:34509 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S273358AbRJTP60>; Sat, 20 Oct 2001 11:58:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net
Subject: [ANNOUNCEMENT] Enterprise Volume Management System (EVMS) Release 0.2.1
Date: Sat, 20 Oct 2001 10:18:37 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01102010183700.28129@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.2.1 of EVMS is now available for download at the project web site:
http://www.sf.net/projects/evms

Highlights for version 0.2.1

v0.2.1 - 10/20/01
- Engine updates
   - Global namespace - all storage object names must be unique throughout
      the whole system, not just within a particular layer.
   - Internal locking (instead of a lock file) to prevent multiple writers.
   - Improvements in the Task interface.
   - Engine can now be built with Electric Fence for memory debugging.
   - Plugin collision-resolution - If two plugins with identical IDs are
      loaded, the engine keeps the one with the higher version number. Before,
      it just aborted.
- GUI updates
   - Creation of segments, regions, containers, and feature objects.
   - Assigning objects to segment or region managers.
      - Currently tested by assigning Default Seg Mgr to a raw disk.
   - Extended info windows now support "extra" info for fields as specified
      by the plugins..
- CommandLine updates
   - Several new commands have been coded.
      - Create, Allocate, Assign, Delete, Query
      - Tested creates on segments, feature objects, EVMS volumes, and
         compatibility volumes.
   - Most Query filters have been coded
      - Filter by size (GT, LT), plugin, volume, plugin type, options
- LVM plugin
   - support for creating linear and striped LVs/regions.
      - no contiguous or snapshotting yet.
      - does allow specifying the underlying PVs for both linear and striped
   - support for deleting LVs/regions.
      - does not support snapshot LVs yet.
   - lots of extended information support.
- LVM Compatibility Utilities
   - New commands
      - evms_pvremove
      - evms_lvcreate, evms_lvremove
      - evms_vgdisplay, evms_pvdisplay, evms_lvdisplay
- EVMS Snapshots are now writable
- Improved option handling in the Default Segment Manager.
- Initial drop of engine plugin code for the OS/2 Region Manager.
- Drivelinking and BBR engine plugins currently do not commit any metadata,
   but do go through the "virtual" creation process in the engine.
- AIX runtime code added mirroring support.
- Updates to the kernel Local Device Manager to recognize a wider range of
   local disk drives.
- EVMS kernel info level can now be set during kernel configuration or as
   a boot-time parameter.
- Cleaned up some kernel memory issues dealing with large memory requests.

Kevin Corry
corryk@us.ibm.com
Enterprise Volume Management System
http://www.sf.net/projects/evms
