Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967489AbWLEKnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967489AbWLEKnk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937500AbWLEKnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:43:39 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:41099 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937499AbWLEKnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:43:39 -0500
Message-ID: <45754D58.8040305@ccr.jussieu.fr>
Date: Tue, 05 Dec 2006 11:43:36 +0100
From: Bernard Pidoux <pidoux@ccr.jussieu.fr>
Organization: Universite Pierre & Marie Curie - Paris 6
User-Agent: Thunderbird 1.5.0.8 (X11/20061109)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [kernel-2.6.18.5]  Make install keeps asking dm_mirror module
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying a few compile options I selected once Multidevice-support
RAID.

Then I disabled this option in doing menuconfig and saving the config.

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

Since then, despite I deleted /lib/modules/2.6.18.5 and completely
untared kernel source into a new directory, "make install" keeps on
asking for mirror module.

I eventually made an oldconfig from previously installed linux-2.6.18.3
.config with the same result.

Here is what I get after make, make modules_install :

[root@bernard linux]# make install
sh /usr/src/linux-2.6.18.5/arch/i386/boot/install.sh 2.6.18.5
arch/i386/boot/bzImage System.map "/boot"
FATAL: Module dm_mirror not found.
FATAL: Module dm_mirror not found.
FATAL: Module dm_mod not found.
FATAL: Module dm_mod not found.
Looking for deps of module initramfs
Looking for deps of module atkbd
Looking for deps of module ide-mod
Looking for deps of module ide-probe-mod
Looking for deps of module ide-core
Looking for deps of module ide-disk
Looking for deps of module ext3
         jbd
Looking for deps of module jbd
Looking for deps of module lzf
Using modules:  ./kernel/fs/jbd/jbd.ko ./kernel/fs/ext3/ext3.ko
Using /root/tmp as temporary directory.
...

Any suggestion for removing this dependency ?


Bernard Pidoux

