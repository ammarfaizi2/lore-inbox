Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132074AbQLQMy7>; Sun, 17 Dec 2000 07:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132107AbQLQMyt>; Sun, 17 Dec 2000 07:54:49 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:43165 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132074AbQLQMyb>; Sun, 17 Dec 2000 07:54:31 -0500
Date: Sun, 17 Dec 2000 12:24:04 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0-test13-pre2: mark CONFIG_PARPORT_PC_FIFO experimental
Message-ID: <20001217122404.C19671@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a patch that marks CONFIG_PARPORT_PC_FIFO experimental.

Tim.
*/

2000-12-14  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/Config.in: Mark CONFIG_PARPORT_PC_FIFO
	experimental.
	* drivers/parport/ChangeLog: Updated.

--- linux-2.4.0-test13-pre1/drivers/parport/Config.in.fifoexp	Thu Jun 29 10:20:36 2000
+++ linux-2.4.0-test13-pre1/drivers/parport/Config.in	Thu Dec 14 11:38:53 2000
@@ -12,7 +12,7 @@
 if [ "$CONFIG_PARPORT" != "n" ]; then
    dep_tristate '  PC-style hardware' CONFIG_PARPORT_PC $CONFIG_PARPORT
    if [ "$CONFIG_PARPORT_PC" != "n" ]; then
-      bool '    Use FIFO/DMA if available' CONFIG_PARPORT_PC_FIFO
+      bool '    Use FIFO/DMA if available (EXPERIMENTAL)' CONFIG_PARPORT_PC_FIFO
       if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
          bool '    SuperIO chipset support (EXPERIMENTAL)' CONFIG_PARPORT_PC_SUPERIO
       fi
--- linux-2.4.0-test13-pre1+/drivers/parport/ChangeLog.fifoexp	Fri Dec 15 11:33:52 2000
+++ linux-2.4.0-test13-pre1+/drivers/parport/ChangeLog	Fri Dec 15 11:34:03 2000
@@ -0,0 +1,4 @@
+2000-12-14  Tim Waugh  <twaugh@redhat.com>
+
+	* Config.in: Mark CONFIG_PARPORT_PC_FIFO experimental.
+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
