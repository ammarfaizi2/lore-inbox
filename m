Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTEVRqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTEVRqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:46:14 -0400
Received: from dhcp05.ists.dartmouth.edu ([129.170.249.105]:898 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S262884AbTEVRqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:46:01 -0400
Message-Id: <200305221759.h4MHwwum013259@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML build updates 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 May 2003 13:58:58 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/build-2.5

This update brings the UML build up to 2.5.69.

It also fixes a bunch of bugs -
	multi-line strings are gone, so gcc 3.[23] are happier
	a bunch of missing dependencies were added, so -j builds work
	cleaned up defconfig

				Jeff


 arch/um/Kconfig                      |  100 ++++++++++++++++++++++++++++++-----
 arch/um/Kconfig_net                  |   70 ------------------------
 arch/um/Makefile                     |   33 +++++++----
 arch/um/Makefile-i386                |   20 ++++---
 arch/um/Makefile-skas                |    6 +-
 arch/um/config.release               |    1 
 arch/um/defconfig                    |    1 
 arch/um/drivers/mconsole_kern.c      |   26 ++++-----
 arch/um/kernel/Makefile              |    8 +-
 arch/um/kernel/config.c.in           |    4 -
 arch/um/kernel/skas/Makefile         |   22 ++++---
 arch/um/kernel/skas/util/mk_ptregs.c |    1 
 arch/um/kernel/tt/ptproxy/proxy.c    |    8 +-
 arch/um/sys-i386/Makefile            |   10 ++-
 include/asm-um/common.lds.S          |    8 --
 15 files changed, 167 insertions(+), 151 deletions(-)

ChangeSet@1.1042.83.2, 2003-05-02 12:59:05-04:00, jdike@uml.karaya.com
  Got rid of multi-line strings.
  Added a missing dependency to arch/um/Makefile.
  Removed a bogus entry from defconfig.

ChangeSet@1.889.410.2, 2003-03-27 12:19:48-05:00, jdike@uml.karaya.com
  Updated to 2.5.66 build changes.

ChangeSet@1.889.410.1, 2003-03-22 14:07:47-05:00, jdike@uml.karaya.com
  Merged the 2.5.65 changes.

ChangeSet@1.889.307.3, 2003-03-22 13:11:46-05:00, jdike@uml.karaya.com
  Fixed the build of arch/um/util by expanding $(call descend, ....)
  in arch/um/Makefile because it's not available there, and by setting
  build-targets to host-progs in arch/um/util/Makefile because 
  host-progs doesn't get built otherwise.

ChangeSet@1.889.308.2, 2003-03-07 12:35:02-05:00, jdike@uml.karaya.com
  Fixed build races so that -j builds work.
  The config is closer to the other arches.

ChangeSet@1.889.99.31, 2003-02-07 12:53:42-05:00, jdike@uml.karaya.com
  Added some help and removed an unneeded option from config.release.

