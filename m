Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263138AbTC1Uk4>; Fri, 28 Mar 2003 15:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263139AbTC1Uk4>; Fri, 28 Mar 2003 15:40:56 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:49413 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S263138AbTC1Ukz>;
	Fri, 28 Mar 2003 15:40:55 -0500
Message-Id: <200303282050.PAA03138@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML build updates
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Mar 2003 15:50:31 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/build-2.5

This updates the UML build to 2.5.66,
     closes a number of races so that -j builds now work (thanks to a patch
from Roman Zippel)
     adds some help to the config
     removes some cruft from the config

				Jeff

 arch/um/Kconfig                      |  100 ++++++++++++++++++++++++++++++-----
 arch/um/Kconfig_net                  |   70 ------------------------
 arch/um/Makefile                     |   31 +++++++---
 arch/um/Makefile-i386                |   20 ++++---
 arch/um/Makefile-skas                |    6 +-
 arch/um/config.release               |    1 
 arch/um/kernel/Makefile              |    6 --
 arch/um/kernel/skas/Makefile         |   22 ++++---
 arch/um/kernel/skas/util/mk_ptregs.c |    1 
 arch/um/sys-i386/Makefile            |   10 ++-
 include/asm-um/common.lds.S          |    8 --
 11 files changed, 147 insertions(+), 128 deletions(-)

ChangeSet@1.889.363.2, 2003-03-27 12:19:48-05:00, jdike@uml.karaya.com
  Updated to 2.5.66 build changes.

ChangeSet@1.889.363.1, 2003-03-22 14:07:47-05:00, jdike@uml.karaya.com
  Merged the 2.5.65 changes.

ChangeSet@1.889.289.3, 2003-03-22 13:11:46-05:00, jdike@uml.karaya.com
  Fixed the build of arch/um/util by expanding $(call descend, ....)
  in arch/um/Makefile because it's not available there, and by setting
  build-targets to host-progs in arch/um/util/Makefile because 
  host-progs doesn't get built otherwise.

ChangeSet@1.889.290.2, 2003-03-07 12:35:02-05:00, jdike@uml.karaya.com
  Fixed build races so that -j builds work.
  The config is closer to the other arches.

ChangeSet@1.889.99.31, 2003-02-07 12:53:42-05:00, jdike@uml.karaya.com
  Added some help and removed an unneeded option from config.release.

