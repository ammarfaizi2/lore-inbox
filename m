Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265270AbTBFDJ2>; Wed, 5 Feb 2003 22:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTBFDJ1>; Wed, 5 Feb 2003 22:09:27 -0500
Received: from mnh-1-13.mv.com ([207.22.10.45]:1285 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265270AbTBFDJZ>;
	Wed, 5 Feb 2003 22:09:25 -0500
Message-Id: <200302060313.WAA04458@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML skas-related fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Feb 2003 22:13:12 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/skas-2.5

This fixes some skas mode-related bugs, including
	generalizing some code which made assumptions that UML always has
a tracing thread
	moving a header out of arch/um/kernel/skas/include because it's not
private to skas mode
	adding the ability to skas mode of detecting some signals from the
host and shutting down as a result
	process name modification doesn't happen if CONFIG_MODE_TT isn't enabled
	the 'mode=tt' switch generates warnings if the configuration makes it
either redundant or useless

				Jeff

 arch/um/drivers/harddog_user.c            |    5 ++-
 arch/um/drivers/port_kern.c               |   11 +++-----
 arch/um/include/skas_ptrace.h             |   36 ++++++++++++++++++++++++++
 arch/um/kernel/skas/include/skas_ptrace.h |   36 --------------------------
 arch/um/kernel/tt/tracer.c                |   13 ---------
 arch/um/kernel/um_arch.c                  |   32 ++++++++++++++++++-----
 arch/um/main.c                            |   41 ++++++++++++++++++++++--------
 7 files changed, 101 insertions(+), 73 deletions(-)

ChangeSet@1.958, 2003-01-18 18:41:40-05:00, jdike@uml.karaya.com
  Replaced a CONFIG_* name with a UML_CONFIG_* name.

ChangeSet@1.838.124.1, 2002-12-29 21:40:13-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/skas-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/skas-2.5-linus

ChangeSet@1.838.118.2, 2002-12-29 19:18:49-05:00, jdike@uml.karaya.com
  Forwarded ported a number of skas-related fixes from 2.4.

ChangeSet@1.838.118.1, 2002-12-28 11:50:51-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/doc-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.838.117.4, 2002-12-28 11:42:00-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/updates-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

ChangeSet@1.838.117.3, 2002-12-28 11:32:32-05:00, jdike@uml.karaya.com
  Fixed a merge conflict in port_kern.c

ChangeSet@1.838.117.1, 2002-12-28 11:12:47-05:00, jdike@uml.karaya.com
  Merge http://jdike.stearns.org:5000/mconfig-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/uml-2.5

