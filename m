Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267302AbSLKTk5>; Wed, 11 Dec 2002 14:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbSLKTkW>; Wed, 11 Dec 2002 14:40:22 -0500
Received: from air-2.osdl.org ([65.172.181.6]:56230 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267302AbSLKTjs>;
	Wed, 11 Dec 2002 14:39:48 -0500
Date: Wed, 11 Dec 2002 11:43:31 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Peter Braam <braam@clusterfs.com>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <intermezzo-devel@lists.sourceforge.net>
Subject: Re: [PATCH] intermezzo fixes for 2.5.50
In-Reply-To: <20021211192105.GA1649@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L2.0212111138530.15702-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002, Peter Braam wrote:

| Hello,
|
| Please find attached relatively straightforward fixes for intermezzo
| problems in 2.5.50.  I think all of them related to:
|  - two missing headers
|  - use of timespec instead of time_t.
|
| - Peter -


Patch doesn't apply cleanly to 2.5.51.
File include/linux/fsfilter.h is already in 2.5.51.

After ingoring above:  intermezzo doesn't build.
Makefile still contains io_daemon.o, but that should be deleted.

Patch for that is below.

-- 
~Randy



--- ./fs/intermezzo/Makefile%IMZ	Mon Dec  9 18:46:14 2002
+++ ./fs/intermezzo/Makefile	Wed Dec 11 11:40:55 2002
@@ -5,7 +5,7 @@
 obj-$(CONFIG_INTERMEZZO_FS) += intermezzo.o

 intermezzo-objs := cache.o dcache.o dir.o ext_attr.o file.o fileset.o \
-	           inode.o io_daemon.o journal.o journal_ext2.o journal_ext3.o \
+	           inode.o journal.o journal_ext2.o journal_ext3.o \
 	           journal_obdfs.o journal_reiserfs.o journal_tmpfs.o journal_xfs.o \
 	           kml_reint.o kml_unpack.o methods.o presto.o psdev.o replicator.o \
 	           super.o sysctl.o upcall.o vfs.o

