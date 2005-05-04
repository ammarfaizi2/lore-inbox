Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbVEDHR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbVEDHR3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVEDHPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:15:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:59625 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262061AbVEDHLn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:11:43 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe: update the documentation to mention aoetools
In-Reply-To: <11151906962511@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:11:36 -0700
Message-Id: <1115190696161@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe: update the documentation to mention aoetools

update the documentation to mention aoetools

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 67d9f84786cc4fd42cb40c9474c248eadaff15c6
tree f1ef2e8c1d1f1b21969704666f20ac1dbec42197
parent c59a24dc512952cb434b34a66c3792555159fa36
author Ed L Cashin <ecashin@coraid.com> 1114784658 -0400
committer Greg KH <gregkh@suse.de> 1115188494 -0700

Index: Documentation/aoe/aoe.txt
===================================================================
--- 3b13ab42ed88a09f304c1fc87962a82c1f49c098/Documentation/aoe/aoe.txt  (mode:100644 sha1:1212987a30fa018c0e2d1f32e0baf29a6537d123)
+++ f1ef2e8c1d1f1b21969704666f20ac1dbec42197/Documentation/aoe/aoe.txt  (mode:100644 sha1:3a4dbe4663c9556f15fd062cfafcd1f6e3dddd1d)
@@ -4,6 +4,16 @@
 
   It has many tips and hints!
 
+The aoetools are userland programs that are designed to work with this
+driver.  The aoetools are on sourceforge.
+
+  http://aoetools.sourceforge.net/
+
+The scripts in this Documentation/aoe directory are intended to
+document the use of the driver and are not necessary if you install
+the aoetools.
+
+
 CREATING DEVICE NODES
 
   Users of udev should find the block device nodes created
@@ -33,19 +43,17 @@
   "cat /dev/etherd/err" blocks, waiting for error diagnostic output,
   like any retransmitted packets.
 
-  The /dev/etherd/interfaces special file is obsoleted by the
-  aoe_iflist boot option and module option (and its sysfs entry
-  described in the next section).
   "echo eth2 eth4 > /dev/etherd/interfaces" tells the aoe driver to
   limit ATA over Ethernet traffic to eth2 and eth4.  AoE traffic from
-  untrusted networks should be ignored as a matter of security.
+  untrusted networks should be ignored as a matter of security.  See
+  also the aoe_iflist driver option described below.
 
   "echo > /dev/etherd/discover" tells the driver to find out what AoE
   devices are available.
 
   These character devices may disappear and be replaced by sysfs
-  counterparts, so distribution maintainers are encouraged to create
-  scripts that use these devices.
+  counterparts.  Using the commands in aoetools insulates users from
+  these implementation details.
 
   The block devices are named like this:
 
@@ -69,7 +77,8 @@
   through which we are communicating with the remote AoE device.
 
   There is a script in this directory that formats this information
-  in a convenient way.
+  in a convenient way.  Users with aoetools can use the aoe-stat
+  command.
 
   root@makki root# sh Documentation/aoe/status.sh 
      e10.0            eth3              up
@@ -100,9 +109,9 @@
   sysfs entry can be read from as well as written to.
 
   It's helpful to trigger discovery after setting the list of allowed
-  interfaces.  If your distro provides an aoe-discover script, you can
-  use that.  Otherwise, you can directly use the /dev/etherd/discover
-  file described above.
+  interfaces.  The aoetools package provides an aoe-discover script
+  for this purpose.  You can also directly use the
+  /dev/etherd/discover special file described above.
 
 DRIVER OPTIONS
 

