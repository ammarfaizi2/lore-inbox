Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWADV7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWADV7f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWADV7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:59:35 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:43249 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S1030291AbWADV7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:59:35 -0500
Date: Wed, 04 Jan 2006 16:59:02 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 0/15] Ubuntu patch sync
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Message-id: <0ISL003P992UCY@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are just attempts to merge code from the ubuntu kernel tree.
This is most of the differences between our tree and stock code (not
necessarily all differences, since we do have a lot of external drivers
pulled in).

You can pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6.git ubuntu-fixes

Or:

	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bcollins/ubuntu-2.6.git ubuntu-fixes

diffstat:
 arch/i386/kernel/acpi/boot.c                 |   10 ++
 arch/i386/kernel/acpi/boot.c                 |   10 ++
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c   |   10 ++
 arch/i386/kernel/cpu/cpufreq/powernow-k7.c   |   11 +-
 arch/i386/kernel/reboot.c                    |    9 ++
 arch/i386/pci/fixup.c                        |    8 +-
 drivers/acpi/asus_acpi.c                     |   11 +-
 drivers/acpi/processor_idle.c                |   68 +++++++++++++----
 drivers/char/sonypi.c                        |   46 +++++++++++-
 drivers/input/misc/wistron_btns.c            |   20 ++++-
 drivers/input/serio/i8042-x86ia64io.h        |    9 ++
 drivers/macintosh/therm_adt746x.c            |   40 ++++++----
 drivers/macintosh/via-pmu.c                  |    5 +
 drivers/net/irda/nsc-ircc.c                  |  103 +++++++++++++++++++++++++--
 kernel/workqueue.c                           |    6 +
 scripts/kconfig/conf.c                       |   19 ++++
 16 files changed, 323 insertions(+), 62 deletions(-)
