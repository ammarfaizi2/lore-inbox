Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275386AbTHGO7z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275376AbTHGO5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:57:51 -0400
Received: from dhcp75.ists.dartmouth.edu ([129.170.249.155]:48768 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S275386AbTHGOy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:54:58 -0400
Message-Id: <200308071459.h77Ex8FL001966@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@odsl.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML filesystems 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 07 Aug 2003 10:59:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fs-2.5

This adds the two UML filesystems to the 2.5 tree - hostfs allows a directory
on the host to be mounted as a filesystem inside UML, and hppfs is an overlay
over /proc which allows the content of the UML's /proc to be controlled from
the host.

These are going into fs/hostfs and fs/hppfs.

				Jeff


 arch/um/Kconfig         |   13 
 fs/Makefile             |    2 
 fs/hostfs/Makefile      |   36 +
 fs/hostfs/hostfs.h      |   79 +++
 fs/hostfs/hostfs_kern.c |  960 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/hostfs/hostfs_user.c |  355 +++++++++++++++++
 fs/hppfs/Makefile       |   19 
 fs/hppfs/hppfs_kern.c   |  811 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 2275 insertions(+)

ChangeSet@1.1455.16.2, 2003-07-28 12:53:38-04:00, jdike@uml.karaya.com
  Merged the 2.6.0 updates, which I seemed to have forgotten when I released the
 patch.

ChangeSet@1.1455.16.1, 2003-07-25 02:17:21-04:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.6.0-test1
  into uml.karaya.com:/home/jdike/linux/2.5/fs-2.5

ChangeSet@1.1215.148.2, 2003-07-17 15:10:03-04:00, jdike@uml.karaya.com
  Added a const to the declaration of hppfs_read_super to shut the
  compiler up.

ChangeSet@1.1215.148.1, 2003-07-17 10:30:31-04:00, jdike@uml.karaya.com
  Added the build and config options for hostfs and hpppfs.

