Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272258AbTHNJHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTHNJHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:07:21 -0400
Received: from smtp1.BelWue.de ([129.143.2.12]:35324 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id S272258AbTHNJHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:07:20 -0400
Date: Thu, 14 Aug 2003 11:07:17 +0200 (CEST)
From: Oliver Tennert <tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6 kbuild config logic and initrd
Message-ID: <Pine.LNX.4.44.0308141100280.12796-100000@picard.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

While trying to use initrds with the 2.6.0-test3 kernel,
I found out that ramdisk support (CONFIG_BLK_DEV_RAM) is allowed to be
modular, while at the same time initrd support (CONFIG_BLK_DEV_INITRD) can be
compiled into the kernel:

CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_INITRD=y

This does not make sense, however, as no initial ramdisk can be loaded
while the generic ramdisk driver is outside the static kernel part!

Consequently, I promptly fell for it, though I agree that it should have
come to my mind before actually compiling the kernel!

In 2.4 kernels, the configuration logic does not allow that.


Regards

Oliver


--
________________________________________creating IT solutions

Dr. Oliver Tennert			science + computing ag
phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
O.Tennert@science-computing.de		www.science-computing.de



