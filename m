Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUEKJxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUEKJxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEKJxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:53:20 -0400
Received: from se1.ruf.uni-freiburg.de ([132.230.2.221]:23771 "EHLO
	se1.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S262730AbUEKJxD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:53:03 -0400
X-Scanned: Tue, 11 May 2004 11:51:58 +0200 Nokia Message Protector V1.3.30 2004040916 - RELEASE
To: Bart Samwel <bart@samwel.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Patch: doc. bug: Linux 2.6.6 laptop-mode 
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 11 May 2004 11:51:56 +0200
Message-ID: <xb7pt9bqojn.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The script  /etc/acpi/actions/battery.sh in the  document doesn't run,
because of a wrong name.


--- linux-2.6.6/Documentation/laptop-mode.txt	2004/05/11 09:46:04	1.1
+++ linux-2.6.6-laptopmode-docfix/Documentation/laptop-mode.txt	2004/05/11 09:48:17	1.2
@@ -466,29 +466,29 @@
 ACAD_HD=244
 BATT_HD=4
 
 # ac/battery event handler
 
 status=`awk '/^state: / { print $2 }' /proc/acpi/ac_adapter/AC/state`
 
 case $status in
         "on-line")
                 echo "Setting HD spindown to 2 hours"
-                /sbin/laptop-mode stop
+                /sbin/laptop_mode stop
                 /sbin/hdparm -S $ACAD_HD /dev/hda > /dev/null 2>&1
                 /sbin/hdparm -B 255 /dev/hda > /dev/null 2>&1
                 #echo -n $ACAD_CPU:$ACAD_THR > /proc/acpi/processor/CPU0/limit
                 exit 0
         ;;
         "off-line")
                 echo "Setting HD spindown to 20 seconds"
-                /sbin/laptop-mode start
+                /sbin/laptop_mode start
                 /sbin/hdparm -S $BATT_HD /dev/hda > /dev/null 2>&1
                 /sbin/hdparm -B 1 /dev/hda > /dev/null 2>&1
                 #echo -n $BATT_CPU:$BATT_THR > /proc/acpi/processor/CPU0/limit
                 exit 0
         ;;
 esac
 ---------------------------/etc/acpi/actions/battery.sh END-------------------------------------------
 
 Monitoring tool
 ---------------



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

