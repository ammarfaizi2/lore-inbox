Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWAETQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWAETQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbWAETQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:16:14 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:57255 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752132AbWAETQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:16:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=CYlPHLySy8ySLeBEvIMx85BN9q3VYe2ugkCTigvo0TtiiK/GixJddgjcDdVp7NNmzFwXCw5le9THjlCe94VVplI+oBYBJNzBkButqmyOuyon7wvKF7ii7X9tx5At5TRRuDkHRqcN+SbCQ0H3zT0Euy7gVb30M6ANxokV+NZFhbk=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] Docs update: small spelling, formating etc fixes for filesystems/ext3.txt
Date: Thu, 5 Jan 2006 20:16:07 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601052016.07333.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Spelling fixes, formating changes and corrections for 
 Documentation/filesystems/ext3.txt

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/filesystems/ext3.txt |  180 ++++++++++++++++++-------------------
 1 files changed, 91 insertions(+), 89 deletions(-)

--- linux-2.6.15-mm1-orig/Documentation/filesystems/ext3.txt	2006-01-05 18:15:25.000000000 +0100
+++ linux-2.6.15-mm1/Documentation/filesystems/ext3.txt	2006-01-05 19:22:01.000000000 +0100
@@ -2,11 +2,11 @@
 Ext3 Filesystem
 ===============
 
-ext3 was originally released in September 1999. Written by Stephen Tweedie
-for 2.2 branch, and ported to 2.4 kernels by Peter Braam, Andreas Dilger, 
+Ext3 was originally released in September 1999. Written by Stephen Tweedie
+for the 2.2 branch, and ported to 2.4 kernels by Peter Braam, Andreas Dilger,
 Andrew Morton, Alexander Viro, Ted Ts'o and Stephen Tweedie.
 
-ext3 is ext2 filesystem enhanced with journalling capabilities. 
+Ext3 is the ext2 filesystem enhanced with journalling capabilities.
 
 Options
 =======
@@ -14,69 +14,71 @@
 When mounting an ext3 filesystem, the following option are accepted:
 (*) == default
 
-jounal=update		Update the ext3 file system's journal to the 
-			current format.
+journal=update		Update the ext3 file system's journal to the current
+			format.
 
-journal=inum		When a journal already exists, this option is 
-			ignored. Otherwise, it specifies the number of
-			the inode which will represent the ext3 file
-			system's journal file.
+journal=inum		When a journal already exists, this option is ignored.
+			Otherwise, it specifies the number of the inode which
+			will represent the ext3 file system's journal file.
 
 journal_dev=devnum	When the external journal device's major/minor numbers
-			have changed, this option allows to specify the new
-			journal location. The journal device is identified
-			through its new major/minor numbers encoded in devnum.
+			have changed, this option allows the user to specify
+			the new journal location.  The journal device is
+			identified through its new major/minor numbers encoded
+			in devnum.
 
 noload			Don't load the journal on mounting.
 
-data=journal		All data are committed into the journal prior
-			to being written into the main file system.
+data=journal		All data are committed into the journal prior to being
+			written into the main file system.
 
 data=ordered	(*)	All data are forced directly out to the main file
-			system prior to its metadata being committed to
-			the journal.
+			system prior to its metadata being committed to the
+			journal.
 
-data=writeback		Data ordering is not preserved, data may be
-			written into the main file system after its
-			metadata has been committed to the journal.
+data=writeback		Data ordering is not preserved, data may be written
+			into the main file system after its metadata has been
+			committed to the journal.
 
 commit=nrsec	(*)	Ext3 can be told to sync all its data and metadata
 			every 'nrsec' seconds. The default value is 5 seconds.
-			This means that if you lose your power, you will lose,
-			as much, the latest 5 seconds of work (your filesystem
-			will not be damaged though, thanks to journaling). This
-			default value (or any low value) will hurt performance,
-			but it's good for data-safety. Setting it to 0 will
-			have the same effect than leaving the default 5 sec.
+			This means that if you lose your power, you will lose
+			as much as the latest 5 seconds of work (your
+			filesystem will not be damaged though, thanks to the
+			journaling).  This default value (or any low value)
+			will hurt performance, but it's good for data-safety.
+			Setting it to 0 will have the same effect as leaving
+			it at the default (5 seconds).
 			Setting it to very large values will improve
 			performance.
 
-barrier=1		This enables/disables barriers. barrier=0 disables it,
-			barrier=1 enables it.
+barrier=1		This enables/disables barriers.  barrier=0 disables
+			it, barrier=1 enables it.
 
-orlov		(*)	This enables the new Orlov block allocator. It's enabled
-			by default.
+orlov		(*)	This enables the new Orlov block allocator. It is
+			enabled by default.
 
-oldalloc		This disables the Orlov block allocator and enables the
-			old block allocator. Orlov should have better performance,
-			we'd like to get some feedback if it's the contrary for
-			you.
-
-user_xattr		Enables Extended User Attributes. Additionally, you need
-			to have extended attribute support enabled in the kernel
-			configuration (CONFIG_EXT3_FS_XATTR). See the attr(5)
-			manual page and http://acl.bestbits.at to learn more
-			about extended attributes.
+oldalloc		This disables the Orlov block allocator and enables
+			the old block allocator.  Orlov should have better
+			performance - we'd like to get some feedback if it's
+			the contrary for you.
+
+user_xattr		Enables Extended User Attributes.  Additionally, you
+			need to have extended attribute support enabled in the
+			kernel configuration (CONFIG_EXT3_FS_XATTR).  See the
+			attr(5) manual page and http://acl.bestbits.at/ to
+			learn more about extended attributes.
 
 nouser_xattr		Disables Extended User Attributes.
 
-acl			Enables POSIX Access Control Lists support.  Additionally,
-			you need to have ACL support enabled in the kernel
-			configuration (CONFIG_EXT3_FS_POSIX_ACL). See the acl(5)
-			manual page and http://acl.bestbits.at for more
-			information.
+acl			Enables POSIX Access Control Lists support.
+			Additionally, you need to have ACL support enabled in
+			the kernel configuration (CONFIG_EXT3_FS_POSIX_ACL).
+			See the acl(5) manual page and http://acl.bestbits.at/
+			for more information.
 
-noacl			This option disables POSIX Access Control List support.
+noacl			This option disables POSIX Access Control List
+			support.
 
 reservation
 
@@ -88,7 +90,7 @@
 minixdf			Make 'df' act like Minix.
 
 check=none		Don't do extra checking of bitmaps on mount.
-nocheck		
+nocheck
 
 debug			Extra debugging information is sent to syslog.
 
@@ -97,7 +99,7 @@
 errors=panic		Panic and halt the machine if an error occurs.
 
 grpid			Give objects the same group ID as their creator.
-bsdgroups		
+bsdgroups
 
 nogrpid		(*)	New objects have the group ID of their creator.
 sysvgroups
@@ -108,81 +110,81 @@
 
 sb=n			Use alternate superblock at this location.
 
-quota			Quota options are currently silently ignored.
-noquota			(see fs/ext3/super.c, line 594)
+quota
+noquota
 grpquota
 usrquota
 
 
 Specification
 =============
-ext3 shares all disk implementation with ext2 filesystem, and add
-transactions capabilities to ext2.  Journaling is done by the
-Journaling block device layer.
+Ext3 shares all disk implementation with the ext2 filesystem, and adds
+transactions capabilities to ext2.  Journaling is done by the Journaling Block
+Device layer.
 
 Journaling Block Device layer
 -----------------------------
-The Journaling Block Device layer (JBD) isn't ext3 specific.  It was
-design to add journaling capabilities on a block device.  The ext3
-filesystem code will inform the JBD of modifications it is performing
-(Call a transaction).  the journal support the transactions start and
-stop, and in case of crash, the journal can replayed the transactions
-to put the partition on a consistent state fastly.
+The Journaling Block Device layer (JBD) isn't ext3 specific.  It was design to
+add journaling capabilities on a block device.  The ext3 filesystem code will
+inform the JBD of modifications it is performing (called a transaction).  The
+journal supports the transactions start and stop, and in case of crash, the
+journal can replayed the transactions to put the partition back in a
+consistent state fast.
 
-handles represent a single atomic update to a filesystem.  JBD can
-handle external journal on a block device.
+Handles represent a single atomic update to a filesystem.  JBD can handle an
+external journal on a block device.
 
 Data Mode
 ---------
-There's 3 different data modes:
+There are 3 different data modes:
 
 * writeback mode
-In data=writeback mode, ext3 does not journal data at all.  This mode
-provides a similar level of journaling as XFS, JFS, and ReiserFS in its
-default mode - metadata journaling.  A crash+recovery can cause
-incorrect data to appear in files which were written shortly before the
-crash.  This mode will typically provide the best ext3 performance.
+In data=writeback mode, ext3 does not journal data at all.  This mode provides
+a similar level of journaling as that of XFS, JFS, and ReiserFS in its default
+mode - metadata journaling.  A crash+recovery can cause incorrect data to
+appear in files which were written shortly before the crash.  This mode will
+typically provide the best ext3 performance.
 
 * ordered mode
-In data=ordered mode, ext3 only officially journals metadata, but it
-logically groups metadata and data blocks into a single unit called a
-transaction.  When it's time to write the new metadata out to disk, the
-associated data blocks are written first.  In general, this mode
-perform slightly slower than writeback but significantly faster than
-journal mode.
+In data=ordered mode, ext3 only officially journals metadata, but it logically
+groups metadata and data blocks into a single unit called a transaction.  When
+it's time to write the new metadata out to disk, the associated data blocks
+are written first.  In general, this mode performs slightly slower than
+writeback but significantly faster than journal mode.
 
 * journal mode
-data=journal mode provides full data and metadata journaling.  All new
-data is written to the journal first, and then to its final location. 
-In the event of a crash, the journal can be replayed, bringing both
-data and metadata into a consistent state.  This mode is the slowest
-except when data needs to be read from and written to disk at the same
-time where it outperform all others mode.
+data=journal mode provides full data and metadata journaling.  All new data is
+written to the journal first, and then to its final location.
+In the event of a crash, the journal can be replayed, bringing both data and
+metadata into a consistent state.  This mode is the slowest except when data
+needs to be read from and written to disk at the same time where it
+outperforms all others modes.
 
 Compatibility
 -------------
 
 Ext2 partitions can be easily convert to ext3, with `tune2fs -j <dev>`.
-Ext3 is fully compatible with Ext2.  Ext3 partitions can easily be
-mounted as Ext2.
+Ext3 is fully compatible with Ext2.  Ext3 partitions can easily be mounted as
+Ext2.
+
 
 External Tools
 ==============
-see manual pages to know more.
+See manual pages to learn more.
+
+tune2fs: 	create a ext3 journal on a ext2 partition with the -j flag.
+mke2fs: 	create a ext3 partition with the -j flag.
+debugfs: 	ext2 and ext3 file system debugger.
 
-tune2fs: 	create a ext3 journal on a ext2 partition with the -j flags
-mke2fs: 	create a ext3 partition with the -j flags
-debugfs: 	ext2 and ext3 file system debugger
 
 References
 ==========
 
-kernel source:	file:/usr/src/linux/fs/ext3
-		file:/usr/src/linux/fs/jbd
+kernel source:	<file:fs/ext3/>
+		<file:fs/jbd/>
 
-programs: 	http://e2fsprogs.sourceforge.net
+programs: 	http://e2fsprogs.sourceforge.net/
 
-useful link:
-		http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html
+useful links:	http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html
 		http://www-106.ibm.com/developerworks/linux/library/l-fs7/
 		http://www-106.ibm.com/developerworks/linux/library/l-fs8/
