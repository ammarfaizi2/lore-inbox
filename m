Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267134AbSLaDot>; Mon, 30 Dec 2002 22:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbSLaDot>; Mon, 30 Dec 2002 22:44:49 -0500
Received: from mnh-1-21.mv.com ([207.22.10.53]:775 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267134AbSLaDos>;
	Mon, 30 Dec 2002 22:44:48 -0500
Message-Id: <200212310347.WAA04740@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML skas mode changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 30 Dec 2002 22:47:32 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull either
	http://uml.bkbits.net/skas-2.5
or	http://jdike.stearns.org:5000/skas-2.5

This patch fixes some problems that are specific to skas mode -
	skas mode now reacts to SIGTERM, SIGHUP, and SIGINT by forcefully
shutting down
	the messages associated with 'mode=tt' are now mode-specific
	the watchdog driver compiles in skas mode

				Jeff

 arch/um/drivers/harddog_user.c            |    5 ++-
 arch/um/drivers/port_kern.c               |   11 +++-----
 arch/um/include/skas_ptrace.h             |   36 ++++++++++++++++++++++++++
 arch/um/kernel/skas/include/skas_ptrace.h |   36 --------------------------
 arch/um/kernel/tt/tracer.c                |   13 ---------
 arch/um/kernel/um_arch.c                  |   32 ++++++++++++++++++-----
 arch/um/main.c                            |   41 ++++++++++++++++++++++--------
 7 files changed, 101 insertions(+), 73 deletions(-)

ChangeSet@1.988, 2002-12-29 21:40:13-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/skas-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/skas-2.5-linus

ChangeSet@1.951.9.2, 2002-12-29 19:18:49-05:00, jdike@uml.karaya.com
  Forwarded ported a number of skas-related fixes from 2.4.

ChangeSet@1.951.9.1, 2002-12-28 11:50:51-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/doc-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.951.8.4, 2002-12-28 11:42:00-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.951.8.3, 2002-12-28 11:32:32-05:00, jdike@uml.karaya.com
  Fixed a merge conflict in port_kern.c

ChangeSet@1.951.8.1, 2002-12-28 11:12:47-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/mconfig-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

