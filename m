Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751636AbVJ1OH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbVJ1OH0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbVJ1OHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:07:25 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49150 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751636AbVJ1OHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:07:23 -0400
Date: Fri, 28 Oct 2005 16:07:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 4/14] s390: documentation update.
Message-ID: <20051028140730.GD7300@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cohuck@de.ibm.com>

[patch 4/14] s390: documentation update.

Fix typos and add a section about cpus in the driver-model documentation.

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/driver-model.txt |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff -urpN linux-2.6/Documentation/s390/driver-model.txt linux-2.6-patched/Documentation/s390/driver-model.txt
--- linux-2.6/Documentation/s390/driver-model.txt	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/Documentation/s390/driver-model.txt	2005-10-28 14:04:46.000000000 +0200
@@ -8,11 +8,10 @@ All devices which can be addressed by me
 even if they aren't actually driven by ccws.
 
 All ccw devices are accessed via a subchannel, this is reflected in the 
-structures under root/:
+structures under devices/:
 
-root/
-     - sys
-     - legacy
+devices/
+     - system/
      - css0/
            - 0.0.0000/0.0.0815/
 	   - 0.0.0001/0.0.4711/
@@ -36,7 +35,7 @@ availability: Can be 'good' or 'boxed'; 
 
 online:     An interface to set the device online and offline.
 	    In the special case of the device being disconnected (see the
-	    notify function under 1.2), piping 0 to online will focibly delete
+	    notify function under 1.2), piping 0 to online will forcibly delete
 	    the device.
 
 The device drivers can add entries to export per-device data and interfaces.
@@ -222,7 +221,7 @@ and are called 'chp0.<chpid>'. They have
 Please note, that unlike /proc/chpids in 2.4, the channel path objects reflect
 only the logical state and not the physical state, since we cannot track the
 latter consistently due to lacking machine support (we don't need to be aware
-of anyway).
+of it anyway).
 
 status - Can be 'online' or 'offline'.
 	 Piping 'on' or 'off' sets the chpid logically online/offline.
@@ -235,12 +234,16 @@ status - Can be 'online' or 'offline'.
 3. System devices
 -----------------
 
-Note: cpus may yet be added here.
-
 3.1 xpram 
 ---------
 
-xpram shows up under sys/ as 'xpram'.
+xpram shows up under devices/system/ as 'xpram'.
+
+3.2 cpus
+--------
+
+For each cpu, a directory is created under devices/system/cpu/. Each cpu has an
+attribute 'online' which can be 0 or 1.
 
 
 4. Other devices
