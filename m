Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268849AbTBZSCY>; Wed, 26 Feb 2003 13:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268851AbTBZSCY>; Wed, 26 Feb 2003 13:02:24 -0500
Received: from dhcp63.ists.dartmouth.edu ([129.170.249.163]:10625 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id <S268849AbTBZSCV>;
	Wed, 26 Feb 2003 13:02:21 -0500
Message-Id: <200302261816.h1QIG5e11225@uml.karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add UML filesystems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 26 Feb 2003 13:16:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fs-2.5

This adds the two UML-specific filesystems to 2.5.  hostfs allows directories
on the host to be mounted as a filesystem within a UML.  hppfs allows a UML's
/proc to be modified from the host.  This is useful in honeypots by allowing
the UML /proc to be made to look like a physical box, making it harder for
an attacker to recognize a compromised box as a UML.

Note that these add the filesystems under arch/um/fs since these are only
usable in UML.  If it would be better to have them under fs instead, then
I will fix that.

				Jeff

 arch/um/Kconfig                 |   13 
 arch/um/Makefile                |    1 
 arch/um/fs/Makefile             |   17 
 arch/um/fs/hostfs/Makefile      |   36 +
 arch/um/fs/hostfs/hostfs.h      |   79 +++
 arch/um/fs/hostfs/hostfs_kern.c | 1008 ++++++++++++++++++++++++++++++++++++++++
 arch/um/fs/hostfs/hostfs_user.c |  355 ++++++++++++++
 arch/um/fs/hppfs/Makefile       |   19 
 arch/um/fs/hppfs/hppfs_kern.c   |  794 +++++++++++++++++++++++++++++++
 9 files changed, 2322 insertions(+)

ChangeSet@1.914.184.6, 2003-02-24 17:26:48-05:00, jdike@uml.karaya.com
  Fixed hppfs_lookup so that hppfs does more than just mount OK.

ChangeSet@1.914.184.5, 2003-02-24 13:17:04-05:00, jdike@uml.karaya.com
  Fixed the interface of stat_file.

ChangeSet@1.914.184.4, 2003-02-24 01:50:34-05:00, jdike@uml.karaya.com
  A minor fix to hostfs.
  hppfs now compiles and mounts.

ChangeSet@1.914.184.3, 2003-02-23 22:49:54-05:00, jdike@uml.karaya.com
  Added a first-pass update of hppfs to 2.5.

ChangeSet@1.914.184.2, 2003-02-23 21:48:56-05:00, jdike@uml.karaya.com
  Some small compilation fixes to hostfs.

ChangeSet@1.914.184.1, 2003-02-23 20:56:17-05:00, jdike@uml.karaya.com
  Merged Petr Baudis' hostfs updates to 2.5.

