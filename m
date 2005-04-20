Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVDTRPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVDTRPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVDTRPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:15:37 -0400
Received: from ns1.coraid.com ([65.14.39.133]:15016 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261735AbVDTRPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:15:19 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
References: <874qe1pejv.fsf@coraid.com>
Subject: [PATCH 2.6.12-rc2] aoe [3/6]: update the documentation to mention
 aoetools
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 13:05:56 -0400
Message-ID: <87oec9nzt7.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


update the documentation to mention aoetools

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/Documentation/aoe/aoe.txt b/Documentation/aoe/aoe.txt
--- a/Documentation/aoe/aoe.txt	2005-04-20 11:42:20.000000000 -0400
+++ b/Documentation/aoe/aoe.txt	2005-04-20 11:42:21.000000000 -0400
@@ -4,6 +4,16 @@ The EtherDrive (R) HOWTO for users of 2.
 
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
@@ -33,19 +43,17 @@ USING DEVICE NODES
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
 
@@ -69,7 +77,8 @@ USING SYSFS
   through which we are communicating with the remote AoE device.
 
   There is a script in this directory that formats this information
-  in a convenient way.
+  in a convenient way.  Users with aoetools can use the aoe-stat
+  command.
 
   root@makki root# sh Documentation/aoe/status.sh 
      e10.0            eth3              up
@@ -101,9 +110,9 @@ USING SYSFS
   written to.
 
   It's helpful to trigger discovery after setting the list of allowed
-  interfaces.  If your distro provides an aoe-discover script, you can
-  use that.  Otherwise, you can directly use the /dev/etherd/discover
-  file described above.
+  interfaces.  The aoetools package provides an aoe-discover script
+  for this purpose.  You can also directly use the
+  /dev/etherd/discover special file described above.
 
 DRIVER OPTIONS
 


-- 
  Ed L. Cashin <ecashin@coraid.com>

