Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268731AbTGJAWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268749AbTGJAWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:22:38 -0400
Received: from aneto.able.es ([212.97.163.22]:8622 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S268731AbTGJAWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:22:10 -0400
Date: Thu, 10 Jul 2003 02:36:46 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hfsplus: group Apple FS's and help text
Message-ID: <20030710003646.GI18564@werewolf.able.es>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva> <20030710002955.GG18564@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030710002955.GG18564@werewolf.able.es>; from jamagallon@able.es on Thu, Jul 10, 2003 at 02:29:55 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.10, J.A. Magallon wrote:
> 
> On 07.10, Marcelo Tosatti wrote:
> > 
> > Hi,
> > 
> > Here goes -pre4. It contains a lot of updates and fixes.
> > 
> 
> Agreed with maintainer some time ago...
> 

I should learn to write with hands instead of feet...

diff -ruN linux-2.4.21-rc1/Documentation/Configure.help linux-2.4.21-rc1-hfs/Documentation/Configure.help
--- linux-2.4.21-rc1/Documentation/Configure.help	2003-04-21 23:34:34.000000000 +0200
+++ linux-2.4.21-rc1-hfs/Documentation/Configure.help	2003-05-08 01:50:55.000000000 +0200
@@ -16094,7 +16094,7 @@
   say M here and read <file:Documentation/modules.txt>.  If unsure,
   say N.
 
-Apple Macintosh file system support
+Apple HFS file system support
 CONFIG_HFS_FS
   If you say Y here, you will be able to mount Macintosh-formatted
   floppy disks and hard drive partitions with full read-write access.
@@ -16107,6 +16107,21 @@
   compile it as a module, say M here and read
   <file:Documentation/modules.txt>.
 
+Apple HFS+ (Extended HFS) file system support
+CONFIG_HFSPLUS_FS
+  If you say Y here, you will be able to mount extended format
+  Macintosh-formatted hard drive partitions with full read-write access.
+
+  This file system is often called HFS+ and was introduced with
+  MacOS 8. It includes all Mac specific filesystem data such as
+  data forks and creator codes, but it also has several UNIX
+  style features such as file ownership and permissions.
+
+  This file system is also available as a module ( = code which can
+  be inserted in and removed from the running kernel whenever you
+  want). The module is called hfsplus.o. If you want to compile it
+  as a module, say M here and read Documentation/modules.txt.
+
 ROM file system support
 CONFIG_ROMFS_FS
   This is a very small read-only file system mainly intended for
diff -ruN linux-2.4.21-rc1/fs/Config.in linux-2.4.21-rc1-hfs/fs/Config.in
--- linux-2.4.21-rc1/fs/Config.in	2002-11-29 00:53:15.000000000 +0100
+++ linux-2.4.21-rc1-hfs/fs/Config.in	2003-05-08 01:44:35.000000000 +0200
@@ -19,13 +19,13 @@
 
 dep_tristate 'Amiga FFS file system support (EXPERIMENTAL)' CONFIG_AFFS_FS $CONFIG_EXPERIMENTAL
 
-dep_tristate 'Apple Macintosh file system support (EXPERIMENTAL)' CONFIG_HFS_FS $CONFIG_EXPERIMENTAL
+dep_tristate 'Apple HFS file system support (EXPERIMENTAL)' CONFIG_HFS_FS $CONFIG_EXPERIMENTAL
+
+dep_tristate 'Apple HFS+ (Extended HFS) file system support (EXPERIMENTAL)' CONFIG_HFSPLUS_FS $CONFIG_EXPERIMENTAL
 
 dep_tristate 'BeOS file systemv(BeFS) support (read only) (EXPERIMENTAL)' CONFIG_BEFS_FS $CONFIG_EXPERIMENTAL
 dep_mbool '  Debug Befs' CONFIG_BEFS_DEBUG $CONFIG_BEFS_FS
 
-dep_tristate 'Apple Extended HFS file system support (EXPERIMENTAL)' CONFIG_HFSPLUS_FS $CONFIG_EXPERIMENTAL
-
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
 
 tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre2-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-2mdk))
