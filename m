Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWF2RQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWF2RQn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWF2RQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 13:16:43 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:33806 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751035AbWF2RQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 13:16:42 -0400
Date: Thu, 29 Jun 2006 13:15:37 -0400
From: Matt LaPlante <laplam@rpi.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] Kconfig: Typos in fs/Kconfig
Message-Id: <20060629131537.49617197.laplam@rpi.edu>
In-Reply-To: <1151582979.23785.27.camel@localhost.localdomain>
References: <20060629020052.f73d7ca1.laplam@rpi.edu>
	<1151582979.23785.27.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 13:15:46 -0400
	(not processed: message from trusted or authenticated source)
X-Return-Path: laplam@rpi.edu
X-Envelope-From: laplam@rpi.edu
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 29 Jun 2006 13:15:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2006 13:09:39 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Iau, 2006-06-29 am 02:00 -0400, ysgrifennodd Matt LaPlante:
> > Fix several typos in fs/Kconfig
> 
> Some wrong, some right.
> 
> > -	tristate "Ext3 journalling file system support"
> > +	tristate "Ext3 journaling file system support"
> 
> There is actually no such word in the dictionaries I have access to
> (including the OED). An -ing form would be "-lling" in British English
> and ext3 is maintained in the UK which is probably why it uses "lling".
> This was discussed at length about three years ago and the lling was the
> decision taken at the end of the thread.

Opposite here with my upstart American English references. :)

> 
> >  	select JBD
> >  	help
> >  	  This is the journaling version of the Second extended file system
> 
> That one ought to get fixed instead if anything to be consistent.

This version was actually used several times in the KConfig as well.  (See below)

> 
> > @@ -831,7 +831,7 @@
> >  
> >  	Some system agents rely on the information in sysfs to operate.
> >  	/sbin/hotplug uses device and object attributes in sysfs to assist in
> > -	delegating policy decisions, like persistantly naming devices.
> > +	delegating policy decisions, like persistently naming devices.
> 
> Persistantly is also correct. Both forms are valid English
> 
> > -	  levelling, compression and support for hard links. You cannot use
> > +	  leveling, compression and support for hard links. You cannot use
> 
> levelling with double ll is also correct English. Single "l" is an
> Americanism. Please stop trying to "Americanise" the Kconfig files and
> just fix actual errors.
> 

^Both are reverted.  I can honestly say I'm in no way attempting to Americanise/Americanize the files or the kernel...I've intentionally passed by all the spellings I found to be valid in either Engish (Colour/Color, -ise vs -ize for example).  My reference dictionaries, which I will be changing now, were apparently more biased than I thought (they did support *some* british english).  English is complicated enough on either side of the pond, and when you combine the two you've got a whole new source of chaos and confusion.  I'm just trying to correct real mistakes, and I appologize if I err along the way.

The updated patch is below.

-
Matt LaPlante

--

--- a/fs/Kconfig	2006-06-29 02:05:52.000000000 -0400
+++ b/fs/Kconfig	2006-06-29 13:01:35.000000000 -0400
@@ -72,11 +72,11 @@
 	tristate "Ext3 journalling file system support"
 	select JBD
 	help
-	  This is the journaling version of the Second extended file system
+	  This is the journalling version of the Second extended file system
 	  (often called ext3), the de facto standard Linux file system
 	  (method to organize files on a storage device) for hard disks.
 
-	  The journaling code included in this driver means you do not have
+	  The journalling code included in this driver means you do not have
 	  to run e2fsck (file system checker) on your file systems after a
 	  crash.  The journal keeps track of any changes that were being made
 	  at the time the system crashed, and can ensure that your file system
@@ -141,7 +141,7 @@
 config JBD
 	tristate
 	help
-	  This is a generic journaling layer for block devices.  It is
+	  This is a generic journalling layer for block devices.  It is
 	  currently used by the ext3 and OCFS2 file systems, but it could
 	  also be used to add journal support to other file systems or block
 	  devices such as RAID or LVM.
@@ -181,7 +181,7 @@
 	tristate "Reiserfs support"
 	help
 	  Stores not just filenames but the files themselves in a balanced
-	  tree.  Uses journaling.
+	  tree.  Uses journalling.
 
 	  Balanced trees are more efficient than traditional file system
 	  architectural foundations.
@@ -1039,7 +1039,7 @@
 	tristate "Journalling Flash File System (JFFS) support"
 	depends on MTD
 	help
-	  JFFS is the Journaling Flash File System developed by Axis
+	  JFFS is the Journalling Flash File System developed by Axis
 	  Communications in Sweden, aimed at providing a crash/powerdown-safe
 	  file system for disk-less embedded devices. Further information is
 	  available at (<http://developer.axis.com/software/jffs/>).
@@ -1209,7 +1209,7 @@
 config JFFS2_CMODE_PRIORITY
         bool "priority"
         help
-          Tries the compressors in a predefinied order and chooses the first
+          Tries the compressors in a predefined order and chooses the first
           successful one.
 
 config JFFS2_CMODE_SIZE
@@ -1892,7 +1892,7 @@
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
 
-	  See <file:Documentation/filesystems/afs.txt> for more intormation.
+	  See <file:Documentation/filesystems/afs.txt> for more information.
 
 	  If unsure, say N.
 


