Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTDUWWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbTDUWWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:22:37 -0400
Received: from outbound04.telus.net ([199.185.220.223]:45234 "EHLO
	priv-edtnes16-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S262406AbTDUWWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:22:36 -0400
Subject: 2.5.67 and QM_MODULES
From: Bob Gill <gillb4@telusplanet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Apr 2003 16:35:11 -0600
Message-Id: <1050964512.1539.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can build kernel 2.5.67 just fine.  I boot the kernel, and get
'QM_MODULES is unsupported'.  I have already upgraded modutils to
version modutils-2.4.25 and module-init-tools-0.9.11a --and still get
the error message in dmesg 'QM_MODULES is unsupported'.  I didn't see
any version information for modutils in linux/Documentation/Changes. I
can run the script which follows and get all of the modules to load (and
then manually mount reiserfs drives, etc), but I would prefer all of
this magic and wonder to happen at boot time.  Is there a way of making
this happen?  --stand on one foot with the opposite hand in the air
while pressing return...??? 

Thanks in advance,

Bob

#!/bin/bash
# manually load modules for 2.6.67 kernel
$MODPROBE = /sbin/insmod
$MODPROBE /lib/modules/2.5.68/kernel/sound/soundcore.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/char/agp/agpgart.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/char/agp/sis-agp.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/char/nvram.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/ieee1394/sbp2.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/ieee1394/ohci1394.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/ieee1394/raw1394.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/ieee1394/ieee1394.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/scsi/imm.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/media/video/tuner.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/media/video/bttv.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/media/video/videodev.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/i2c/i2c-algo-bit.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/i2c/i2c-core.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/net/sis900.ko
$MODPROBE /lib/modules/2.5.68/kernel/drivers/scsi/ide-scsi.ko
$MODPROBE /lib/modules/2.5.68/kernel/fs/reiserfs/reiserfs.ko



