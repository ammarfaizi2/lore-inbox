Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265745AbUFIMUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUFIMUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265747AbUFIMUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:20:03 -0400
Received: from linux2.isphuset.no ([213.236.237.186]:40403 "EHLO
	gtw.mailserveren.com") by vger.kernel.org with ESMTP
	id S265745AbUFIMTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:19:53 -0400
Subject: ACPI / cpu temperature problem
From: Hans Kristian Rosbach <hans.kristian@isphuset.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: ISPHuset Nordic AS
Message-Id: <1086783539.14784.24.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 14:19:00 +0200
Content-Transfer-Encoding: 7bit
X-Declude-Sender: hans.kristian@isphuset.no [195.159.151.115]
X-Note: This E-mail was scanned by Declude JunkMail (www.declude.com) for spam.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, recently we bought 12 identical Supermicro servers. On these
we run Fedora Core 2 with all available updates through yum.

On most of our other servers we have the ability to monitor the
cpu temperature through '/proc/acpi/thermal_zone/THRM/temperature'
and this works fine. We monitor most servers using rrd graphs.

Now, the problem with all these supermicro servers is that the
temperature seems to be stuck at 27 C. No matter what load or
temperature in the room. Something is clearly wrong.
What can be done to fix this? We tried setting polling_frequency
to '10', but that made no difference.

What can be done to fix this? Btw, lm_sensors finds no chips.

The specs of the model can be found here:
http://www.supermicro.com/products/system/1U/5013/SYS-5013C-T.cfm

Some maybe useful info follows:
-------------------------------

# cat /proc/version
Linux version 2.6.5-1.358smp (bhcompile@bugs.build.redhat.com) (gcc
version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Sat May 8
09:25:36 EDT 2004

# cat /proc/acpi/thermal_zone/THRM/temperature
temperature:             27 C

# lspci
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI
Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev
02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage
Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev
02)
01:09.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
01:0a.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet
Controller (Copper)
01:0b.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet
Controller (Copper)

# sensors
No sensors found!
# sensors -v
sensors version 2.8.6

during boot:
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (27 C)
ACPI: (supports S0 S1 S4 S5)
ACPI: Power Button (FF) [PWRF]


Sincerly
   Hans K. Rosbach

