Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbTFWNSZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266026AbTFWNQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:16:08 -0400
Received: from nycsmtp5out-eri0.rdc-nyc.rr.com ([24.29.99.228]:34495 "EHLO
	nycsmtp5out-eri0.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S266030AbTFWNPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:15:25 -0400
Message-ID: <3EF7010C.5090000@sixbit.org>
Date: Mon, 23 Jun 2003 09:30:52 -0400
From: John Weber <weber@sixbit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.73 Mouse
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My mouse suddenly stopped working with 2.5.73.  I am using a Synaptics 
Touchpad --
with comes with a Dell laptop.  (I will test with an external mouse later).

The SERIO I8042 driver seems to find my mouse, interrupts are firing, 
and I enabled
the old /dev/psaux so that userland doesn't see anything different. 
Most importantly,
the same config worked with 2.5.72.  I noticed that dmesg was slightly 
different across
the two versions which suggests that something did change.

--- dmesg-2.5.72        2003-06-23 09:11:32.000000000 -0400
+++ dmesg-2.5.73        2003-06-23 09:12:52.000000000 -0400
@@ -1,21 +1,4 @@
-1d490
-pass
-page 3
-f79c892a338f4a8b
-pass
-
-testing des ecb encryption chunking scenario B
-page 1
-c957
-pass
-page 2
-44
-pass
-page 3
-256a5e
-pass
-page 4
-d31df79c892a338f4a8bb49926f71fe1d490
+1fe1d490
  pass

  testing des ecb encryption chunking scenario C
@@ -523,7 +506,15 @@
  serio: i8042 AUX0 port at 0x60,0x64 irq 12
  serio: i8042 AUX1 port at 0x60,0x64 irq 12
  serio: i8042 AUX2 port at 0x60,0x64 irq 12
-input: PS/2 Synaptics TouchPad on isa0060/serio4
+Synaptics Touchpad, model: 1
+ Firware: 5.8
+ 180 degree mounted touchpad
+ Sensor: 18
+ new absolute packet format
+ Touchpad has extended capability bits
+ -> multifinger detection
+ -> palm detection
+input: Synaptics Synaptics TouchPad on isa0060/serio4
  serio: i8042 AUX3 port at 0x60,0x64 irq 12
  input: AT Set 2 keyboard on isa0060/serio0
  serio: i8042 KBD port at 0x60,0x64 irq 1
@@ -548,7 +539,7 @@
  Initializing IPsec netlink socket
  NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
  VFS: Mounted root (ext2 filesystem) readonly.
-Freeing unused kernel memory: 172k freed
+Freeing unused kernel memory: 176k freed
  Adding 498004k swap on /dev/hda2.  Priority:-1 extents:1

Any suggestions?

