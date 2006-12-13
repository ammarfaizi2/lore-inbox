Return-Path: <linux-kernel-owner+w=401wt.eu-S932627AbWLMJO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWLMJO6 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932633AbWLMJO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:14:58 -0500
Received: from zone4.gcu.info ([217.195.17.234]:51768 "EHLO
	zone4.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbWLMJO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:14:56 -0500
X-Greylist: delayed 724 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:14:56 EST
Date: Wed, 13 Dec 2006 10:05:50 +0100 (CET)
To: torvalds@osdl.org
Subject: [GIT PULL] hwmon updates for 2.6.20
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <nCthjst9.1166000750.6131770.khali@localhost>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the hwmon subsystem updates for Linux 2.6.20 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

There are two new hardware monitoring drivers (for the Winbond W83793 and
the Nat. Semi. PC87427), many improvements to the f71805f driver
(including support for the F71872F/FG and for fan speed control) and a
few fixes in individual drivers.

 Documentation/feature-removal-schedule.txt |    9
 Documentation/hwmon/f71805f                |   56
 Documentation/hwmon/it87                   |   15
 Documentation/hwmon/k8temp                 |    2
 Documentation/hwmon/pc87427                |   38
 Documentation/hwmon/sysfs-interface        |    4
 Documentation/hwmon/w83627ehf              |    2
 Documentation/hwmon/w83791d                |    2
 Documentation/hwmon/w83793                 |  110 +
 MAINTAINERS                                |   15
 drivers/hwmon/Kconfig                      |   56
 drivers/hwmon/Makefile                     |    3
 drivers/hwmon/ams/Makefile                 |    8
 drivers/hwmon/ams/ams-core.c               |  265 +++
 drivers/hwmon/ams/ams-i2c.c                |  299 +++
 drivers/hwmon/ams/ams-input.c              |  160 ++
 drivers/hwmon/ams/ams-pmu.c                |  207 ++
 drivers/hwmon/ams/ams.h                    |   72
 drivers/hwmon/f71805f.c                    |  569 ++++++-
 drivers/hwmon/hdaps.c                      |   68
 drivers/hwmon/hwmon-vid.c                  |    4
 drivers/hwmon/it87.c                       |  202 --
 drivers/hwmon/k8temp.c                     |    4
 drivers/hwmon/pc87360.c                    |    2
 drivers/hwmon/pc87427.c                    |  627 ++++++++
 drivers/hwmon/w83627ehf.c                  |    2
 drivers/hwmon/w83792d.c                    |    2
 drivers/hwmon/w83793.c                     | 1609 +++++++++++++++++++++
 drivers/i2c/busses/i2c-ali1563.c           |    2
 include/linux/i2c-id.h                     |    1
 30 files changed, 4115 insertions(+), 300 deletions(-)
 create mode 100644 Documentation/hwmon/pc87427
 create mode 100644 Documentation/hwmon/w83793
 create mode 100644 drivers/hwmon/ams/Makefile
 create mode 100644 drivers/hwmon/ams/ams-core.c
 create mode 100644 drivers/hwmon/ams/ams-i2c.c
 create mode 100644 drivers/hwmon/ams/ams-input.c
 create mode 100644 drivers/hwmon/ams/ams-pmu.c
 create mode 100644 drivers/hwmon/ams/ams.h
 create mode 100644 drivers/hwmon/pc87427.c
 create mode 100644 drivers/hwmon/w83793.c

---------------

Jean Delvare:
      hwmon/f71805f: Store the fan control registers
      hwmon/f71805f: Add manual fan speed control
      hwmon/f71805f: Let the user adjust the PWM base frequency
      hwmon/f71805f: Support DC fan speed control mode
      hwmon/f71805f: Add support for "speed mode" fan speed control
      hwmon/f71805f: Document the fan control features
      hwmon/hdaps: Move the DMI detection data to .data
      hwmon/it87: Remove the SMBus interface support
      hwmon: New PC87427 hardware monitoring driver
      hwmon/f71805f: Add support for the Fintek F71872F/FG chip
      hwmon/f71805f: Always create all fan inputs
      hwmon/f71805f: Fix the device address decoding
      hwmon: Update Rudolf Marek's e-mail address

Jim Cromie:
      hwmon/pc87360: Autodetect the VRM version

Rudolf Marek:
      hwmon: New Winbond W83793 hardware monitoring driver
      hwmon/w83793: Add documentation and maintainer

Stelian Pop:
      hwmon: New AMS hardware monitoring driver
      hwmon: Add MAINTAINERS entry for new ams driver

Stephan Berberig:
      hwmon/hdaps: Update the list of supported devices

Thanks,
--
Jean Delvare
